//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/28/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift

protocol DetailViewModelDelegate: class {
    func viewModel(_ viewModel: DetailViewModel, needsPerform action: DetailViewModel.Action)
}

final class DetailViewModel {
    
    enum Action {
        case reloadData
    }
    
    // MARK: - Properties
    private var favoriteMovies: [Movie] = []
    var movie: Movie
    private var notificationToken: NotificationToken?
    weak var delegate: DetailViewModelDelegate?

    init(movie: Movie = Movie()) {
        self.movie = movie
    }
    
    // MARK: - Function
    func getDetail(id: String, completion: @escaping (APIResult) -> Void) {
        apiProvider.getDetail(id: movie.id) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let detail):
                for movie in this.favoriteMovies where movie.id == detail.id {
                    detail.isFavorite = true
                    break
                }
                this.movie = detail
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setupRealm(failure: @escaping (Error) -> Void) {
        setupObserve(failure: failure)
        fetchRealmData(failure: failure)
    }
    
    func updateData(failure: (Error) -> Void) {
        do {
            let realm = try Realm()
            if let object = realm.object(ofType: Movie.self, forPrimaryKey: movie.id) {
                try realm.write {
                    movie.isFavorite = false
                    realm.delete(object)
                }
            } else {
                try realm.write {
                    movie.isFavorite = true
                    realm.create(Movie.self, value: movie, update: .all)
                }
            }
        } catch {
            failure(error)
        }
    }
    
    private func setupObserve(failure: @escaping (Error) -> Void) {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Movie.self).observe({ [weak self] _ in
                guard let this = self else { return }
                if let delegate = this.delegate {
                    this.fetchRealmData(failure: failure)
                    delegate.viewModel(this, needsPerform: .reloadData)
                }
            })
        } catch {
            failure(error)
        }
    }
    
    private func fetchRealmData(failure: (Error) -> Void) {
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = %@", movie.id)
            let result = realm.objects(Movie.self).filter(predicate)
            favoriteMovies = Array(result)
        } catch {
            failure(error)
        }
    }
}
