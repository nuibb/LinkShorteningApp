//
//  AppMain.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 16/1/23.
//

import UIKit
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        @ObservedObject var dataController = DataController()
        let apiService: RecentLinkApiService = RecentLinkApiService(networkMonitor: NetworkMonitor())
        let dataRepository: LinksDataRepository = LinksDataRepository(handler: DatabaseHandler(context: dataController.container.viewContext), context: dataController.container.viewContext)
        @ObservedObject var viewModel: RecentLinksViewModel = RecentLinksViewModel(recentLinkService: apiService, linksDataRepository: dataRepository)
        window.rootViewController = UIHostingController(rootView: MainContentView()
            //.environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(viewModel))
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
