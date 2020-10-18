//
//  LoginViewModel.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class LoginViewModel {
    func requestLogin(email: String, password: String, completion: @escaping (APIResult) -> Void) {
        apiProvider.login(email: email, password: password) { (result) in
            switch result {
            case .success:
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
