//
//  TextExtensions.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 16/1/23.
//

import SwiftUI

extension Text {
    
    func headerTitleModifier() -> some View {
        self
        //.background(.clear)
            .foregroundColor(.white)
            .font(.headline.weight(.bold))
    }
    
    func siteTextModifier() -> some View {
        self
            .foregroundColor(.white)
            .font(.body.weight(.light))
            .multilineTextAlignment(.leading)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .leading)
    }
    
    func urlTextModifier() -> some View {
        self
            .foregroundColor(.white)
            .font(.body.weight(.light))
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .leading)
    }
}
