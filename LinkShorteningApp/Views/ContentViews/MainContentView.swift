//
//  ContentView.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 16/1/23.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var viewModel: RecentLinksViewModel
    @State var presentAlert = false
    @State var showLoader = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.showListView {
                    RecentLinksListView()
                }
                else {
                    EmptyItemsView()
                }
                ActivityIndicator(isAnimating: showLoader)
                    .configure { $0.color = .red }
                    .padding()
                    .background(showLoader ? Color.white : Color.clear)
                    .cornerRadius(100)
            }
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .navigationBarTitle(Text(AppConstants.appTitle), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showAlert()
            }) {
                Image(systemName: "plus")
            })
        }//: NAVIGATION
        .onAppear() {
            Task {
                showLoader.toggle()
                await viewModel.fetchDataFromDb()
                showLoader.toggle()
            }
        }
    }
}

extension MainContentView {
    func showAlert() {
        alertView(title: AppConstants.alertTitleForAddingLink, message: AppConstants.alertMessageForAddingLink, hintText: AppConstants.urlPlaceholderText, primaryTitle: AppConstants.addButtomTextOnAlertView, secondaryTitle: AppConstants.cancelButtomTextOnAlertView) { newLink in
            if newLink.isValidURL {
                Task {
                    showLoader.toggle()
                    await viewModel.getRecentLinkDetailsInfo(link: newLink.validURL)
                    showLoader.toggle()
                }
            }
            else {
                self.viewModel.toastMessage = AppConstants.invalidLinkText
                self.viewModel.showToast = true
            }
        } secondaryAction: {
            print("Cancelled")
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
