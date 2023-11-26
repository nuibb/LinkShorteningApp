//
//  ViewExtensionForAlert.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import SwiftUI

extension View {
    // MARK: Alert View
    func alertView(title: String, message: String, hintText: String, primaryTitle: String, secondaryTitle: String, primaryAction: @escaping(String) -> (), secondaryAction: @escaping() -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = hintText
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text {
                primaryAction(text)
            }
            else {
                primaryAction("")
            }
        }))
        
        // MARK: Presenting Alert
        rootController().present(alert, animated: true, completion: nil)
    }
    
    // MARK: Root View Controller
    func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init() }
        guard let root = screen.windows.first?.rootViewController else { return .init() }
        return root
    }
}
