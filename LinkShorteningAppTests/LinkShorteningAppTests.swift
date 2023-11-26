//
//  LinkShorteningAppTests.swift
//  LinkShorteningAppTests
//
//  Created by Nurul Islam on 16/1/23.
//

import XCTest
@testable import LinkShorteningApp
import Combine

final class LinkShorteningAppTests: XCTestCase {
    var sut: URLSession!
    var networkMonitor: NetworkMonitor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
        networkMonitor = NetworkMonitor()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_Mapping_API_Response_Data_With_ValidRequest_Returns_ValidResponse() async throws {
        
        try XCTSkipUnless(networkMonitor.isConnected, "Network connectivity needed for this test.")
        
        // ARRANGE
        let shortLink = "https://facebook.com"
        let payload = LinkInfoPayload(link: shortLink)
        let fetcher = RecentLinkApiService(networkMonitor: networkMonitor)
        let expectation = self.expectation(description: "ValidRequest_Returns_ValidResponse")
        
        // ACT
        let response = await fetcher.getRecentLinkDetailsInfo(payload: payload)
        switch response {
        case .success(let result):
            // ASSERT
            XCTAssertNotNil(result)
            expectation.fulfill()
        case .failure(_): break
        }
        
        await waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_Mapping_Database_Response_With_ValidRequest_Returns_ValidData_When_Data_Exists_In_DB() async throws {
        
        // ARRANGE
        let dataController = DataController()
        let dataRepository = LinksDataRepository(handler: DatabaseHandler(context: dataController.container.viewContext), context: dataController.container.viewContext)
        let expectation = self.expectation(description: "ValidRequest_Returns_ValidResponse")
        
        // ACT
        let fetchedResults = await dataRepository.fetchAll()
        
        // ASSERT
        XCTAssertNotNil(fetchedResults)
        XCTAssertNotEqual(0, fetchedResults.count)
        expectation.fulfill()
        
        await waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_Mapping_Database_Response_With_ValidRequest_Returns_ValidData_When_Data_Not_Exists_In_DB() async throws {
        
        // ARRANGE
        let dataController = DataController()
        let dataRepository = LinksDataRepository(handler: DatabaseHandler(context: dataController.container.viewContext), context: dataController.container.viewContext)
        let expectation = self.expectation(description: "ValidRequest_Returns_ValidResponse")
        
        // ACT
        let fetchedResults = await dataRepository.fetchAll()
        
        // ASSERT
        XCTAssertNotNil(fetchedResults)
        XCTAssertEqual(0, fetchedResults.count)
        expectation.fulfill()
        
        await waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_Valid_Url_Without_Http_Returns_Valid_Response_From_Api() async throws {
        
        try XCTSkipUnless(networkMonitor.isConnected, "Network connectivity needed for this test.")
        
        // ARRANGE
        let shortLink = "facebook.com"
        let payload = LinkInfoPayload(link: shortLink.validURL)
        let fetcher = RecentLinkApiService(networkMonitor: networkMonitor)
        let expectation = self.expectation(description: "ValidRequest_Returns_ValidResponse")
        
        // ACT
        let response = await fetcher.getRecentLinkDetailsInfo(payload: payload)
        switch response {
        case .success(let result):
            // ASSERT
            XCTAssertNotNil(result)
            expectation.fulfill()
        case .failure(_): break
        }
        
        await waitForExpectations(timeout: 5, handler: nil)
    }
}
