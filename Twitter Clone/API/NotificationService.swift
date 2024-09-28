//
//  NotificationService.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 22.09.2024.
//

import Foundation
import FirebaseAuth

struct NotificationService {
    static let shared = NotificationService()
    
    func uploadNotification(type: NotificationType, tweet: Tweet? = nil, user: User?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var values: [String: Any] = ["timestamp": Int(NSDate().timeIntervalSince1970), "uid": uid, "type": type.rawValue]
        
        if let tweet = tweet {
            values["tweetId"] = tweet.tweetId
            NOTIFICATIONS_REF.child(tweet.user.uid).childByAutoId().updateChildValues(values)
        } else if let user = user{
            NOTIFICATIONS_REF.child(user.uid).childByAutoId().updateChildValues(values)
        }
    }
    
    func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        var notifications = [Notification]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        NOTIFICATIONS_REF.child(uid).observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            
            UserService.shared.fetchUser(uid: uid) { user in
                let notification = Notification(user: user, dictionary: dictionary)
                notifications.append(notification)
                completion(notifications)
            }
        }
    }
}
