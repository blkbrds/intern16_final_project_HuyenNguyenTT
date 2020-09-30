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
    var id: String = ""
    var detail: Detail
    
    init(detail: Detail = Detail()) {
        self.detail = detail
    }

    // MARK: - Function
    func getDetail(completion: @escaping (APIResult) -> Void) {
        apiProvider.getDetail { (result) in
            switch result {
            case .success(let detail):
                self.detail = detail
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
