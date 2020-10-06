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
    func syncFavorite(viewModel: HomeViewModel, needperformAction action: HomeViewModel.Action)
}

final class HomeViewModel {
    
    // MARK: - Enum
    enum Action {
        case reloadData
    }
    // Types
    enum MovieType: Int {
        case playing = 0, upcomming
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
    
    init() {
        setupObserve()
    }
    
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
                            this.favoriteMovies.append(movie)
                        }
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
                    this.fetchData()
                    delegate.syncFavorite(viewModel: this, needperformAction: .reloadData)
                }
            })
        } catch {
            print(error)
        }
    }
    
    func fetchData() {
        do {
            let realm = try Realm()
            let results = realm.objects(Movie.self)
            favoriteMovies = Array(results)
        } catch {
            print(error)
        }
    }
    
    func addFavorite(id: String, categoryID: Int, name: String, thumbnail: String, releaseDate: String) {
        do {
            let realm = try Realm()
            let movie = Movie()
            movie.id = id
            movie.categoryID = categoryID
            movie.name = name
            movie.thumbnail = thumbnail
            movie.releaseDate = releaseDate
            try realm.write {
                realm.add(movie, update: .all)
                checkFavorite(favorite: true, id: id)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteItemFavorite(id: String) {
        do {
            let realm = try Realm()
            let result = realm.objects(Movie.self).filter("id = '\(id)'")
            try realm.write {
                realm.delete(result)
                checkFavorite(favorite: false, id: id)
            }
        } catch {
            print(error)
        }
    }
    
    func checkFavorite(favorite: Bool, id: String) {
        for movie in movies where movie.id == id {
            movie.isFavorite = favorite
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
