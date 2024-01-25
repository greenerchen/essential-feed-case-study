//
//  SharedTestsHelper.swift
//  EssentialFeedsTests
//
//  Created by Greener Chen on 2023/4/26.
//

import XCTest

extension XCTestCase {
    func anyNSError() -> NSError {
        NSError(domain: "any error", code: 0)
    }
    
    func anyURL() -> URL {
        URL(string: "http://any-url.com")!
    }
    
    func anyData() -> Data {
        Data("any data".utf8)
    }
    
    func makeItemJSON(_ items: [[String: Any]]) -> Data {
        let items = ["items": items]
        return try! JSONSerialization.data(withJSONObject: items)
    }
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: URL(string: "http://any-url.com")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

extension Date {
    func adding(seconds: TimeInterval) -> Date {
        self + seconds
    }
    
    func adding(minutes: Int, calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        calendar.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func adding(days: Int, calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        calendar.date(byAdding: .day, value: days, to: self)!
    }
}

