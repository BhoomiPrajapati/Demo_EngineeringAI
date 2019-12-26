//
//  List.swift
//  Demo_List
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import Foundation

struct ListItem: Codable {
    
    let createdAt: String?
    let title: String?
    var isOn: Bool? = false
    
    enum CodingKeys: String, CodingKey {

        case createdAt = "created_at"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}
