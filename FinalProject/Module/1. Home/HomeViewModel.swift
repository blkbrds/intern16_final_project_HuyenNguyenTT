//
//  HomeViewModel.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Protocol
protocol HomeViewModelDelegate: class {
    func viewModel(_ viewModel: HomeViewModel, needsPerform action: HomeViewModel.Action)
}

final class HomeViewModel {
    
    // MARK: - Types
    enum Action {
        case reloadData
    }
    
    enum MovieType: Int {
        case playing = 0
        case upcomming
        case favorite
    }
    
    // MARK: - Properties
    var movies: [Movie] {
        switch movieType {
        case .playing:
            return playingMovies
        case .upcomming:
            return upcommingMovies
        case .favorite:
            return favoriteMovies
        }
    }
    private var notificationToken: NotificationToken?
    var movieType: MovieType = .playing
    private var playingMovies: [Movie] = []
    private var upcommingMovies: [Movie] = []
    private var favoriteMovies: [Movie] = []
    weak var delegate: HomeViewModelDelegate?
    
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
                        case .favorite:
                            break
                        }
                        this.syncFavoriteAllMovies()
                    }
                }
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setupRealm(failure: @escaping (Error?) -> Void) {
        setupObserve(onCompleted: failure)
        fetchRealmData(onCompleted: failure)
    }
    
    private func setupObserve(onCompleted: @escaping (Error?) -> Void) {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Movie.self).observe({ [weak self] _ in
                guard let this = self else { return }
                if let delegate = this.delegate {
                    this.fetchRealmData(onCompleted: onCompleted)
                    delegate.viewModel(this, needsPerform: .reloadData)
                }
            })
            onCompleted(nil)
        } catch {
            onCompleted(error)
        }
    }
    
    private func fetchRealmData(onCompleted: (Error?) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(Movie.self)
            favoriteMovies = Array(results)
            onCompleted(nil)
        } catch {
            onCompleted(error)
        }
    }
    
    func updateRealm(indexPath: IndexPath, onCompleted: (Error?) -> Void) {
        let movie = self.movies[indexPath.row]
        do {
            let realm = try Realm()
            if let object = realm.object(ofType: Movie.self, forPrimaryKey: movie.id) {
                try realm.write {
                    updateFavorite(indexPath: indexPath, isFavorite: false)
                    realm.delete(object)
                }
            } else {
                try realm.write {
                    movie.isFavorite = true
                    realm.create(Movie.self, value: movie, update: .all)
                    updateFavorite(indexPath: indexPath, isFavorite: true)
                }
            }
            onCompleted(nil)
        } catch {
            onCompleted(error)
        }
    }
    
    func updateFavorite(indexPath: IndexPath, isFavorite: Bool) {
        switch movieType {
        case .playing:
            playingMovies[indexPath.row].isFavorite = isFavorite
        case .favorite:
            let movie = favoriteMovies[indexPath.row]
            favoriteMovies[indexPath.row].isFavorite = isFavorite
            
            let mvComming = upcommingMovies.first { movie.id == $0.id }
            mvComming?.isFavorite = isFavorite
            
            let mvPlaying = playingMovies.first { movie.id == $0.id }
            mvPlaying?.isFavorite = isFavorite
        case .upcomming:
            upcommingMovies[indexPath.row].isFavorite = isFavorite
        }
    }
    
    func syncFavoriteAllMovies() {
        playingMovies.forEach { movie in
            movie.isFavorite = favoriteMovies.first(where: { $0.id == movie.id }) != nil
        }
        upcommingMovies.forEach { movie in
            movie.isFavorite = favoriteMovies.first(where: { $0.id == movie.id }) != nil
        }
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return movies.count
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> MoviesCollectionViewCellViewModel? {
        guard movies.count > indexPath.row else { return nil }
        let movie = movies[indexPath.row]
        return MoviesCollectionViewCellViewModel(movie: movie)
    }
    
    func getDetailViewModel(atIndexPath indexPath: IndexPath) -> DetailViewModel {
        guard 0 <= indexPath.row && indexPath.row < movies.count else { return DetailViewModel() }
        return DetailViewModel(movie: movies[indexPath.row])
    }
}
