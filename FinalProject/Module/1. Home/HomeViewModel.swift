//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    // Types
    enum MovieType: Int {
        case playing = 0, upcomming
    }
    
    // MARK: - Properties
    var movies: [Movie] {
        switch movieType {
        case .playing:
            return playingMovies
        case .upcomming:
            return upcommingMovies
        }
    }
    var movieType: MovieType = .playing
    private var playingMovies: [Movie] = []
    private var upcommingMovies: [Movie] = []
    
    // MARK: - Function
    func getMovies(completion: @escaping (APIResult) -> Void) {
        apiProvider.getMovies { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let movies):
                for movie in movies {
                    if let type = MovieType(rawValue: movie.categoryID) {
                        switch type {
                        case .playing:
                            this.playingMovies.append(movie)
                        case .upcomming:
                            this.upcommingMovies.append(movie)
                        }
                    }
                }
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
        return DetailViewModel(movie: movies[indexPath.row])
    }
}
