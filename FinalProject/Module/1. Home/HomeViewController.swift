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
    
    // MARK: - Outlets
    @IBOutlet private weak var tabPlayingButton: UIButton!
    @IBOutlet private weak var tabUpcommingButton: UIButton!
    @IBOutlet private weak var tabFavoriteButton: UIButton!
    @IBOutlet private weak var calendarButton: UIButton!
    
    @IBOutlet private weak var linePlayingView: UIView!
    @IBOutlet private weak var lineUpcomingView: UIView!
    @IBOutlet private weak var lineFavoriteView: UIView!
    
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
        configCollectionView()
        configButton()
        getMovies()
        configSyncRealmData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private function
    private func configNavigation() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(#imageLiteral(resourceName: "ic-profile-navi"), for: .normal)
        let leftItm = UIBarButtonItem(customView: button)
        let menuItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-sidemenu"), style: .plain, target: self, action: #selector(menuTouchUpInside))
        navigationItem.rightBarButtonItem = menuItem
        navigationItem.leftBarButtonItem = leftItm
        
        // set side menu
        sideMenu.leftSide = false
        SideMenuManager.default.rightMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        sideMenu.sideMenuDelegate = self
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
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
    
    private func configButton() {
        calendarButton.layer.cornerRadius = calendarButton.bounds.height / 2
    }
    
    private func getMovies() {
        HUD.show()
        viewModel.getMovies { [weak self] (result) in
            HUD.dismiss()
            switch result {
            case .success:
                self?.reloadData()
            case .failure(let error):
                self?.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
            }
        }
    }
    
    private func configSyncRealmData() {
        viewModel.setupRealm { [weak self] (error) in
            guard let error = error else { return }
            self?.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
        }
        viewModel.delegate = self
    }
    
    // MARK: - Actions
    @IBAction private func tabPlayingButtonTouchUpInside(_ sender: UIButton) {
        guard viewModel.movieType != .playing else { return }
        
        // set UI
        tabPlayingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        linePlayingView.backgroundColor = #colorLiteral(red: 0.999976337, green: 0.6980721354, blue: 0.1373093724, alpha: 1)
        tabUpcommingButton.titleLabel?.font = .systemFont(ofSize: 15)
        lineUpcomingView.backgroundColor = .black
        tabFavoriteButton.titleLabel?.font = .systemFont(ofSize: 15)
        lineFavoriteView.backgroundColor = .black
        
        viewModel.movieType = .playing
        reloadData()
    }
    
    @IBAction private func tabUpcomingButtonTouchUpInside(_ sender: UIButton) {
        guard viewModel.movieType != .upcomming else { return }
        
        // set UI
        tabPlayingButton.titleLabel?.font = .systemFont(ofSize: 15)
        linePlayingView.backgroundColor = .black
        tabUpcommingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        lineUpcomingView.backgroundColor = #colorLiteral(red: 0.999976337, green: 0.6980721354, blue: 0.1373093724, alpha: 1)
        tabFavoriteButton.titleLabel?.font = .systemFont(ofSize: 15)
        lineFavoriteView.backgroundColor = .black
        
        viewModel.movieType = .upcomming
        reloadData()
    }
    
    @IBAction private func tabFavoriteButtonTouchUpInside(_ sender: UIButton) {
        guard viewModel.movieType != .favorite else { return }
        
        // set UI
        tabPlayingButton.titleLabel?.font = .systemFont(ofSize: 15)
        linePlayingView.backgroundColor = .black
        tabUpcommingButton.titleLabel?.font = .systemFont(ofSize: 15)
        lineUpcomingView.backgroundColor = .black
        tabFavoriteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        lineFavoriteView.backgroundColor = #colorLiteral(red: 0.999976337, green: 0.6980721354, blue: 0.1373093724, alpha: 1)
        
        viewModel.movieType = .favorite
        reloadData()
    }
    
    @IBAction private func calendarButtonTouchUpInside(_ sender: UIButton) {
        let calendarVC = CalendarViewController()
        //TODO
        let movie = viewModel.movies[currentIndexPath.row]
        calendarVC.viewModel = CalendarViewModel(movie: movie)
        let backButton = UIBarButtonItem(title: movie.name, style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(calendarVC, animated: true)
    }
    
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
        guard let movie = viewModel.movies[safeIndex: currentIndexPath.row] else { return }
        movieNameLabel.text = movie.name
        let releaseDate = movie.releaseDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: releaseDate) else { return }
        dateLabel.text = "Khởi chiếu: " + date.toString(format: "dd-MM-yyyy")
        calendarButton.isHidden = Int(movie.sku) == nil
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
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2, height: 2 * UIScreen.main.bounds.height / 5)
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
        detailVC.delegate = self
        detailVC.viewModel = viewModel.getDetailViewModel(atIndexPath: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Extension HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func viewModel(_ viewModel: HomeViewModel, needsPerform action: HomeViewModel.Action) {
        collectionView.reloadData()
    }
}

// MARK: - Extension MoviesCollectionViewCellDelegate
extension HomeViewController: MoviesCollectionViewCellDelegate {
    func cell(_ cell: MoviesCollectionViewCell, needsPerform action: MoviesCollectionViewCell.Action) {
        guard let indexPath: IndexPath = collectionView.indexPath(for: cell) else { return }
        viewModel.updateRealm(indexPath: indexPath) { [weak self] (error) in
            guard let error = error else { return }
            self?.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
        }
    }
}

extension HomeViewController: DetailViewControllerDelegate {
    func controller(_ controller: DetailViewController, needsPerform action: DetailViewController.Action) {
        switch action {
        case .didUpdateFavorite(let movie):
            viewModel.updateFavoriteDetail(movie: movie)
            collectionView.reloadData()
        }
    }
}

extension HomeViewController: SideMenuNavigationControllerDelegate {
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        getMovies()
    }
}
