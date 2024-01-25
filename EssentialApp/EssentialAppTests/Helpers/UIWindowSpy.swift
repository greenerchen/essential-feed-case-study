//
//  UIWindowSpy.swift
//  EssentialAppTests
//
//  Created by Greener Chen on 2023/12/5.
//

import UIKit

class UIWindowSpy: UIWindow {
    var makeKeyAndVisibleCount = 0
    override func makeKeyAndVisible() {
        makeKeyAndVisibleCount += 1
    }
}
