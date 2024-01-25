//
//  ImageCommentsPresenter.swift
//  EssentialFeeds
//
//  Created by Greener Chen on 2023/12/18.
//

import Foundation

public final class ImageCommentsPresenter {
    
    public init() { }
    
    public static var title: String {
        NSLocalizedString(
            "IMAGE_COMMENTS_VIEW_TITLE",
            tableName: "ImageComments",
            bundle: Bundle(for: ImageCommentsPresenter.self),
            comment: "Title for the image comments view")
    }
    
    public static func map(
        _ comments: [ImageComment],
        currentDate: Date = Date(),
        calendar: Calendar = .current,
        locale: Locale = .current
    ) -> ImageCommentsViewModel {
        let formatter = RelativeDateTimeFormatter()
        formatter.calendar = calendar
        formatter.locale = locale
        return ImageCommentsViewModel(comments: comments.map { comment in
            ImageCommentViewModel(
                id: comment.id,
                message: comment.message,
                date: formatter.localizedString(for: comment.createdAt, relativeTo: currentDate),
                username: comment.username)
        })
    }
}

public struct ImageCommentsViewModel {
    public let comments: [ImageCommentViewModel]
}

public struct ImageCommentViewModel: Equatable, Hashable {
    public let id: UUID
    public let message: String
    public let date: String
    public let username: String
    
    public init(id: UUID = UUID(), message: String, date: String, username: String) {
        self.id = id
        self.message = message
        self.date = date
        self.username = username
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
