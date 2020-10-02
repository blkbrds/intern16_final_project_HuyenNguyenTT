//
//  TimeTableViewCell.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/2/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TimeTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }

    private func configCollectionView() {
        collectionView.register(TimeCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension TimeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(TimeCollectionViewCell.self, at: indexPath)
        return cell
    }
}

extension TimeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 25)
    }
}
