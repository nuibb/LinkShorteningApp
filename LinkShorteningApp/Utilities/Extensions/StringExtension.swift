//
//  StringExtension.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import Foundation

extension String {
    var convertToISODate: Date  {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        guard let date = formatter.date(from: self) else { return Date() }
        return date
    }
}
