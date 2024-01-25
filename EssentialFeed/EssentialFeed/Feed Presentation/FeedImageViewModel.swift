//
//  FeedImageViewModel.swift
//  EssentialFeedsiOS
//
//  Created by Greener Chen on 2023/9/14.
//

import Foundation

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?
    
    public var hasLocation: Bool {
        location != nil
    }
}
