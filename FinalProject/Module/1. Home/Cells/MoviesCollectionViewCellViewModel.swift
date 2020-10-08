//
//  MoviesCollectionViewCellViewModel.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class MoviesCollectionViewCellViewModel {
    // MARK: - Properties
    var movie: Movie
    var imageName: String {
        return movie.thumbnail
    }
    var isFavorite: Bool {
        return movie.isFavorite
    }
    var id: String {
        return movie.id
    }

    // MARK: - Initialization
    init(movie: Movie) {
        self.movie = movie
    }
}
