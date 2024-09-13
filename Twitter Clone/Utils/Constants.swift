//
//  Constants.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 2.09.2024.
//

import Firebase
import FirebaseStorage

let STORAGE_REF = Storage.storage().reference()
let PROFILE_IMAGE_REF = STORAGE_REF.child("profileImages")

let DB_REF = Database.database().reference()
let USERS_REF = DB_REF.child("users")
let TWEETS_REF = DB_REF.child("tweets")
let USER_TWEETS_REF = DB_REF.child("userTweets")
let USER_FOLLOWERS_REF = DB_REF.child("userFollowers")
let USER_FOLLOWING_REF = DB_REF.child("userFollowing")
