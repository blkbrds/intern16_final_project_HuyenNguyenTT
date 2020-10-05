//
//  MoviesCollectionViewCell.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

final class MoviesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var heartButton: UIButton!
    
    // MARK: - Properties
    var viewModel: MoviesCollectionViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Action
    @IBAction private func heartButtonTouchUpInside(_ sender: UIButton) {
        
    }
    
    // MARK: - Function
    private func updateView() {
        guard let viewModel = viewModel else { return }
        movieImageView.sd_setImage(with: URL(string: viewModel.imageName))
    }
}
