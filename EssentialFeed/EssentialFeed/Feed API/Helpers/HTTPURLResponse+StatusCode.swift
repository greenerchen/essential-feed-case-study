//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeeds
//
//  Created by Greener Chen on 2023/11/8.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        statusCode == HTTPURLResponse.OK_200
    }
}
