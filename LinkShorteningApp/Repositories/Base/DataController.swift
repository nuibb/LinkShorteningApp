//
//  DataController.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 18/1/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "LinksModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("\(DbStatus.loadingFailed): \(error.localizedDescription)")
            }
        }
    }
}
