//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by bu on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class HomeViewModel {
    // MARK: - Properties
    private(set) var movies: [Movie] = [Movie(categoryId: 0, imageName: "img_home_movie"),
    Movie(categoryId: 0, imageName: "img_home_movie"),
    Movie(categoryId: 0, imageName: "img_home_movie"),
    Movie(categoryId: 0, imageName: "img_home_movie"),
    Movie(categoryId: 0, imageName: "img_home_movie")]
    
    func numberOfRows(inSection section: Int) -> Int {
        return movies.count
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> MoviesCollectionViewCellViewModel? {
        guard movies.count > indexPath.row else { return nil }
        let movieImage = movies[indexPath.row]
        return MoviesCollectionViewCellViewModel(movies: movieImage)
    }
}
