//
//  Movies.swift
//  FinalProject
//
//  Created by bu on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Movie {
    var categoryId: Int
    var imageName: String
    var name: String
    var releaseDate: String
    
    init(categoryId: Int, imageName: String = "", name: String = "", releaseDate: String = "") {
        self.categoryId = categoryId
        self.imageName = imageName
        self.name = name
        self.releaseDate = releaseDate
    }
}
