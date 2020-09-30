//
//  Movie.swift
//  FinalProject
//
//  Created by bu on 9/24/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

class Movie: Mappable {
    var id: String = ""
    var categoryID: Int = 0
    var name: String = ""
    var thumbnail: String = ""
    var isBooking: Bool = false
    var releaseDate: String = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        categoryID <- map["category_id"]
        name <- map["name"]
        thumbnail <- map["thumbnail"]
        isBooking <- map["is_booking"]
        releaseDate <- map["release_date"]
    }
}
