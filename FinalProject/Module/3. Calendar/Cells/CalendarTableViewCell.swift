//
//  CalendarTableViewCell.swift
//  FinalProject
//
//  Created by bu on 10/13/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var cinemaLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.register(CalendarCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CalendarTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CalendarCollectionViewCell.self, at: indexPath)
        return cell
    }
}

extension CalendarTableViewCell: UICollectionViewDelegate {}
