//
//  UIImage+TestHelpers.swift
//  EssentialFeedsiOSTests
//
//  Created by Greener Chen on 2023/11/30.
//

import UIKit

extension UIImage {
    class func make(withColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { context in
            color.setFill()
            context.fill(rect)
        }
    }
}
