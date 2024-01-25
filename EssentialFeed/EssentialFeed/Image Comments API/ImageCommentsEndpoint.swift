//
//  ImageCommentsEndpoint.swift
//  EssentialFeeds
//
//  Created by Greener Chen on 2024/1/3.
//

import Foundation

public enum ImageCommentsEndpoint {
    case get(UUID)
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case let .get(id):
            return baseURL.appending(path: "/v1/image/\(id.uuidString)/comments")
        }
    }
}
