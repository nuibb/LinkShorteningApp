//
//  ContentView.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 20/1/23.
//

import SwiftUI

struct RecentLinksListView: View {
    @EnvironmentObject var viewModel: RecentLinksViewModel
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                DynamicVStack(spacing: 10) {
                    ForEach($viewModel.recentLinks) { $item in
                        LinkItemView(item: $item)
                    }
                }
            }
            .toast(isShowing: $viewModel.showToast, message: viewModel.toastMessage)
            .padding(.horizontal, 10)
        }
        .background(Color(red: 90/255, green: 200/255, blue: 250/255))
    }
}

struct RecentLinksListView_Previews: PreviewProvider {
    static var previews: some View {
        RecentLinksListView()
    }
}
