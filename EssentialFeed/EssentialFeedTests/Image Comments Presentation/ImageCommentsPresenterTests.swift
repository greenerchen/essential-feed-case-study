//
//  ImageCommentsPresenterTests.swift
//  EssentialFeedsTests
//
//  Created by Greener Chen on 2023/12/18.
//

import XCTest
import EssentialFeed

final class ImageCommentsPresenterTests: XCTestCase {

    func test_title_isLocalized() {
        XCTAssertEqual(ImageCommentsPresenter.title, localized("IMAGE_COMMENTS_VIEW_TITLE"))
    }
    
    func test_map_createsViewModel() {
        let now = Date()
        let calendar = Calendar(identifier: .gregorian)
        let locale = Locale(identifier: "en_US_POSIX")
        let commentID1 = UUID()
        let commentID2 = UUID()
        let comments = [
            ImageComment(
                id: commentID1,
                message: "a message",
                createdAt: now.adding(minutes: -5, calendar: calendar),
                username: "a username"),
            ImageComment(
                id: commentID2,
                message: "another message",
                createdAt: now.adding(days: -1, calendar: calendar),
                username: "another username")
        ]
        
        let viewModel = ImageCommentsPresenter.map(
            comments,
            currentDate: now,
            calendar: calendar,
            locale: locale
        )
        
        XCTAssertEqual(viewModel.comments, [
            ImageCommentViewModel(
                id: commentID1,
                message: "a message",
                date: "5 minutes ago",
                username: "a username"
            ),
            ImageCommentViewModel(
                id: commentID2,
                message: "another message",
                date: "1 day ago",
                username: "another username"
            )
        ])
    }
    
    // MARK: - Helpers
    
    private func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "ImageComments"
        let bundle = Bundle(for: ImageCommentsPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for \(key) in the table: \(table)", file: file, line: line)
        }
        return value
    }

}
