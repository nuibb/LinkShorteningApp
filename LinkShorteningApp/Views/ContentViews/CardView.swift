//
//  CardView.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 19/1/23.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
    }
}

struct CardView: View {
    @EnvironmentObject var viewModel: RecentLinksViewModel
    @Binding var sheet: Bool
    
    var shortLink: String
    var longtLink: String
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center) {
                Spacer()
                
                HStack(alignment: .center) {
                    Text(AppConstants.siteTitle)
                        .headerTitleModifier()
                    Text(longtLink)
                        .siteTextModifier()
                }
                .padding(.horizontal, 8)
                .background(Color.blue)
                .cornerRadius(15)
                .frame(height: 40)
                
                Spacer()
                
                HStack(alignment: .center) {
                    Text(AppConstants.linkTitle)
                        .headerTitleModifier()
                    Text(shortLink)
                        .urlTextModifier()
                }
                .padding(.horizontal, 8)
                .background(Color.purple)
                .cornerRadius(15)
                .frame(height: 40)
                
                Spacer()
            }
            Spacer()
            VStack {
                Button(action: {
                    copyToClipboard()
                }) {
                    Image(systemName: "doc.on.doc")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                }
                
                Button(action: {
                    share()
                }) {
                    Image(systemName: "square.and.arrow.up.circle")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                }
            }
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
    }
}

extension CardView {
    func copyToClipboard() {
        UIPasteboard.general.string = shortLink
        viewModel.toastMessage = AppConstants.copiedToClipboardText
        viewModel.showToast = true
    }
    
    func share() {
        self.sheet.toggle()
    }
}

struct CardView_Previews: PreviewProvider {
    @State static var sheet = false
    static var previews: some View {
        CardView(sheet: $sheet, shortLink: "", longtLink: "")
    }
}
