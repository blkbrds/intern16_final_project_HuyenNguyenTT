//
//  DetailViewController.swift
//  FinalProject
//
//  Created by bu on 9/28/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

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
    }
    
    // MARK: - Function
    private func configUI() {
        navigationController?.navigationBar.layer.opacity = 0
        headerImageView.layer.opacity = 0.5
        bookButton.layer.cornerRadius = bookButton.bounds.height / 2
    }
    
    private func updateUI() {
        nameLabel.text = viewModel.detail.name
        genreLabel.text = viewModel.detail.genre
        movieEndTimeLabel.text = "\(viewModel.detail.movieEndtime)"
        releaseDateLabel.text = viewModel.detail.releaseDate
        fullDescriptionLabel.text = viewModel.detail.fullDescription
        movieDirectorLabel.text = viewModel.detail.movieDirector
        movieActress.text = viewModel.detail.movieActress
        movieLanguage.text = viewModel.detail.movieLanguage
        
    }
    
    // MARK: - Action
    @IBAction private func backTouchUpInside(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.layer.opacity = 1
    }
    
    @IBAction private func youtubeTouchUpInside(_ sender: UIButton) {}
    
    @IBAction private func bookTouchUpInside(_ sender: UIButton) {}
}
