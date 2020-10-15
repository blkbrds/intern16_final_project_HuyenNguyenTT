//
//  Cinema.swift
//  FinalProject
//
//  Created by bu on 10/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

class Cinema: Mappable {
    var id: String = ""
    var name: String = ""
    var sessions: [Session] = []
    
    required init (map: Map) { }
    required init() { }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        sessions <- map["languages.0.sessions"]
    }
}
