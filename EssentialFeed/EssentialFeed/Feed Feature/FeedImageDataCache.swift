//
//  FeedImageDataCache.swift
//  EssentialFeeds
//
//  Created by Greener Chen on 2023/11/21.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}
