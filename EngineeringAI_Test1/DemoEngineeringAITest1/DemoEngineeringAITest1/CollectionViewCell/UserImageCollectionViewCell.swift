//
//  UserImageCollectionViewCell.swift
//  demo_collectionView
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import UIKit

final class UserImageCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var imgUserData: UIImageView!
    
    static let reuseIdentifier = "UserImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: String) {
        if let url = URL(string: data) {
            imgUserData.sd_setImage(with: url, completed: nil)
        }
    }

}
