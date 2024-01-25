//
//  XCTestCase+FailableInsertFeedStoreSpecs.swift
//  EssentialFeedsTests
//
//  Created by Greener Chen on 2023/5/8.
//

import XCTest
import EssentialFeed

extension FailableInsertFeedStoreSpecs where Self: XCTestCase {
    func assertThatInsertOverridesFailureOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let insertionError = insert((uniqueImageFeed().local, Date()), to: sut, file: file, line: line)
        
        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
    }
    
    func assertThatInsertHasNoSideEffectsOnRetrievalError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        insert((uniqueImageFeed().local, Date()), to: sut, file: file, line: line)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
}
