//
//  EmptyItemsView.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 20/1/23.
//

import SwiftUI

struct EmptyItemsView: View {
    var body: some View {
        VStack {
            Text(AppConstants.noItemsText)
                .foregroundColor(Color.black)
                .font(.headline.weight(.medium))
                .multilineTextAlignment(.center)
            Text(AppConstants.addOneText)
                .foregroundColor(Color.black)
                .font(.subheadline.weight(.light))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 20)
        .frame(width: 200, height: 150)
        .background(Color(red: 90/255, green: 200/255, blue: 250/255))
        .modifier(CardModifier())
    }
}

struct EmptyItemsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyItemsView()
    }
}
