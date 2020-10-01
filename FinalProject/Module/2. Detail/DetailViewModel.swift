//
//  DetailViewModel.swift
//  FinalProject
//
//  Created by bu on 9/28/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class DetailViewModel {
    // MARK: - Properties
    var movie: Movie
    
    init(movie: Movie = Movie()) {
        self.movie = movie
    }

    // MARK: - Function
    func getDetail(id: String, completion: @escaping (APIResult) -> Void) {
        apiProvider.getDetail(id: movie.id) { (result) in
            switch result {
            case .success(let detail):
                self.movie = detail
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
