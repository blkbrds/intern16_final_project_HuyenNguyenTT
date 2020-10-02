//
//  DetailViewController.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/28/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet private weak var youtubeButton: UIButton!
    @IBOutlet private weak var bookButton: UIButton!
    
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var contentImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var movieEndTimeLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var ratingCodeLabel: UILabel!
    
    @IBOutlet private weak var fullDescriptionLabel: UILabel!
    @IBOutlet private weak var movieDirectorLabel: UILabel!
    @IBOutlet private weak var movieActress: UILabel!
    @IBOutlet private weak var movieLanguage: UILabel!
    
    // MARK: - Properties
    var viewModel = DetailViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        updateUI()
        getDetail()
    }
    
    // MARK: - Function
    private func configUI() {
        navigationController?.navigationBar.layer.opacity = 0
        headerImageView.layer.opacity = 0.2
        bookButton.layer.cornerRadius = bookButton.bounds.height / 2
    }
    
    private func updateUI() {
        nameLabel.text = viewModel.movie.name
        genreLabel.text = viewModel.movie.genre
        movieEndTimeLabel.text = "\(viewModel.movie.movieEndtime)"
        releaseDateLabel.text = viewModel.movie.releaseDate
        ratingCodeLabel.text = viewModel.movie.ratingCode
        fullDescriptionLabel.text = viewModel.movie.fullDescription
        movieDirectorLabel.text = viewModel.movie.movieDirector
        movieActress.text = viewModel.movie.movieActress
        movieLanguage.text = viewModel.movie.movieLanguage
        
        headerImageView.sd_setImage(with: URL(string: viewModel.movie.thumbnail))
        contentImageView.sd_setImage(with: URL(string: viewModel.movie.thumbnail))
    }
    
    private func getDetail() {
        viewModel.getDetail(id: viewModel.movie.id) { (result) in
            switch result {
            case .success:
                self.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Action
    @IBAction private func backTouchUpInside(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.layer.opacity = 1
    }
    
    @IBAction private func youtubeTouchUpInside(_ sender: UIButton) {}
    
    @IBAction private func bookTouchUpInside(_ sender: UIButton) {}
}
