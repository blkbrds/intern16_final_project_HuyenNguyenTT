//
//  Networkable.swift
//  FinalProject
//
//  Created by Hai Ca on 9/9/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<ServiceAPI> { get }
    func getMovies(completion: @escaping (_ result: Result<[Movie], Error>) -> Void)
    func getDetail(id: String, completion: @escaping (_ result: Result<Movie, Error>) -> Void)
}
