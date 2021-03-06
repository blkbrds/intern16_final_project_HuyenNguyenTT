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
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        provider.request(.login(email: email, password: password)) { (result) in
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
                if let data = json["data"] as? JSON, let user = User(JSON: data) {
                    completion(.success(user))
                    return
                }
                completion(.failure(NSError(domain: "", code: 3_840, userInfo: [NSLocalizedDescriptionKey: "json"])))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
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
    
    func getShowtime(sku: String, date: String, completion: @escaping (Result<[Location], Error>) -> Void) {
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
                
                if let data = json["data"] as? [JSON],
                    let locationsJson = data.first?["locations"] as? [JSON] {
                    let locations = locationsJson.compactMap { Location(JSON: $0) }
                    completion(.success(locations))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
