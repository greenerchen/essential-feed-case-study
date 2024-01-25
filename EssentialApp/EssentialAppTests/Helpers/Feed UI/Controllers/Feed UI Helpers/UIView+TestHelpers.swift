//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Greener Chen on 2023/12/5.
//

import UIKit

extension UIView {
    func enforceLayoutCeycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
