//
//  UserImageHeaderView.swift
//  demo_collectionView
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import UIKit

final class UserImageHeaderView: UICollectionReusableView {

    // MARK: - IBOutlet
    @IBOutlet private weak var imgUserProfile: UIImageView!
    @IBOutlet private weak var lblUsername: UILabel!
    
    static let reuseIdentifier = "UserImageHeaderView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
