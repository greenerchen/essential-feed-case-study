//
//  FeedItem.swift
//  EssentialFeeds
//
//  Created by Greener Chen on 2023/3/9.
//

import Foundation

public struct FeedImage: Hashable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL
    
    public init(id: UUID, description: String?, location: String?, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
