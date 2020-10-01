//
//  DetailViewController.swift
//  FinalProject
//
//  Created by bu on 9/28/20.
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
        nameLabel.text = viewModel.detail.name
        genreLabel.text = viewModel.detail.genre
        movieEndTimeLabel.text = "\(viewModel.detail.movieEndtime)"
        releaseDateLabel.text = viewModel.detail.releaseDate
        ratingCodeLabel.text = viewModel.detail.ratingCode
        fullDescriptionLabel.text = viewModel.detail.fullDescription
        movieDirectorLabel.text = viewModel.detail.movieDirector
        movieActress.text = viewModel.detail.movieActress
        movieLanguage.text = viewModel.detail.movieLanguage
        
        headerImageView.sd_setImage(with: URL(string: viewModel.detail.thumbnail))
        contentImageView.sd_setImage(with: URL(string: viewModel.detail.thumbnail))
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func youtubeTouchUpInside(_ sender: UIButton) {}
    
    @IBAction private func bookTouchUpInside(_ sender: UIButton) {}
}
