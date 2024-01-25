//
//  FeedImageDataLoader.swift
//  EssentialFeedsiOS
//
//  Created by Greener Chen on 2023/9/13.
//

import Foundation

public protocol FeedImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
