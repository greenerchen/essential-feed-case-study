//
//  UIButton+TestHelpers.swift
//  EssentialFeedsiOSTests
//
//  Created by Greener Chen on 2023/9/18.
//

import UIKit

extension UIButton {
    func simulateTap() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .touchUpInside)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
