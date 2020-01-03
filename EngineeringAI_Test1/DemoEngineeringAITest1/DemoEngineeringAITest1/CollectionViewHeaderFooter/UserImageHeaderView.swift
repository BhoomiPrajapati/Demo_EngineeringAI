//
//  UserImageHeaderView.swift
//  demo_collectionView
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import UIKit
import SDWebImage

final class UserImageHeaderView: UICollectionReusableView {

    // MARK: - IBOutlet
    @IBOutlet private weak var imgUserProfile: UIImageView!
    @IBOutlet private weak var lblUsername: UILabel!
    
    static let reuseIdentifier = "UserImageHeaderView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: Users) {
        self.imgUserProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        if let url = URL(string: data.image ?? "") {
            self.imgUserProfile.sd_setImage(with: url, completed: nil)
        }
        self.lblUsername.text = data.name
    }
}
