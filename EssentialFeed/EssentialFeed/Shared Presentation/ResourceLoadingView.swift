//
//  ResourceLoadingView.swift
//  EssentialFeeds
//
//  Created by Greener Chen on 2023/12/13.
//

import Foundation

public protocol ResourceLoadingView: AnyObject {
    func display(_ viewModel: ResourceLoadingViewModel)
}
