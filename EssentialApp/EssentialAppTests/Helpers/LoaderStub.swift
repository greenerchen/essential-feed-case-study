//
//  LoaderStub.swift
//  EssentialAppTests
//
//  Created by Greener Chen on 2023/11/21.
//

import EssentialFeed

class LoaderStub {
    private let result: Swift.Result<[FeedImage], Error>
    
    init(result: Swift.Result<[FeedImage], Error>) {
        self.result = result
    }
    
    func load(completion: @escaping (Swift.Result<[FeedImage], Error>) -> Void) {
        completion(result)
    }
}
