//
//  App.swift
//  FinalProject
//
//  Created by AsianTech on 6/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

struct App {
    struct Key { }
    
    static let calendar = Calendar(identifier: .gregorian)
    static let locale = Locale(identifier: "ja")
}

typealias DateTime = App.DateTime
extension App {
    
    struct DateTime {
    
        static let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = DateFormat.yearMonthDay.rawValue
            return dateFormatter
        }()
        
        enum DateFormat: String {
            case yearMonthDay
            
            var string: String {
                switch self {
                case .yearMonthDay: return "yyyy-MM-dd"
                }
            }
        }
    }
}
