//
//  Detail.swift
//  FinalProject
//
//  Created by bu on 9/28/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

class Detail: Mappable {
    
    var id: String = ""
    var name: String = ""
    var ratingCode: String = ""
    var thumbnail: String = ""
    var movieTrailer: String = ""
    var genre: String = ""
    var movieEndtime: Int = 0
    var releaseDate: String = ""
    var fullDescription: String = ""
    var movieDirector: String = ""
    var movieLanguage: String = ""
    var movieActress: String = ""
    var isBooking: Bool = false
    
    required init() {}
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        ratingCode <- map["rating_code"]
        thumbnail <- map["thumbnail"]
        movieTrailer <- map["movie_trailer"]
        genre <- map["genre"]
        movieEndtime <- map["movie_endtime"]
        releaseDate <- map["release_date"]
        fullDescription <- map["full_description"]
        movieDirector <- map["movie_director"]
        movieLanguage <- map["movie_language"]
        movieActress <- map["movie_actress"]
        isBooking <- map["is_booking"]
    }
}
