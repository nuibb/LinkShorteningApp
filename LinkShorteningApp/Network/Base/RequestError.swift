//
//  RequestError.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import Foundation

enum RequestError: Error {
    case encode
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case networkNotAvailable
    case unknown
    
    var customMessage: String {
        switch self {
        case .encode:
            return "Encode error"
        case .decode:
            return "Decode error"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "API response timeout"
        case .unauthorized:
            return "Session expired"
        case .unexpectedStatusCode:
            return "Unexpected status code"
        case .networkNotAvailable:
            return "You are in offline mode!"
        default:
            return "Unknown error"
        }
    }
}
