//
//  Session.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

class Session: Mappable {
    var id: Int = 0
    var time: String = ""
    
    required init (map: Map) { }
    required init() { }
    
    func mapping(map: Map) {
        id <- map["id"]
        time <- map["time"]
    }
}
