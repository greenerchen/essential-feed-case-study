//
//  EssentialFeedsAPIEndToEndTests.swift
//  EssentialFeedsAPIEndToEndTests
//
//  Created by Greener Chen on 2023/3/24.
//

import XCTest
import Combine
import EssentialFeed

final class EssentialFeedsAPIEndToEndTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func demo_globalStateCrossTestExecution() {
//        let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
//        let configuration = URLSessionConfiguration.default
//        configuration.urlCache = cache
//        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
//        let session = URLSession(configuration: configuration)
//        
//        let url = URL(string: "http://any-url.com")!
//        let request = URLRequest(url: url, cachePolicy: .returnCacheDataDontLoad, timeoutInterval: 30)
//        
//        // mutate global state that we should avoid
//        URLCache.shared = cache
//    }
    
    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() throws {
        switch getFeedResult() {
        case let .success(imageFeed)?:
            XCTAssertEqual(imageFeed.count, 8, "Expected 8 images in the test account image feed")
            
            XCTAssertEqual(imageFeed[0], expectedImage(at: 0))
            XCTAssertEqual(imageFeed[1], expectedImage(at: 1))
            XCTAssertEqual(imageFeed[2], expectedImage(at: 2))
            XCTAssertEqual(imageFeed[3], expectedImage(at: 3))
            XCTAssertEqual(imageFeed[4], expectedImage(at: 4))
            XCTAssertEqual(imageFeed[5], expectedImage(at: 5))
            XCTAssertEqual(imageFeed[6], expectedImage(at: 6))
            XCTAssertEqual(imageFeed[7], expectedImage(at: 7))
            
        case let .failure(error)?:
            XCTFail("Expected successful feed result, got \(error) instead")
        default:
            XCTFail("Expected successful feed result, got no result instead")
        }
    }
    
    func test_endToEndTestServerGETFeedImageDataResult_matchesFixedTestAccountData() {
        switch getFeedImageDataResult() {
        case let .success(data):
            XCTAssertFalse(data.isEmpty, "Expected non-empty image data")
        case let .failure(error):
            XCTFail("Expected successful image data, but got \(error) instead")
        default:
            XCTFail("Expected successful image data, but got no result instead")
        }
    }
    
    // MARK: - Helpers
    
    private func getFeedResult(file: StaticString = #file, line: UInt = #line) -> Swift.Result<[FeedImage], Error>? {
        let client = ephemeralClient()
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: Swift.Result<[FeedImage], Error>?
        client.get(from: feedTestServerURL) { result in
            receivedResult = result.flatMap({ (data, response) in
                do {
                    return .success(try FeedItemsMapper.map(data, from: response))
                } catch {
                    return .failure(error)
                }
            })
            
            exp.fulfill()
        }
        wait(for: [exp], timeout: 6.0)
        
        return receivedResult
    }
    
    private func getFeedImageDataResult(file: StaticString = #file, line: UInt = #line) -> Result<Data, Error>? {
        let url = feedTestServerURL.appending(component: "73A7F70C-75DA-4C2E-B5A3-EED40DC53AA6/image")
        let client = ephemeralClient()
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: Result<Data, Error>?
        client.get(from: url) { result in
            receivedResult = result.flatMap({ (data, response) in
                do {
                    return .success(try FeedImageDataMapper.map(data, from: response))
                } catch {
                    return .failure(error)
                }
            })
            
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        
        return receivedResult
    }
    
    private var feedTestServerURL: URL {
        URL(string: "https://essentialdeveloper.com/feed-case-study/test-api/feed")!
    }
    
    private func ephemeralClient(file: StaticString = #file, line: UInt = #line) -> HTTPClient {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        trackForMemoryLeaks(client, file: file, line: line)
        return client
    }
    
    private func expectedImage(at index: Int) -> FeedImage {
        FeedImage(
            id: id(at: index),
            description: description(at: index),
            location: location(at: index),
            url: imageURL(at: index)
        )
    }
    
    private func id(at index: Int) -> UUID {
        UUID(uuidString: [
            "73A7F70C-75DA-4C2E-B5A3-EED40DC53AA6",
            "BA298A85-6275-48D3-8315-9C8F7C1CD109",
            "5A0D45B3-8E26-4385-8C5D-213E160A5E3C",
            "FF0ECFE2-2879-403F-8DBE-A83B4010B340",
            "DC97EF5E-2CC9-4905-A8AD-3C351C311001",
            "557D87F1-25D3-4D77-82E9-364B2ED9CB30",
            "A83284EF-C2DF-415D-AB73-2A9B8B04950B",
            "F79BD7F8-063F-46E2-8147-A67635C3BB01"
        ][index])!
    }
    
    private func description(at index: Int) -> String? {
        [
            "Description 1",
            nil,
            "Description 3",
            nil,
            "Description 5",
            "Description 6",
            "Description 7",
            "Description 8"
        ][index]
    }
    
    private func location(at index: Int) -> String? {
        [
            "Location 1",
            "Location 2",
            nil,
            nil,
            "Location 5",
            "Location 6",
            "Location 7",
            "Location 8"
        ][index]
    }
    
    private func imageURL(at index: Int) -> URL {
        [
            URL(string: "https://url-1.com")!,
            URL(string: "https://url-2.com")!,
            URL(string: "https://url-3.com")!,
            URL(string: "https://url-4.com")!,
            URL(string: "https://url-5.com")!,
            URL(string: "https://url-6.com")!,
            URL(string: "https://url-7.com")!,
            URL(string: "https://url-8.com")!
        ][index]
    }
}
