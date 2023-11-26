//
//  ToastView.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import SwiftUI

extension View {
    func toast(isShowing: Binding<Bool>, message: String, duration: TimeInterval = 3) -> some View {
        modifier(ToastModifier(isShowing: isShowing, message: message, duration: duration))
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                HStack() {
                    Spacer()
                    Image(systemName: "exclamationmark.circle")
                        .padding(.trailing, 10)
                    Text(message)
                    Spacer()
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.white)
                .foregroundColor(.red)
                .cornerRadius(5)
                .shadow(radius: 5)
                .onAppear {
                    setDuration()
                }
            }
        }
        .padding()
    }
    
    private func setDuration() {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                isShowing = false
            }
        }
    }
}
