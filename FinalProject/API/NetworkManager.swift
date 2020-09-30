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
                if let errors = json["errors"] as? [JSON],
                    let first = errors.first,
                    let apiError = APIError(JSON: first) {
                    let error = NSError(domain: response.request?.url?.host ?? "",
                                        code: apiError.code,
                                        userInfo: [NSLocalizedDescriptionKey: apiError.detail])
                    completion(.failure(error))
                    return
                }
                completion(.failure(MoyaError.jsonMapping(response)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
