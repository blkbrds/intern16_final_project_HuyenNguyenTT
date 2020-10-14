//
//  Session.swift
//  FinalProject
//
//  Created by bu on 10/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

class Session: Mappable {
    var id: Int = 0
    var time: String = ""
    var isExpanded: Bool = false
    
    required init (map: Map) { }
    required init() { }
    
    func mapping(map: Map) {
        id <- map["id"]
        time <- map["time"]
    }
}
