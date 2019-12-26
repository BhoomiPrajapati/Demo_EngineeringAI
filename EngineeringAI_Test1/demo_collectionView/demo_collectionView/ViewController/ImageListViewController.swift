//
//  ImageListViewController.swift
//  demo_collectionView
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import UIKit

final class ImageListViewController: UIViewController {

    // MARK: - IBoutlet
    @IBOutlet private weak var collectionUserData: UICollectionView!
    
    // MARK: - Variables
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        collectionMediaList.register(UINib(nibName: String(describing: MyChatMediaCollectionViewCell.self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: MyChatMediaCollectionViewCell.self))
        collectionMediaList.register(UINib(nibName: String(describing: MyChatMediaCollectionViewHeader.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyChatMediaCollectionViewHeader.reuseIdentifier)
    }
    
    // MARK: - API call
    
    // MARK: - Helper methods

}

// MARK: - Extension

