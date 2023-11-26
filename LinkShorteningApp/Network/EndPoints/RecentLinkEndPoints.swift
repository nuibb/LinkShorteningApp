//
//  ShortenLinkEndPoints.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import Foundation

enum RecentLinkEndPoints {
    case shortenInfoEndPoint
}

extension RecentLinkEndPoints: Endpoint {
    
    var path: String {
        switch self {
        case .shortenInfoEndPoint:
            return "/v4/shorten"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .shortenInfoEndPoint:
            return .post
        }
    }
}

