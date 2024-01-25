//
//  XCTestCase+FailableDeleteFeedStoreSpecs.swift
//  EssentialFeedsTests
//
//  Created by Greener Chen on 2023/5/8.
//

import XCTest
import EssentialFeed

extension FailableDeleteFeedStoreSpecs where Self: XCTestCase {
    func assertThatDeleteDeliversFailureOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNotNil(deletionError, "Expected cache deletion to fail")
        expect(sut, toRetrieve: .success(.none))
    }
    
    func assertThatDeleteHasNoSideEffectsOnRetrievalError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNotNil(deletionError, "Expected cache deletion to fail")
        expect(sut, toRetrieve: .success(.none))
    }
}
