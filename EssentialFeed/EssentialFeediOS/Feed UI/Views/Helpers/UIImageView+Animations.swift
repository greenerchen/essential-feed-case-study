//
//  UIImageView+Animations.swift
//  EssentialFeedsiOS
//
//  Created by Greener Chen on 2023/9/15.
//

import UIKit

extension UIImageView {
    func setImageAnimated(_ newImage: UIImage?) {
        image = newImage
        
        guard newImage != nil else { return }
    
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
