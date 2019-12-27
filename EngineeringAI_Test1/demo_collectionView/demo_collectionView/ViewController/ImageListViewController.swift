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
    private var arrayOfUsers: [Users] = []
    private var offset = 0
    private var limit = 10
    private var hasMore = true
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        collectionUserData.register(UINib(nibName: String(describing: UserImageCollectionViewCell.self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: UserImageCollectionViewCell.self))
        collectionUserData.register(UINib(nibName: String(describing: UserImageHeaderView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserImageHeaderView.reuseIdentifier)
        collectionUserData.register(UINib(nibName: String(describing: CollectionReusableFooterView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionReusableFooterView")
        collectionUserData.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.callGetUserDataAPI(isShowProgress: true)
        
        let eventImageflowLayout = UICollectionViewFlowLayout()
        eventImageflowLayout.minimumLineSpacing = 10
        eventImageflowLayout.minimumInteritemSpacing = 10
        eventImageflowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionUserData.setCollectionViewLayout(eventImageflowLayout, animated: true)
    }
    
    // MARK: - API call
    private func callGetUserDataAPI(isShowProgress: Bool? = false) {
        if isShowProgress ?? true {
            self.showProgressHud()
        }
        APIManager.shared.sendRequest(router: APIRouter.getUserImageData(offset: self.offset, limit: self.limit), onSuccess: { response in
            self.dismissProgressHud()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            if let dictionary = response.data {
                do {
                    let objData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
                    let objUserList = try JSONDecoder().decode(UserList.self, from: objData)
                    self.hasMore = objUserList.hasMore ?? false
                    let tempArray = objUserList.users ?? []
                    self.arrayOfUsers.append(contentsOf: tempArray)
                } catch {
                    print("Error parsing the json")
                }
            }
            self.collectionUserData.reloadData()
        }) { error in
            self.dismissProgressHud()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.showAlert(withMessage: error.message)
        }
    }
    
    // MARK: - Helper methods
    @objc private func refresh() {
        self.offset = 10
        self.arrayOfUsers.removeAll()
        collectionUserData.reloadData()
        callGetUserDataAPI(isShowProgress: true)
    }
    
}

// MARK: - Extension
extension ImageListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.arrayOfUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfUsers[section].items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.section == self.arrayOfUsers.count - 1 && self.hasMore == true) {
            self.offset = self.offset + self.limit
            self.callGetUserDataAPI(isShowProgress: false)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserImageCollectionViewCell.reuseIdentifier, for: indexPath) as? UserImageCollectionViewCell {
            if let item = self.arrayOfUsers[indexPath.section].items?[indexPath.row] {
                cell.configure(data: item)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
           return CGSize(width: collectionView.frame.width, height: 8.0)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (self.arrayOfUsers[indexPath.section].items?.count ?? 0) % 2 == 0 {
            let cellwidth = (collectionView.frame.width - 30 ) / 2
            return CGSize(width: cellwidth, height: cellwidth)
        } else {
            if indexPath.item == 0 {
                return CGSize(width: (collectionView.frame.width - 20), height: (collectionView.frame.width - 20))
            } else {
                let cellwidth = (collectionView.frame.width - 30 ) / 2
                return CGSize(width: cellwidth, height: cellwidth)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UserImageHeaderView.reuseIdentifier, for: indexPath) as? UserImageHeaderView {
                header.configure(data: arrayOfUsers[indexPath.section])
                return header
            }
        } else if kind == UICollectionView.elementKindSectionFooter {
            if let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableFooterView", for: indexPath) as? CollectionReusableFooterView {
                return footer
            }
        }
        return UICollectionReusableView()
    }
    
}
