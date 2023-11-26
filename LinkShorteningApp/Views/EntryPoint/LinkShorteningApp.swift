//
//  LinkShorteningAppApp.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 16/1/23.
//

import SwiftUI

@available(iOS 14.0, *)
struct LinkShorteningApp: App {
    @ObservedObject static var dataController = DataController()
    static let apiService: RecentLinkApiService = RecentLinkApiService(networkMonitor: NetworkMonitor())
    static let dataRepository: LinksDataRepository = LinksDataRepository(handler: DatabaseHandler(context: dataController.container.viewContext), context: dataController.container.viewContext)
    @ObservedObject var viewModel: RecentLinksViewModel = RecentLinksViewModel(recentLinkService: apiService, linksDataRepository: dataRepository)
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                //.environment(\.managedObjectContext, LinkShorteningApp.dataController.container.viewContext)
                .environmentObject(viewModel)
        }
    }
}
