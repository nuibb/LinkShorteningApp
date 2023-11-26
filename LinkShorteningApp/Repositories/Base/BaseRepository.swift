//
//  BaseRepository.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import Foundation
import CoreData

protocol BaseRepository {
    associatedtype T
    
    func create(record: T) async -> DbStatus
    func fetchAll() async -> [T]
    func fetch(byIdentifier id: String) async -> T?
    func update(record: T) async -> DbStatus
    func delete(byIdentifier id: String) async -> DbStatus
}

