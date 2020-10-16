//
//  MoviesCollectionViewCell.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

// MARK: - Protocol
protocol MoviesCollectionViewCellDelegate: class {
    func cell(_ cell: MoviesCollectionViewCell, needsPerform action: MoviesCollectionViewCell.Action)
}

final class MoviesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Types
    enum Action {
        case didTapFavorite(_ movie: Movie)
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var heartButton: UIButton!
    
    // MARK: - Properties
    var viewModel: MoviesCollectionViewCellViewModel? {
        didSet {
            updateView()
        }
    }
    weak var delegate: MoviesCollectionViewCellDelegate?
    
    // MARK: - Action
    @IBAction private func heartButtonTouchUpInside(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        if let delegate = delegate {
            delegate.cell(self, needsPerform: .didTapFavorite(viewModel.movie))
        }
    }
    
    // MARK: - Function
    private func updateView() {
        guard let viewModel = viewModel else { return }
        movieImageView.sd_setImage(with: URL(string: viewModel.imageName))
        let image = viewModel.isFavorite ? #imageLiteral(resourceName: "ic-heartfill") : #imageLiteral(resourceName: "ic-heart")
        heartButton.setImage(image, for: .normal)
    }
}

extension MoviesCollectionViewCell: DetailViewControllerDelegate {
    func controller(_ cell: DetailViewController, needsPerform action: DetailViewController.Action) {
        updateView()
    }
}
