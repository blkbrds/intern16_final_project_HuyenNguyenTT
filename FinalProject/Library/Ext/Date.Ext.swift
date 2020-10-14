//
//  Date.Ext.swift
//  FinalProject
//
//  Created by bu on 10/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension Date {
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
