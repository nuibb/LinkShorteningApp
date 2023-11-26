//
//  DbError.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 19/1/23.
//

import Foundation

enum DbStatus: Error {
    case succeed
    case savingFailed
    case loadingFailed
    case editingFailed
    case deletingFailed
    case existsInDB
    case notExistsInDB
    case unknown
    
    var customMessage: String {
        switch self {
        case .succeed:
            return "Successfully done!"
        case .savingFailed:
            return "Failed to save in DB!"
        case .loadingFailed:
            return "Failed to load from DB!"
        case .editingFailed:
            return "Failed to edit the record in DB!"
        case .deletingFailed:
            return "Failed to delete the record from DB!"
        case .existsInDB:
            return "Record already exists in DB."
        case .notExistsInDB:
            return "Record doesn't exists in DB to edit or delete!"
        default:
            return "Unknown error"
        }
    }
}

