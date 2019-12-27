//
//  UIView.swift
//  demo_collectionView
//
//  Created by PCQ186 on 27/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
