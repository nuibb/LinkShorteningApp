//
//  DatabaseHandler.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import CoreData

class DatabaseHandler {
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create<T: NSManagedObject>(_ type: T.Type) async -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return nil }
        let object = T(entity: entity, insertInto: context)
        return object
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type, with predicate: NSPredicate? = nil) async -> [T] {
        let request = T.fetchRequest()
        
        if let pred = predicate {
            request.predicate = pred
        }
        
        do {
            let result = try context.fetch(request)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func delete<T: NSManagedObject>(object: T) async {
        context.delete(object)
        await save()
    }
    
    func save() async {
        if self.context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

