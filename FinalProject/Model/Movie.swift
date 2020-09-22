//
//  Movies.swift
//  FinalProject
//
//  Created by bu on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Movie {
    var imageName: String
    var movieName: String
    var movieTime: String
    
    init(imageName: String = "", movieName: String = "", movieTime: String = "") {
        self.imageName = imageName
        self.movieName = movieName
        self.movieTime = movieTime
    }
}
