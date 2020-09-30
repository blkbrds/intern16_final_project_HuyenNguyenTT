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
    var viewModel = HomeViewModel()
    var menuController: UIViewController?
    var sideMenu = SideMenuNavigationController(rootViewController: MenuViewController())
    
    enum TypeSegment: Int {
        case dangChieu = 0
        case sapChieu
    }
    
    private var currentType: TypeSegment = .dangChieu {
        didSet {
            getMovies(withCategoryId: currentType.rawValue)
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configButton()
        configCollectionView()
//        getMovies(withCategoryId: currentType.rawValue)
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
    
    private func setSegment() {
        
    }
    
    private func getMovies(withCategoryId id: Int) {
        viewModel.getMovies(withCategoryId: id) { (result) in
            switch result {
            case .success:
                self.collectionView.reloadData()
            case .failure(_):
                print("No data")
            }
        }
    }
    
    // MARK: - Action
    @IBAction private func playingButtonTouchUpInside(_ sender: UIButton) {
        // set UI
        playingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        linePlayingView.backgroundColor = #colorLiteral(red: 0.999976337, green: 0.6980721354, blue: 0.1373093724, alpha: 1)
        upcommingButton.titleLabel?.font = .none
        lineUpcomingView.backgroundColor = .black
        guard currentType != .dangChieu else { return }
        currentType = .dangChieu
    }
    
    @IBAction private func upcomingButtonTouchUpInside(_ sender: UIButton) {
        // set UI
        playingButton.titleLabel?.font = .none
        linePlayingView.backgroundColor = .black
        upcommingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        lineUpcomingView.backgroundColor = #colorLiteral(red: 0.999976337, green: 0.6980721354, blue: 0.1373093724, alpha: 1)
        guard currentType != .sapChieu else { return }
        currentType = .sapChieu
    }
    
    @IBAction private func bookButtonTouchUpInside(_ sender: UIButton) { }
    
    // MARK: - Objc
    @objc private func profileTouchUpInside() { }
    
    @objc private func menuTouchUpInside() {
        present(sideMenu, animated: true)
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
            movieNameLabel.text = viewModel.movies[visibleIndexPath[1]].name
            dateLabel.text = viewModel.movies[visibleIndexPath[1]].releaseDate
        }
    }
}
