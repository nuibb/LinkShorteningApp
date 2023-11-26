//
//  ItemView.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 19/1/23.
//

import SwiftUI

struct LinkItemView: View {
    @EnvironmentObject var viewModel: RecentLinksViewModel
    @Binding var item: LinkItemModel
    @State var sheet = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color(red: 0.234, green: 0.567, blue: 0.884), .white]), startPoint: .leading, endPoint: .trailing).cornerRadius(20)
            
            // MARK: Hidden layer with delete button
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeIn) { deleteItem() }
                }) {
                    Image(systemName: "trash.fill")
                        .font(.title)
                        .foregroundColor(.red)
                        .frame(width: 90, height: 40)
                }
            }
            // MARK: Card View
            CardView(sheet: $sheet, shortLink: item.shortLink, longtLink: item.long_url)
                .padding(.horizontal, 8)
                .background(Color(red: 90/255, green: 200/255, blue: 250/255))
                .contentShape(Rectangle())
                .offset(x: item.offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
        }
        .sheet(isPresented:$sheet, onDismiss: {
            
        }, content: {
            ActivityViewController(activityItems: [URL(string: item.shortLink)!])
        })
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0 {
            if item.isSwiped {
                item.offset = value.translation.width - 90
            } else {
                item.offset = value.translation.width
            }
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                if -value.translation.width > UIScreen.main.bounds.width / 2 {
                    item.offset = -1000
                    deleteItem()
                } else if -item.offset > 50 {
                    item.isSwiped = true
                    item.offset = -90
                } else {
                    item.isSwiped = false
                    item.offset = 0
                }
            } else {
                item.isSwiped = false
                item.offset = 0
            }
        }
    }
    
    // Removing Item
    func deleteItem() {
        Task {
            let status = await viewModel.deleteItemFromDb(id: self.item.id)
            if status {
                let index = viewModel.recentLinks.firstIndex(where: { $0.id == item.id })
                guard let index = index else { return }
                viewModel.recentLinks.remove(at: index)
                if viewModel.recentLinks.isEmpty {
                    viewModel.showListView = false
                }
            }
        }
    }
}

struct LinkItemView_Previews: PreviewProvider {
    @State static var item = LinkItemModel(id: "", creteadAt: "", shortLink: "", long_url: "", archived: false)
    static var previews: some View {
        LinkItemView(item: $item)
    }
}
