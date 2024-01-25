//
//  FeedImagePresenterTests.swift
//  EssentialFeedsTests
//
//  Created by Greener Chen on 2023/12/15.
//

import XCTest
import UIKit
import EssentialFeed

final class FeedImagePresenterTests: XCTestCase {

    func test_map_createsViewModels() throws {
        let image = uniqueImage()
        
        let viewModel = FeedImagePresenter.map(image)
        
        XCTAssertEqual(viewModel.description, image.description)
        XCTAssertEqual(viewModel.location, image.location)
    }
}
