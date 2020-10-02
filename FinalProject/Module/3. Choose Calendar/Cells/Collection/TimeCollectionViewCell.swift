//
//  TimeCollectionViewCell.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/2/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var timeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction private func chooseTimeTouchUpInside(sender: UIButton) {}

}
