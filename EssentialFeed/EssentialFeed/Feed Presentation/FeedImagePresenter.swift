//
//  FeedImagePresenter.swift
//  EssentialFeedsiOS
//
//  Created by Greener Chen on 2023/9/15.
//

import UIKit

final public class FeedImagePresenter {
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location)
    }
}
