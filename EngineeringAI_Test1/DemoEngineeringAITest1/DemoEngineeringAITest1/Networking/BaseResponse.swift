//
//  BaseResponse.swift
//  Demo_List
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import Foundation

class BaseResponse {
    
    let status: Bool?
    let message: String?
    let data: [String : Any]?
    
    init(parameter : [String : Any]) {
        self.data = parameter["data"] as? [String : Any]
        self.message = parameter["message"] as? String
        self.status = parameter["status"] as? Bool
    }
}
