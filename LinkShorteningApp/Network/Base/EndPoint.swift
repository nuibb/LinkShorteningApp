//
//  EndPoint.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import Foundation

protocol Endpoint {
    //associatedtype T : Encodable
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String:String] { get }
    //var payload: T? { get set }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api-ssl.bitly.com"
    }
    
    var header: [String: String] {
        // Access Token to use in Basic/Bearer header
        let accessToken = "cb299db0a53afc131c51d2443947eec45eb2041e"
        return [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
    }
}
