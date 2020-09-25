//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by bu on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

class HomeViewModel {
    var movies = [Movie]()
    
    func getMovies(completion: @escaping (APIResult) -> Void) {
        apiProvider.getMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return movies.count
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> MoviesCollectionViewCellViewModel? {
        guard movies.count > indexPath.row else { return nil }
        let movieImage = movies[indexPath.row]
        return MoviesCollectionViewCellViewModel(movies: movieImage)
    }
}
