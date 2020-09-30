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
    var movies = [Movie]()
    
    // MARK: - Function
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
    
    func getDetailViewModel(atIndexPath indexPath: IndexPath) -> DetailViewModel {
        guard 0 <= indexPath.row && indexPath.row < movies.count else { return DetailViewModel() }
        let detail = Detail()
        detail.id = movies[indexPath.row].id
        return DetailViewModel(detail: detail)
    }
}
