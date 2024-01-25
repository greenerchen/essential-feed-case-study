//
//  ImageCommentsLocalizationTests.swift
//  EssentialFeedsTests
//
//  Created by Greener Chen on 2023/12/18.
//

import XCTest
import EssentialFeed

final class ImageCommentsLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "ImageComments"
        let presentationBundle = Bundle(for: ImageCommentsPresenter.self)
        
        assertLocalizedKeyAndValueExist(in: presentationBundle, table)
    }

}
