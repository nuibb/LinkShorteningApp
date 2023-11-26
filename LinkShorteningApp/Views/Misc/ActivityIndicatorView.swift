//
//  ActivityIndicatorView.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 20/1/23.
//

import UIKit
import SwiftUI

extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView)->Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}

struct ActivityIndicator: UIViewRepresentable {
    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    
    var configuration = { (indicator: UIView) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}
