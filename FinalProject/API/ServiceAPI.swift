//
//  ServiceAPI.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 8/30/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya

enum ServiceAPI {
    case detail(id: String)
    case movies(cat: Int)
}

extension ServiceAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://www.cgv.vn/default/api/") else {
            fatalError("Invalid API URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .movies:
            return "movie/listSneakShow"
        case .detail(let id):
            return "movie/movie/id/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .movies, .detail:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .movies(let cat):
            return .requestParameters(parameters: ["cat": cat], encoding: URLEncoding.default)
        case .detail(id: let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        var headers: [String: String] = [:]
        headers["Content-type"] = "application/json"
        return headers
    }
}

extension Data {
    init(forResouce name: String?, ofType ext: String?) {
        @objc class TestClass: NSObject { }
        let bundle = Bundle.init(for: TestClass.self)
        guard let path = bundle.path(forResource: name, ofType: ext),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                fatalError("fatalError")
        }
        self = data
    }
}
