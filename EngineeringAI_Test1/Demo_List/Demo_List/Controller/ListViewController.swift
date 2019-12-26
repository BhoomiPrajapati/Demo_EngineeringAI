//
//  ListViewController.swift
//  Demo_List
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import UIKit
import MBProgressHUD

final class ListViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var tblList: UITableView!
    
    // MARK: - Variables
    private var pageNumber = 0
    private var isLoadMore = false
    private var arrayOfListData: [ListItem] = []
    private var refreshControl = UIRefreshControl()
    
    private var selectedCount : Int = 0 {
        didSet {
            self.title = "Number Of Selected Posts : \(selectedCount)"
        }
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.title = "Number Of Selected Posts : \(selectedCount)"
        tblList.register(UINib(nibName: String(describing: ListDataTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: ListDataTableViewCell.self))
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tblList.addSubview(refreshControl)
        self.callGetListAPI(showProgress: true)
    }
    
    // MARK: - API call
    private func callGetListAPI(showProgress: Bool? = false) {
        if showProgress ?? false {
            self.showProgressHud()
        }
        APIManager.shared.sendRequest(router: APIRouter.getListData(pageNumber: self.pageNumber), onSuccess: { response in
            self.dismissProgressHud()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            if let dictionaryArray = response.data as? [[String:Any]] {
                let totalPage = response.pages
                self.isLoadMore = totalPage == self.pageNumber ? false : true
                dictionaryArray.forEach{ listItem in
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: listItem, options: .prettyPrinted)
                        let list = try JSONDecoder().decode(ListItem.self, from: jsonData)
                        self.arrayOfListData.append(list)
                    } catch {
                        print("Error parsing the json")
                    }
                }
                self.tblList.reloadData()
            }
        }) { error in
            self.dismissProgressHud()
            self.showAlert(withMessage: error.message)
        }
    }
    
    // MARK: - Helper methods
    
    @objc private func refresh() {
        self.pageNumber = 0
        self.selectedCount = 0
        self.arrayOfListData.removeAll()
        self.tblList.reloadData()
        self.callGetListAPI(showProgress: true)
    }
    
    @objc private func switchValueDidChange(_ sender: UISwitch) {
        self.arrayOfListData[sender.tag].isOn = sender.isOn
        self.selectedCount = self.arrayOfListData.filter({$0.isOn == true}).count
    }
    
}

// MARK: - Extension
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListDataTableViewCell.reuseIdentifier, for: indexPath) as? ListDataTableViewCell {
            let listItem = self.arrayOfListData[indexPath.row]
            cell.configure(data: listItem)
            cell.switchStatus.isOn = listItem.isOn ?? (false)
            cell.switchStatus.tag = indexPath.row
            cell.switchStatus.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == arrayOfListData.count - 2 && isLoadMore {
            pageNumber += 1
            callGetListAPI(showProgress: false)
        }
    }
}
