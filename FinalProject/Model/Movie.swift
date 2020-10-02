//
//  Movie.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/24/20.
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
    
    //add propeties for detail
    var ratingCode: String = ""
    var movieTrailer: String = ""
    var genre: String = ""
    var movieEndtime: Int = 0
    var fullDescription: String = ""
    var movieDirector: String = ""
    var movieLanguage: String = ""
    var movieActress: String = ""
    
    required init() {}
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        categoryID <- map["category_id"]
        name <- map["name"]
        thumbnail <- map["thumbnail"]
        isBooking <- map["is_booking"]
        releaseDate <- map["release_date"]
        
        // add map data for detail
        ratingCode <- map["rating_code"]
        movieTrailer <- map["movie_trailer"]
        genre <- map["genre"]
        movieEndtime <- map["movie_endtime"]
        fullDescription <- map["full_description"]
        movieDirector <- map["movie_director"]
        movieLanguage <- map["movie_language"]
        movieActress <- map["movie_actress"]
    }
}
