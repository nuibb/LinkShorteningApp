//
//  LinksRepository.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import Foundation
import CoreData

// MARK: Implementing repository design pattern
protocol LinksRepository: BaseRepository {
    
}

struct LinksDataRepository: LinksRepository {
    typealias T = LinkItemModel
    private let handler: DatabaseHandler
    private var context: NSManagedObjectContext
    
    init(handler: DatabaseHandler, context: NSManagedObjectContext) {
        self.handler = handler
        self.context = context
    }
    
    func create(record: LinkItemModel) async -> DbStatus {
        if getCDLink(byId: record.id) != nil { return .existsInDB }
        guard let cdLink = await handler.create(CDLinks.self) else { return .savingFailed }
        cdLink.id = record.id
        cdLink.createdAt = record.created_at.convertToISODate
        cdLink.link = record.shortLink
        cdLink.longUrl = record.long_url
        cdLink.archived = record.archived
        cdLink.referenceGroup = record.references?.group
        await handler.save()
        return .succeed
    }
    
    func fetchAll() async -> [LinkItemModel] {
        let results = await handler.fetch(CDLinks.self)
        var linkInfoList : [LinkItemModel] = []
        results.forEach({ (cdLink) in
            linkInfoList.append(convertToLinkInfo(cdLink: cdLink))
        })
        return linkInfoList
    }
    
    func fetch(byIdentifier id: String) async -> LinkItemModel? {
        let fetchRequest = NSFetchRequest<CDLinks>(entityName: "CDLinks")
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        //let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        //fetchRequest.predicate = predicate
        
        do {
            let result = try self.context.fetch(fetchRequest).first
            guard let result = result else { return nil }
            return convertToLinkInfo(cdLink: result)
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    func update(record: LinkItemModel) async -> DbStatus {
        //let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        //let results = handler.fetch(CDLinks.self, with: predicate)
        
        //guard let cdLinks = handler.add(CDLinks.self) else { return false}
        //cdLinks.id = record.id
        return .unknown
    }
    
    func delete(byIdentifier id: String) async -> DbStatus {
        let cdLink = getCDLink(byId: id)
        guard let cdLink = cdLink else { return .notExistsInDB }
        await handler.delete(object: cdLink)
        return .succeed
    }
    
    func convertToLinkInfo(cdLink: CDLinks) -> LinkItemModel {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dateString = formatter.string(from: (cdLink.createdAt ?? Date()))
        return LinkItemModel(id: cdLink.id ?? "", creteadAt: dateString, shortLink: cdLink.link ?? "", long_url: cdLink.longUrl ?? "", archived: cdLink.archived)
    }
    
    private func getCDLink(byId id: String) -> CDLinks?
    {
        let fetchRequest = NSFetchRequest<CDLinks>(entityName: "CDLinks")
        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = fetchById
        
        let result = try! self.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}
        return result.first
    }
}


