//
//  NullStore.swift
//  EssentialApp
//
//  Created by Greener Chen on 2024/1/12.
//

import Foundation
import EssentialFeed

class NullStore: FeedStore {
    func deleteCacheFeed() throws {}
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {}

    func retrieve() throws -> CachedFeed? { .none }
}

extension NullStore: FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws {}
    
    func retrieve(dataForUrl url: URL) throws -> Data? {
        return .none
    }
}
