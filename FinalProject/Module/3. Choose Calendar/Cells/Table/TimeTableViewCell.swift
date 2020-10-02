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
        configTableView()
    }

    private func configTableView() {}
    
}
