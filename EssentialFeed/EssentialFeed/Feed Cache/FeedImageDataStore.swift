//
//  FeedImageDataStore.swift
//  EssentialFeeds
//
//  Created by Greener Chen on 2023/11/13.
//

import Foundation

public protocol FeedImageDataStore {
    func retrieve(dataForUrl url: URL) throws -> Data?
    func insert(_ data: Data, for url: URL) throws
}
