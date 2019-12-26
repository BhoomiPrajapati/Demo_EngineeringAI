//
//  BaseResponse.swift
//  Demo_List
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import Foundation

class BaseResponse {
    
    let data : Any?
    let pages : Int?
    
    init(parameter : [String : Any]) {
        self.data = parameter["hits"] as? [[String : Any]]
        self.pages = parameter["nbPages"] as? Int
    }
}
