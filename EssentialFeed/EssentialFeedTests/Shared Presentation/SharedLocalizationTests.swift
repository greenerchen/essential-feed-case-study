//
//  SharedLocalizationTests.swift
//  EssentialFeedsTests
//
//  Created by Greener Chen on 2023/12/12.
//

import XCTest
import EssentialFeed

final class SharedLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Shared"
        let presentationBundle = Bundle(for: LoadResourcePresenter<String, DummyView>.self)
        
        assertLocalizedKeyAndValueExist(in: presentationBundle, table)
        
    }
    
    // MARK: - Helpers
    
    private class DummyView: ResourceView {
        typealias ResourceViewModel = String
        
        func display(_ viewModel: String) {
            
        }
    }
}
