//
//  EditProfileCell.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 30.09.2024.
//

import UIKit

class EditProfileCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
