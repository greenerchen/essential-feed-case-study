//
//  FeedPresenterTests.swift
//  EssentialFeedsTests
//
//  Created by Greener Chen on 2023/9/25.
//

import XCTest
import EssentialFeed

final class FeedPresenterTests: XCTestCase {
    
    func test_title_isLocalized() {
        XCTAssertEqual(FeedPresenter.title, localized("FEED_VIEW_TITLE"))
    }
    
    // MARK: - Helpers
    
    private func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for \(key) in the table: \(table)", file: file, line: line)
        }
        return value
    }
}
