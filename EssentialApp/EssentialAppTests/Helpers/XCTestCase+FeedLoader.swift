//
//  XCTestCase+FeedLoader.swift
//  EssentialAppTests
//
//  Created by Greener Chen on 2023/11/21.
//

import XCTest
import EssentialFeed

protocol FeedLoaderTestCase: XCTestCase {}

extension FeedLoaderTestCase {
    func expect(_ sut: LocalFeedLoader, toCompleteWith expectedResult: Swift.Result<[FeedImage], Error>, file: StaticString = #file, line: UInt = #line) {
        let receivedResult = Result { try sut.load() }
        
        switch (receivedResult, expectedResult) {
        case let (.success(receivedFeed), .success(expectedFeed)):
            XCTAssertEqual(receivedFeed, expectedFeed, file: file, line: line)
            
        case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
            XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            
        default:
            XCTFail("Expected result \(expectedResult), but got \(receivedResult) instead", file: file, line: line)
        }
    }
}
