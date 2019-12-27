//
//  UserList.swift
//  demo_collectionView
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import Foundation

struct UserList: Codable {
    
    let users: [Users]?
    let hasMore: Bool?

    enum CodingKeys: String, CodingKey {

        case users = "users"
        case hasMore = "has_more"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        users = try values.decodeIfPresent([Users].self, forKey: .users)
        hasMore = try values.decodeIfPresent(Bool.self, forKey: .hasMore)
    }

}
