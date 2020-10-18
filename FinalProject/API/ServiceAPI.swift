//
//  ServiceAPI.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 8/30/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya

enum ServiceAPI {
    case login(email: String, password: String)
    case detail(id: String)
    case movies(cat: Int)
    case showtimes(sku: String, date: String)
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
        case .login:
            return "customer/login"
        case .movies:
            return "movie/listSneakShow"
        case .detail(let id):
            return "movie/movie/id/\(id)"
        case .showtimes(let sku, let date):
            return "movie/showtimes/sku/\(sku)/date/\(date)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .movies, .detail, .showtimes:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .login(email: let email, password: let password):
            let params = ["email": email, "password": password, "signature": "UPaRuOfUQL2CGOTIr885/fCNyXT8/wenO6cUnu2mTvA="]
            return .requestParameters(parameters: params, encoding: URLEncoding.httpBody)
        case .movies(let cat):
            return .requestParameters(parameters: ["cat": cat], encoding: URLEncoding.default)
        case .detail(id: let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.default)
        case .showtimes:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        var headers: [String: String] = [:]
        switch self {
        case .login:
            headers["Content-type"] = "application/x-www-form-urlencoded"
            headers["X-Device"] = "iOS_14.0_2.2.8"
        default:
            headers["Content-type"] = "application/json"
        }
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
