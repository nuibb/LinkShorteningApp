//
//  ShortenLinkService.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import Foundation

protocol RecentLinkFetchable {
    func getRecentLinkDetailsInfo(payload: LinkInfoPayload) async -> Swift.Result<LinkItemModel, RequestError>
}

struct RecentLinkApiService: HTTPClient, RecentLinkFetchable {
    private let networkMonitor: NetworkMonitor
    
    init(networkMonitor: NetworkMonitor) {
        self.networkMonitor = networkMonitor
    }
    
    func getRecentLinkDetailsInfo(payload: LinkInfoPayload) async -> Swift.Result<LinkItemModel, RequestError> {
        if self.networkMonitor.isConnected {
            return await postRequest(endpoint: RecentLinkEndPoints.shortenInfoEndPoint, payload: payload, responseModel: LinkItemModel.self)
        } else {
            return .failure(.networkNotAvailable)
        }
    }
}


