//
//  ShortenInfoModel.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import Foundation

struct LinkItemModel: Decodable, Identifiable {
    let id: String
    let created_at: String
    let shortLink: String
    var custom_bitlinks: [String] = []
    let long_url: String
    let archived: Bool
    var tags: [String] = []
    var deeplinks: [String] = []
    var references: References? = nil
    var offset: CGFloat = 0.0
    var isSwiped: Bool = false
    
    init(id: String, creteadAt: String, shortLink: String, long_url: String, archived: Bool) {
        self.id = id
        self.created_at = creteadAt
        self.shortLink = shortLink
        self.long_url = long_url
        self.archived = archived
    }
    
    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case link = "link"
        case custom_bitlinks = "custom_bitlinks"
        case long_url = "long_url"
        case archived = "archived"
        case tags = "tags"
        case deeplinks = "deeplinks"
        case references = "references"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at) ?? ""
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        shortLink = try values.decodeIfPresent(String.self, forKey: .link) ?? ""
        custom_bitlinks = try values.decodeIfPresent([String].self, forKey: .custom_bitlinks) ?? []
        long_url = try values.decodeIfPresent(String.self, forKey: .long_url) ?? ""
        archived = try values.decodeIfPresent(Bool.self, forKey: .archived) ?? false
        tags = try values.decodeIfPresent([String].self, forKey: .tags) ?? []
        deeplinks = try values.decodeIfPresent([String].self, forKey: .deeplinks) ?? []
        references = try values.decodeIfPresent(References.self, forKey: .references)
    }
}

struct References : Decodable {
    let group : String
    
    enum CodingKeys: String, CodingKey {
        case group = "group"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        group = try values.decodeIfPresent(String.self, forKey: .group) ?? ""
    }
}
