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
    var sku: String = ""
    var categoryID: String = ""
    var category: String = ""
    var name: String = ""
    var thumbnail: String = ""
    var movieTrailer: String = ""
    var movieEvent: String = ""
    var ratingCode: String = ""
    var ratingIcon: String = ""
    var codes: String = ""
    var isBooking: Bool = false
    var isSneakshow: Bool = false
    var isNew: Bool = false
    var position: Int = 0
    var movieEndtime: Int = 0
    var releaseDate: String = ""
    var isGerp: Bool = false
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        sku <- map["sku"]
        categoryID <- map["category_id"]
        category <- map["category"]
        name <- map["name"]
        thumbnail <- map["thumbnail"]
        movieTrailer <- map["movie_trailer"]
        movieEvent <- map["movie_event"]
        ratingCode <- map["rating_code"]
        ratingIcon <- map["rating_icon"]
        codes <- map["codes"]
        isBooking <- map["is_booking"]
        isSneakshow <- map["is_sneakshow"]
        isNew <- map["is_new"]
        position <- map["position"]
        movieEndtime <- map["movie_endtime"]
        releaseDate <- map["release_date"]
        isGerp <- map["is_gerp"]
    }
}
