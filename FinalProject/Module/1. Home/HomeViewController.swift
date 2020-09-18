//
//  HomeViewController.swift
//  FinalProject
//
//  Created by bu on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet private weak var playingButton: UIButton!
    @IBOutlet private weak var upcommingButton: UIButton!
    @IBOutlet private weak var bookButton: UIButton!
    
    @IBOutlet private weak var linePlayingView: UIView!
    @IBOutlet private weak var lineUpcomingView: UIView!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Properties
    private var viewModel = HomeViewModel()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configUI()
        configCollectionView()
    }
    
    // MARK: - Private function
    private func configNavigation() {
        let profile = UIBarButtonItem(image: #imageLiteral(resourceName: "img_menu_logowhite"), style: .plain, target: self, action: #selector(profileTouchUpInside))
        navigationItem.leftBarButtonItem = profile
        let menuItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_home_menu"), style: .plain, target: self, action: #selector(menuTouchUpInside))
        navigationItem.rightBarButtonItem = menuItem
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.barTintColor = .black
    }
    
    private func configUI() {
        bookButton.layer.cornerRadius = 10
    }
    
    private func configCollectionView() {
        let nib = UINib(nibName: "MoviesCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Action
    @IBAction private func playingButtonTouchUpInside(_ sender: UIButton) { }
    
    @IBAction private func upcomingButtonTouchUpInside(_ sender: UIButton) { }
    
    @IBAction private func bookButtonTouchUpInside(_ sender: UIButton) { }
    
    // MARK: - Objc
    @objc private func profileTouchUpInside() { }
    
    @objc private func menuTouchUpInside() { }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
