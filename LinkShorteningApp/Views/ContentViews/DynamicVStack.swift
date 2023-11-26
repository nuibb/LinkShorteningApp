//
//  DynamicVStack.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 18/1/23.
//

import SwiftUI

public struct DynamicVStack<Content>: View where Content : View {
    let content: () -> Content
    let spacing: CGFloat?
    
    public init(spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }
    
    @ViewBuilder public var body: some View {
        if #available(iOS 14.0, *) {
            LazyVStack(spacing: spacing, content: self.content)
        } else {
            VStack(spacing: spacing, content: self.content)
        }
    }
}
