//
//  Stubs.swift
//  EssentialFeedsiOSTests
//
//  Created by Greener Chen on 2023/9/18.
//

import XCTest
import EssentialFeeds

extension FeedUIIntegrationTests {
    func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for \(key) in the table: \(table)", file: file, line: line)
        }
        return value
    }
}
