//
//  Location.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

class Location: Mappable {
    var name: String = ""
    var cinemas: [Cinema] = []
    var isExpanded: Bool = true
    
    required init (map: Map) { }
    required init() { }
    
    func mapping(map: Map) {
        name <- map["name"]
        cinemas <- map["cinemas"]
    }
}
