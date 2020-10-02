//
//  LoginViewModel.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

typealias APICompletion = (Bool) -> Void

final class LoginViewModel {
    func requestLogin(username: String, password: String, completion: @escaping APICompletion) {
        completion(true)
        #warning("Make request here")
    }
}
