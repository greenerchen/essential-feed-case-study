//
//  FeedPresenter.swift
//  EssentialFeeds
//
//  Created by Greener Chen on 2023/9/28.
//

import Foundation

public final class FeedPresenter {
    
    public init() { }
    
    public static var title: String {
        NSLocalizedString(
            "FEED_VIEW_TITLE",
            tableName: "Feed",
            bundle: Bundle(for: FeedPresenter.self),
            comment: "Title for the feed view")
    }
}
