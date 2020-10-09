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
    
    // MARK: - Initialization
    init() {
        setupObserve()
    }
    
    // MARK: - Function
    func getMovies(completion: @escaping (APIResult) -> Void) {
        fetchRealmData()
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
    
    private func setupObserve() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Movie.self).observe({ [weak self] _ in
                guard let this = self else { return }
                if let delegate = this.delegate {
                    this.fetchRealmData()
                    this.syncFavoriteAllMovies()
                    delegate.viewModel(this, needsPerform: .reloadData)
                }
            })
        } catch {
            print(error)
        }
    }
    
    private func fetchRealmData() {
        do {
            let realm = try Realm()
            let results = realm.objects(Movie.self)
            favoriteMovies = Array(results)
        } catch {
            print(error)
        }
    }
    
    func updateRealm(movie: Movie) {
        do {
            let realm = try Realm()
            if let object = realm.object(ofType: Movie.self, forPrimaryKey: movie.id) {
                try realm.write {
                    updateFavorite(favorite: false, id: movie.id)
                    realm.delete(object)
                }
            } else {
                try realm.write {
                    movie.isFavorite = true
                    updateFavorite(favorite: true, id: movie.id)
                    realm.create(Movie.self, value: movie, update: .all)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func updateFavorite(favorite: Bool, id: String) {
        for movie in playingMovies where movie.id == id {
            movie.isFavorite = favorite
        }
        for movie in upcommingMovies where movie.id == id {
            movie.isFavorite = favorite
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
