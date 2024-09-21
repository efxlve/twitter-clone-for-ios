//
//  ProfileController.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 6.09.2024.
//

import UIKit

private let reuseIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var user: User
    private var profileHeader: ProfileHeader?
    private var tweets = [Tweet]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        fetchTweets()
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets(forUser: user) { tweets in
            self.tweets = tweets
        }
    }
    
    func checkIfUserIsFollowed() {
        UserService.shared.checkUserIsFollowed(uid: user.uid, completion: { isFollowed in
            self.user.isFollowing = isFollowed
            
            if isFollowed {
                UIView.transition(with: self.profileHeader?.editProfileFollowButton ?? UIButton(), duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.profileHeader?.editProfileFollowButton.setTitle("Following", for: .normal)
                    self.profileHeader?.editProfileFollowButton.setTitleColor(.white, for: .normal)
                    self.profileHeader?.editProfileFollowButton.layer.borderColor = UIColor.clear.cgColor
                    self.profileHeader?.editProfileFollowButton.backgroundColor = .twitterBlue
                }, completion: nil)
            }
            
            self.collectionView.reloadData()
        })
    }
    
    func fetchUserStats() {
        UserService.shared.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
}

// MARK: - UICollectionViewDataSource

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        header.user = user
        header.delegate = self
        self.profileHeader = header
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = TweetViewModel(tweet: tweets[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height
        return CGSize(width: view.frame.width, height: height + 72)
    }
}

// MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {
    func handleEditProfileFollow(_ header: ProfileHeader) {
        
        if user.isCurrentUser {
            return
        }
        
        if user.isFollowing {
            UserService.shared.unfollowUser(uid: user.uid) { (ref, err) in
                self.user.isFollowing = false

                UIView.transition(with: header.editProfileFollowButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    header.editProfileFollowButton.setTitle("Follow", for: .normal)
                    header.editProfileFollowButton.setTitleColor(.twitterBlue, for: .normal)
                    header.editProfileFollowButton.layer.borderColor = UIColor.twitterBlue.cgColor
                    header.editProfileFollowButton.backgroundColor = .systemBackground
                }, completion: nil)
            }
        } else {
            UserService.shared.followUser(uid: user.uid) { (ref, err) in
                self.user.isFollowing = true

                UIView.transition(with: header.editProfileFollowButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    header.editProfileFollowButton.setTitle("Following", for: .normal)
                    header.editProfileFollowButton.setTitleColor(.white, for: .normal)
                    header.editProfileFollowButton.layer.borderColor = UIColor.clear.cgColor
                    header.editProfileFollowButton.backgroundColor = .twitterBlue
                }, completion: nil)
            }
        }
    }
    
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
}
