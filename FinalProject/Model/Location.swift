//
//  Location.swift
//  FinalProject
//
//  Created by bu on 10/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

class Location: Mappable {
    var name: String = ""
    var cinemas: [Cinema] = []
    
    required init (map: Map) { }
    required init() { }
    
    func mapping(map: Map) {
        name <- map["name"]
        cinemas <- map["cinemas"]
    }
}
