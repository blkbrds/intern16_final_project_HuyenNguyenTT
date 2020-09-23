//
//  DataManager.swift
//  FinalProject
//
//  Created by bu on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class DataManager {
    static func movies() -> [Movie] {
        let images: [Movie] = [Movie(categoryId: 0, imageName: "img_home_movie"),
                            Movie(categoryId: 0, imageName: "img_home_movie"),
                            Movie(categoryId: 0, imageName: "img_home_movie"),
                            Movie(categoryId: 0, imageName: "img_home_movie"),
                            Movie(categoryId: 0, imageName: "img_home_movie")]
        return images
    }
}
