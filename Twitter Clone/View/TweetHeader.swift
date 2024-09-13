//
//  TweetHeader.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 13.09.2024.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    
    // MARK: - Properties

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
