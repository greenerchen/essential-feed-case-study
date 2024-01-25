//
//  UIRefreshControl+Helpers.swift
//  EssentialFeedsiOS
//
//  Created by Greener Chen on 2023/12/20.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
