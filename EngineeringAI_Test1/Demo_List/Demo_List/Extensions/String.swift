//
//  String.swift
//  Demo_List
//
//  Created by PCQ186 on 26/12/19.
//  Copyright © 2019 PCQ186. All rights reserved.
//

import Foundation
import UIKit

enum DateFormat {
    case dateAndTimeAPIResponse
    case dateAndTimeToDisplay
    
    var format: String {
        switch self {
        case .dateAndTimeAPIResponse:
            return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .dateAndTimeToDisplay:
            return "EE, dd mm yyyy hh:mm:ss a"
        }
    }
}

extension String {
    
    func getDateStringToDisplay() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.dateAndTimeToDisplay.format
        formatter.locale = Locale(identifier: "UTC")
        let date = self.getDateFromString(dateString: self)
        let dateToDisplay = formatter.string(from: date)
        return dateToDisplay
    }
    
    func getDateFromString(dateString: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.dateAndTimeAPIResponse.format
        formatter.locale = Locale(identifier: "UTC")
        let date = formatter.date(from: dateString)
        return date ?? Date()
    }
}
