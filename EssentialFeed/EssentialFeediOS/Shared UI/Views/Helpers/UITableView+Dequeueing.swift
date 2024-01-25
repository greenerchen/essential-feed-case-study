//
//  UITableView+Dequeueing.swift
//  EssentialFeedsiOS
//
//  Created by Greener Chen on 2023/9/15.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identity = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identity) as! T
    }
}
