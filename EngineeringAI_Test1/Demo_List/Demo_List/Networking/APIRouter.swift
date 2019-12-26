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
    case getListData(pageNumber: Int)
}

extension APIRouter {
    var path: String {
        var page = ""
        switch self {
        case .getListData(let pageNumber):
            page = "page=" + "\(pageNumber)"
        }
        return baseURL + page
    }
}

extension APIRouter {
    var method: HTTPMethod {
        switch self {
        case .getListData:
            return .get
        }
    }
}

extension APIRouter {
    var parameters: Parameters? {
        switch self {
        case .getListData:
            return nil
        }
    }
}
