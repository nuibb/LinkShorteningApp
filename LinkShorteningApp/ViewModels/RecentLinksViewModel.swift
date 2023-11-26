//
//  MyLinksViewModel.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import CoreData
import Foundation
import SwiftUI

@MainActor
final class RecentLinksViewModel: ObservableObject {
    @Published var showToast = false
    @Published var showListView = false
    @Published var recentLinks: [LinkItemModel] = []
    
    var toastMessage: String = ""
    private let recentLinkService: RecentLinkFetchable
    private let linksDataRepository: LinksDataRepository
    
    init(recentLinkService: RecentLinkFetchable, linksDataRepository: LinksDataRepository) {
        self.recentLinkService = recentLinkService
        self.linksDataRepository = linksDataRepository
    }
    
    // MARK: Calling API
    func getRecentLinkDetailsInfo(link: String) async {
        let result = await self.recentLinkService.getRecentLinkDetailsInfo(payload: LinkInfoPayload(link: link))
        switch result {
        case .success(let response):
            if !response.shortLink.isEmpty {
                let status = await self.linksDataRepository.create(record: response)
                if status == .succeed {
                    if recentLinks.isEmpty {
                        recentLinks.append(response)
                        self.showListView = true
                    }
                    else {
                        recentLinks.append(response)
                    }
                }
                else {
                    self.toastMessage = AppConstants.dbRequestStatusText + status.customMessage
                    self.showToast = true
                }
            }
        case .failure(let error):
            //debugPrint(error.customMessage)
            self.toastMessage = AppConstants.apiRequestFailedStatusText + error.customMessage
            self.showToast = true
        }
    }
    
    func fetchDataFromDb() async {
        let fetchedResults: [LinkItemModel] = await self.linksDataRepository.fetchAll()
        if !fetchedResults.isEmpty {
            self.recentLinks = fetchedResults
            self.showListView = true
        }
    }
    
    func deleteItemFromDb(id: String) async -> Bool {
        let status = await self.linksDataRepository.delete(byIdentifier: id)
        if status == .succeed {
            return true
        }
        else {
            self.toastMessage = AppConstants.dbRequestStatusText + status.customMessage
            self.showToast = true
            return false
        }
    }
}
