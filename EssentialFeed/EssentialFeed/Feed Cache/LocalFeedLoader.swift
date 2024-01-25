//
//  LocalFeedLoader.swift
//  EssentialFeeds
//
//  Created by Greener Chen on 2023/4/16.
//

import Foundation

public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

extension LocalFeedLoader: FeedCache {
    public func save(_ feed: [FeedImage]) throws {
        try store.deleteCacheFeed()
        try store.insert(feed.toLocal(), timestamp: currentDate())
    }
}

extension LocalFeedLoader {
    public func load() throws -> [FeedImage] {
        if let cache = try store.retrieve(),
            FeedCachePolicy.validate(cache.timestamp, against: self.currentDate()) {
            return cache.feed.toModels()
        }
        return []
    }
}

extension LocalFeedLoader {
    public struct InvalidCache: Error {}
    
    public func validateCache() throws {
        do {
            if let cache = try store.retrieve(),
             !FeedCachePolicy.validate(cache.timestamp, against: self.currentDate()) {
                throw InvalidCache()
            }
        } catch {
            try store.deleteCacheFeed()
        }
    }
}

private extension Array where Element == FeedImage {
    func toLocal() -> [LocalFeedImage] {
        map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    }
}

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedImage] {
        map { FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    }
}
