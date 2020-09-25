//
//  Error.swift
//  FinalProject
//
//  Created by Hai Ca on 9/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension Error {

    static var json: Error {
        return NSError(domain: "", code: 3_840, userInfo: [NSLocalizedDescriptionKey: "json"])
    }
    
    public var code: Int {
        let `self` = self as NSError
        return self.code
    }
}
