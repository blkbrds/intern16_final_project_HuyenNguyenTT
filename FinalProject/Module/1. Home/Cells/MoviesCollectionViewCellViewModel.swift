//
//  MoviesCollectionViewCellViewModel.swift
//  FinalProject
//
//  Created by bu on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class MoviesCollectionViewCellViewModel {
    // MARK: - Properties
    var movies: Movie
    var imageName: String {
        return movies.thumbnail
    }

    // MARK: - Initialization
    init(movies: Movie) {
        self.movies = movies
    }
}
