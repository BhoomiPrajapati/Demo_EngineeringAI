//
//  APIManager.swift
//  Demo_List
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    private let header = ["Content-Type": "application/json"]
    static let shared = APIManager()
    private let sessionManager : SessionManager!
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 10
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        self.sessionManager = SessionManager(configuration: configuration)
    }
    
    func sendRequest(router: APIRouter, onSuccess success: @escaping (_ response: BaseResponse) -> Void, onfailure failure: @escaping (_ error: APICallError) -> Void) {
        let path = router.path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var parameter = router.parameters
        
        if router.parameters == nil {
            parameter = [:]
        }
        
        var encoding: ParameterEncoding = JSONEncoding.default
        if router.method == .get {
            encoding = URLEncoding.default
        }
        
        let request = sessionManager.request(path!, method: router.method, parameters: parameter, encoding: encoding, headers: header)
        request.responseJSON { (response) in
            switch response.result {
            case .success:
                if let response = response.result.value as? [String: Any] {
                    let baseResponse = BaseResponse(parameter: response)
                    success(baseResponse)
                } else {
                    let error = APICallError.init(status: .serializationFailed)
                    failure(error)
                }
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    let error = APICallError(status: .timeout)
                    failure(error)
                } else if error._code == NSURLErrorCancelled {
                    let error = APICallError(status: .forbidden)
                    failure(error)
                } else if error._code == NSURLErrorNotConnectedToInternet {
                    let error = APICallError(status: .offline)
                    failure(error)
                } else {
                    let error = APICallError(status: .unknown)
                    failure(error)
                }
            }
        }
    }
}
