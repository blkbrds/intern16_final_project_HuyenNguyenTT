//
//  MoviesCollectionViewCell.swift
//  FinalProject
//
//  Created by bu on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

final class MoviesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: - Properties
    var viewModel: MoviesCollectionViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Function
    private func updateView() {
        guard let viewModel = viewModel else { return }
        movieImageView.sd_setImage(with: URL(string: viewModel.imageName))
    }
}
