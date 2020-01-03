//
//  APIRouter.swift
//  Demo_List
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import Foundation
import Alamofire

protocol Routable {
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: Parameters? {get}
}

enum APIRouter: Routable {
    case getUserImageData(offset: Int, limit: Int)
}

extension APIRouter {
    var path: String {
        switch self {
        case .getUserImageData(let offset, let limit):
            return baseURL + "offset=\(offset)&limit=\(limit)"
        }
    }
}

extension APIRouter {
    var method: HTTPMethod {
        switch self {
        case .getUserImageData:
            return .get
        }
    }
}

extension APIRouter {
    var parameters: Parameters? {
        switch self {
        case .getUserImageData:
            return nil
        }
    }
}
