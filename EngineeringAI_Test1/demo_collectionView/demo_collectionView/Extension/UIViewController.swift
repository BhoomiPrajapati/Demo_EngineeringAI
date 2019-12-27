//
//  UIViewController.swift
//  demo_collectionView
//
//  Created by PCQ186 on 27/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showAlert(withMessage message: String?, preferredStyle: UIAlertController.Style = .alert, withActions actions: UIAlertAction...) {
        let alert = UIAlertController(title: appName, message: message, preferredStyle: preferredStyle)
        if actions.count == 0 {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showProgressHud(){
        DispatchQueue.main.async {
             MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }

    func dismissProgressHud() {
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
