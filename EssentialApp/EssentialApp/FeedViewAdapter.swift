//
//  FeedViewAdapter.swift
//  EssentialApp
//
//  Created by Greener Chen on 2024/1/22.
//

import UIKit
import EssentialFeed
import EssentialFeediOS

final class FeedViewAdapter: ResourceView {
    private weak var controller: ListViewController?
    private let loader: (URL) -> FeedImageDataLoader.Publisher
    private let selection: (FeedImage) -> Void
    private let currentFeed: [FeedImage: CellController]
    
    private typealias ImageDataPresentationAdapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<FeedImageCellController>>
    private typealias LoadMorePresentationAdapter = LoadResourcePresentationAdapter<Paginated<FeedImage>, FeedViewAdapter>
    
    init(
        currentFeed: [FeedImage: CellController] = [:],
        controller: ListViewController,
        loader: @escaping (URL) -> FeedImageDataLoader.Publisher,
        selection: @escaping (FeedImage) -> Void
    ) {
        self.currentFeed = currentFeed
        self.controller = controller
        self.loader = loader
        self.selection = selection
    }
    
    func display(_ viewModel: Paginated<FeedImage>) {
        guard let controller = controller else { return }
        
        var currentFeed = self.currentFeed
        let feed: [CellController] = viewModel.items.map { model in
            if let controller = currentFeed[model] {
                return controller
            }
            
            let adapter = ImageDataPresentationAdapter(loader: { [loader] in
                loader(model.url)
            })
            let view = FeedImageCellController(
                viewModel: FeedImagePresenter.map(model),
                delegate: adapter) { [selection] in
                    selection(model)
                }
            
            adapter.presenter = LoadResourcePresenter<Data, WeakRefVirtualProxy<FeedImageCellController>>(
                resourceView: WeakRefVirtualProxy(view),
                loadingView: WeakRefVirtualProxy(view),
                errorView: WeakRefVirtualProxy(view),
                mapper: UIImage.tryMake)
            
            let controller = CellController(id: model, view)
            currentFeed[model] = controller
            return controller
        }
        
        guard let loadMorePublisher = viewModel.loadMorePublisher else {
            controller.display(feed)
            return
        }
        
        let loadMoreAdapter = LoadMorePresentationAdapter(loader: loadMorePublisher)
        let loadMore = LoadMoreCellController(callback: loadMoreAdapter.loadResource)
        
        loadMoreAdapter.presenter = LoadResourcePresenter(
            resourceView: FeedViewAdapter(
                currentFeed: currentFeed,
                controller: controller,
                loader: loader,
                selection: selection
            ),
            loadingView: WeakRefVirtualProxy(loadMore),
            errorView: WeakRefVirtualProxy(loadMore))
        
        let loadMoreSection = [CellController(id: UUID(), loadMore)]
        
        controller.display(feed, loadMoreSection)
    }
}

private struct InvalidImageData: Error {}

private extension UIImage {
    static func tryMake(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw InvalidImageData()
        }
        return image
    }
}
