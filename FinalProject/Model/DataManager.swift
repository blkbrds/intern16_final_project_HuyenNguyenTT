//
//  DataManager.swift
//  FinalProject
//
//  Created by bu on 9/21/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class DataManager {
    static func movie() -> [Movies] {
        let images: [Movies] = [Movies(categoryId: 0, imageName: "img_home_movie"),
                                Movies(categoryId: 0, imageName: "img_home_movie1"),
                                Movies(categoryId: 0, imageName: "img_home_movie2"),
                                Movies(categoryId: 0, imageName: "img_home_movie3"),
                                Movies(categoryId: 0, imageName: "img_home_movie4"),
                                Movies(categoryId: 1, imageName: "img_home_movie5"),
                                Movies(categoryId: 1, imageName: "img_home_movie6"),
                                Movies(categoryId: 1, imageName: "img_home_movie7"),
                                Movies(categoryId: 1, imageName: "img_home_movie8"),
                                Movies(categoryId: 1, imageName: "img_home_movie9"),
                                Movies(categoryId: 1, imageName: "img_home_movie10"),
                                Movies(categoryId: 1, imageName: "img_home_movie11")]
        return images
    }
}
