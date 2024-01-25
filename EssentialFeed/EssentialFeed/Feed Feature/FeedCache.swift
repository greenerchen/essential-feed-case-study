//
//  FeedCache.swift
//  EssentialFeeds
//
//  Created by Greener Chen on 2023/11/21.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedImage]) throws
}
