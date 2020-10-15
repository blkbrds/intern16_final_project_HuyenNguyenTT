//
//  NetworkManager.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/9/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya
import RxSwift

enum APIResult {
    case success
    case failure(Error)
}

typealias JSON = [String: Any]

let apiProvider = NetworkManager.shared

class NetworkManager: Networkable {
    
    var provider = MoyaProvider<ServiceAPI>()
    static let shared = NetworkManager()
    let detailVM = DetailViewModel()
    
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        provider.request(.movies(cat: 2)) { result in
            switch result {
            case .success(let response):
                guard let filterResponse = try? response.filterSuccessfulStatusCodes() else {
                    completion(.failure(MoyaError.statusCode(response)))
                    return
                }
                guard let json = try? filterResponse.mapJSON() as? JSON else {
                    completion(.failure(MoyaError.jsonMapping(response)))
                    return
                }
                if let data = json["data"] as? [JSON] {
                    let movies = data.compactMap { Movie(JSON: $0) }
                    completion(.success(movies))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDetail(id: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        provider.request(.detail(id: id)) { (result) in
            switch result {
            case .success(let response):
                guard let filterResponse = try? response.filterSuccessfulStatusCodes() else {
                    completion(.failure(MoyaError.statusCode(response)))
                    return
                }
                guard let json = try? filterResponse.mapJSON() as? JSON else {
                    completion(.failure(MoyaError.jsonMapping(response)))
                    return
                }
                if let data = json["data"] as? JSON, let detail = Movie(JSON: data) {
                    completion(.success(detail))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getShowtime(sku: String, date: String, completion: @escaping (Result<[Session], Error>) -> Void) {
        provider.request(.showtimes(sku: sku, date: date)) { (result) in
            switch result {
            case .success(let response):
                guard let filterResponse = try? response.filterSuccessfulStatusCodes() else {
                    completion(.failure(MoyaError.statusCode(response)))
                    return
                }
                
                guard let json = try? filterResponse.mapJSON() as? JSON else {
                    completion(.failure(MoyaError.jsonMapping(response)))
                    return
                }
                
                if let data = json["data"] as? [JSON] {
                    let sessions = data.compactMap { Session(JSON: $0) }
                    completion(.success(sessions))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
