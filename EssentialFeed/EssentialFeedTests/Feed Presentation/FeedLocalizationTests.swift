//
//  FeedLocalizationTests.swift
//  EssentialFeedsiOSTests
//
//  Created by Greener Chen on 2023/9/18.
//

import XCTest
import EssentialFeed

final class FeedLocalizationTests: XCTestCase {
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Feed"
        let presentationBundle = Bundle(for: FeedPresenter.self)
        
        assertLocalizedKeyAndValueExist(in: presentationBundle, table)
    }
}
