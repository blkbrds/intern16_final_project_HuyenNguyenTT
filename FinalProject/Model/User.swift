//
//  User.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/18/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

final class User: Mappable {
    var email: String = ""
    var username: String = ""
    var gender: String = ""
    var accessToken: String = ""
    var dob: String = ""
    var fullname: String = ""
    var telephone: String = ""
    
    required init (map: Map) { }
    required init() { }
    
    func mapping(map: Map) {
        email <- map["email"]
        username <- map["username"]
        gender <- map["gender"]
        accessToken <- map["access_token"]
        dob <- map["dob"]
        fullname <- map["fullname"]
        telephone <- map["address.telephone"]
    }
}
