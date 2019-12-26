//
//  ListDataTableViewCell.swift
//  Demo_List
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import UIKit

final class ListDataTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDate: UILabel!
    @IBOutlet weak var switchStatus: UISwitch!
    
    static let reuseIdentifier = "ListDataTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: ListItem) {
        self.lblTitle.text = data.title
        self.lblDate.text = data.createdAt?.getDateStringToDisplay()
    }
    
}
