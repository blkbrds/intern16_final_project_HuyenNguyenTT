//
//  HomeViewController.swift
//  FinalProject
//
//  Created by bu on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SideMenu

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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configUI()
        configCollectionView()
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
        navigationController?.navigationBar.barTintColor = .black
    }
    
    private func configUI() {
        bookButton.layer.cornerRadius = 10
    }
    
    private func configCollectionView() {
        let nib = UINib(nibName: "MoviesCollectionViewCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Action
    @IBAction private func playingButtonTouchUpInside(_ sender: UIButton) { }
    
    @IBAction private func upcomingButtonTouchUpInside(_ sender: UIButton) { }
    
    @IBAction private func bookButtonTouchUpInside(_ sender: UIButton) { }
    
    // MARK: - Objc
    @objc private func profileTouchUpInside() { }
    
    @objc private func menuTouchUpInside() {
        present(sideMenu, animated: true)
    }
}

// Add Menu VC
//class MenuViewController: UIViewController {}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2, height: 250)
    }
}
