//
//  ShortenInfoPayload.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import Foundation

struct LinkInfoPayload: Encodable {
    var long_url : String
    
    init(link: String) {
        self.long_url = link
    }

    enum CodingKeys: String, CodingKey {
        case long_url = "long_url"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(long_url, forKey: .long_url)
    }

}
