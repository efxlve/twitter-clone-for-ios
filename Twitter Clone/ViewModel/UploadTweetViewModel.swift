//
//  UploadTweetViewModel.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 14.09.2024.
//

import UIKit

enum UploadTweetConfiguration {
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel {
    let actionButtonTitle: String
    let placeholderText: String
    var shouldShowReplyLabel: Bool
    var replyText: String?
    
    init(config: UploadTweetConfiguration) {
        switch config {
        case .tweet:
            let title = "Tweet"
            let placeholder = "What's happening?!"
            self.actionButtonTitle = title
            self.placeholderText = placeholder
            self.shouldShowReplyLabel = false
        case .reply(let tweet):
            let title = "Reply"
            let placeholder = "Tweet your reply"
            let replyText = "Replying to @\(tweet.user.username)"
            self.actionButtonTitle = title
            self.placeholderText = placeholder
            self.replyText = replyText
            self.shouldShowReplyLabel = true
        }
    }
}
