//
//  CaptionTextView.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 5.09.2024.
//

import UIKit

class InputTextView: UITextView {
    
    // MARK: - Properties
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "What's happening?!"
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .systemBackground
        font = UIFont.systemFont(ofSize: 16)
        
        let titleColor: UIColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
        
        textColor = titleColor
        
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector (handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
