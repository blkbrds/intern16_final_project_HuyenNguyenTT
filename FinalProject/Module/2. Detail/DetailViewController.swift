//
//  DetailViewController.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 9/28/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

protocol DetailViewControllerDelegate: class {
    func controller(_ controller: DetailViewController, needsPerform action: DetailViewController.Action)
}

class DetailViewController: UIViewController {
    
    enum Action {
        case didUpdateFavorite(_ movie: Movie)
    }
    
    // MARK: - Outlet
    @IBOutlet private weak var youtubeButton: UIButton!
    @IBOutlet private weak var heartButton: UIButton!
    
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
    weak var delegate: DetailViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configRealm()
        getDetail()
    }
    
    // MARK: - Function
    private func configUI() {
        navigationController?.navigationBar.isHidden = true
        headerImageView.layer.opacity = 0.2
    }
    
    private func updateUI() {
        nameLabel.text = viewModel.movie.name
        genreLabel.text = viewModel.movie.genre
        movieEndTimeLabel.text = "\(viewModel.movie.movieEndtime)"
        
        let releaseDate = viewModel.movie.releaseDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: releaseDate) else { return }
        releaseDateLabel.text = date.toString(format: "dd-MM-yyyy")
        
        ratingCodeLabel.text = viewModel.movie.ratingCode
        fullDescriptionLabel.text = viewModel.movie.fullDescription
        movieDirectorLabel.text = viewModel.movie.movieDirector
        movieActress.text = viewModel.movie.movieActress
        movieLanguage.text = viewModel.movie.movieLanguage
        
        headerImageView.sd_setImage(with: URL(string: viewModel.movie.thumbnail))
        contentImageView.sd_setImage(with: URL(string: viewModel.movie.thumbnail))
        
        updateButton()
    }
    
    private func getDetail() {
        HUD.show()
        viewModel.getDetail(id: viewModel.movie.id) { [weak self] (result) in
            HUD.dismiss()
            switch result {
            case .success:
                self?.updateUI()
            case .failure(let error):
                self?.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
            }
        }
    }
    
    private func configRealm() {
        viewModel.setupRealm { [weak self] error in
            guard let error = error else { return }
            self?.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
        }
        viewModel.delegate = self
    }
    
    private func updateButton() {
        let image = viewModel.movie.isFavorite ? #imageLiteral(resourceName: "ic-heartfill") : #imageLiteral(resourceName: "ic-heart")
        heartButton.setImage(image, for: .normal)
    }
    
    // MARK: - Action
    @IBAction private func backTouchUpInside(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.layer.opacity = 1
    }
    
    @IBAction private func youtubeTouchUpInside(_ sender: UIButton) {
        let videoURL = URL(string: viewModel.movie.movieTrailer)
        guard let URL = videoURL else { return }
        let player = AVPlayer(url: URL)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    @IBAction private func heartTouchUpInside(_ sender: UIButton) {
        viewModel.updateData { [weak self] error in
            guard let error = error else { return }
            self?.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
        }
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func viewModel(_ viewModel: DetailViewModel, needsPerform action: DetailViewModel.Action) {
        switch action {
        case .reloadData:
            updateButton()
            delegate?.controller(self, needsPerform: .didUpdateFavorite(viewModel.movie))
        }
    }
}
