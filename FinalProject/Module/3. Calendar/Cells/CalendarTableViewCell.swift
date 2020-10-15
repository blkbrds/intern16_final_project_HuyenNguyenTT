//
//  CalendarTableViewCell.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/13/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet private weak var cinemaLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: CalendarTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.register(CalendarCollectionViewCell.self)
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 50, height: 25)
        }
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        cinemaLabel.text = viewModel.name
        collectionView.reloadData()
    }
}

extension CalendarTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let cell = collectionView.dequeue(CalendarCollectionViewCell.self, at: indexPath)
        cell.viewModel = viewModel.viewModelForItems(at: indexPath)
        return cell
    }
}
