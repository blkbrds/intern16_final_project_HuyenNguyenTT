//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Huyen on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SideMenu
import UPCarouselFlowLayout

final class HomeViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet private weak var playingButton: UIButton!
    @IBOutlet private weak var upcommingButton: UIButton!
    @IBOutlet private weak var bookButton: UIButton!
    
    @IBOutlet private weak var linePlayingView: UIView!
    @IBOutlet private weak var lineUpcomingView: UIView!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Properties
    private var currentIndexPath: IndexPath = IndexPath(row: 0, section: 0) {
        didSet {
            updateInfo()
        }
    }
    var viewModel = HomeViewModel()
    var menuController: UIViewController?
    var sideMenu = SideMenuNavigationController(rootViewController: MenuViewController())
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configButton()
        configCollectionView()
        getMovies()
    }
    
    // MARK: - Private function
    private func configNavigation() {
        let infoItem = UIBarButtonItem(image: #imageLiteral(resourceName: "img_menu_logowhite"), style: .plain, target: self, action: #selector(profileTouchUpInside))
        navigationItem.leftBarButtonItem = infoItem
        
        let menuItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_home_menu"), style: .plain, target: self, action: #selector(menuTouchUpInside))
        navigationItem.rightBarButtonItem = menuItem
        
        // set side menu
        sideMenu.leftSide = false
        SideMenuManager.default.rightMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func configButton() {
        bookButton.layer.cornerRadius = 10
    }
    
    private func configCollectionView() {
        collectionView.register(MoviesCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Custom collection
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 200, height: collectionView.contentSize.height)
        collectionView.collectionViewLayout = layout
        layout.sideItemScale = 0.6
        layout.sideItemAlpha = 0.2
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: -70)
        layout.scrollDirection = .horizontal
    }
    
    private func getMovies() {
        viewModel.getMovies { (result) in
            switch result {
            case .success:
                self.reloadData()
            case .failure(let error):
                self.showAlert(alertText: "Error", alertMessage: "\(error)")
            }
        }
    }
    
    // MARK: - Action
    @IBAction private func playingButtonTouchUpInside(_ sender: UIButton) {
        guard viewModel.movieType != .playing else { return }
        // set UI
        playingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        linePlayingView.backgroundColor = #colorLiteral(red: 0.999976337, green: 0.6980721354, blue: 0.1373093724, alpha: 1)
        upcommingButton.titleLabel?.font = .none
        lineUpcomingView.backgroundColor = .black
        
        viewModel.movieType = .playing
        reloadData()
    }
    
    @IBAction private func upcomingButtonTouchUpInside(_ sender: UIButton) {
        guard viewModel.movieType != .upcomming else { return }
        // set UI
        playingButton.titleLabel?.font = .none
        linePlayingView.backgroundColor = .black
        upcommingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        lineUpcomingView.backgroundColor = #colorLiteral(red: 0.999976337, green: 0.6980721354, blue: 0.1373093724, alpha: 1)
        viewModel.movieType = .upcomming
        reloadData()
    }
    
    @IBAction private func bookButtonTouchUpInside(_ sender: UIButton) { }
    
    // MARK: - Objc
    @objc private func profileTouchUpInside() { }
    
    @objc private func menuTouchUpInside() {
        present(sideMenu, animated: true)
    }
    
    private func reloadData() {
        currentIndexPath = IndexPath(row: 0, section: 0)
        collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: false)
        collectionView.reloadData()
        updateInfo()
    }
    
    private func updateInfo() {
        movieNameLabel.text = viewModel.movies[safeIndex: currentIndexPath.row]?.name
        dateLabel.text = viewModel.movies[safeIndex: currentIndexPath.row]?.releaseDate
    }
}

// MARK: - Extension
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(MoviesCollectionViewCell.self, at: indexPath)
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2, height: 250)
    }
    
    // Update label
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            currentIndexPath = visibleIndexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel = viewModel.getDetailViewModel(atIndexPath: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
