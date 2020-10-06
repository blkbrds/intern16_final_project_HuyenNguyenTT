//
//  FavoriteMovie.swift
//  FinalProject
//
//  Created by bu on 10/6/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import RealmSwift

final class FavoriteMovieList: Object {
    @objc dynamic var id: String = ""
//    var categoryID: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var thumbnail: String = ""
//    var isBooking: Bool = false
    @objc dynamic var releaseDate: String = ""
    
    //add propeties for detail
//    var ratingCode: String = ""
//    var movieTrailer: String = ""
//    var genre: String = ""
//    var movieEndtime: Int = 0
//    var fullDescription: String = ""
//    var movieDirector: String = ""
//    var movieLanguage: String = ""
//    var movieActress: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
