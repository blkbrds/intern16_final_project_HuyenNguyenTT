//
//  CalendarCollectionViewCell.swift
//  FinalProject
//
//  Created by bu on 10/14/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeLabel.layer.borderWidth = 0.5
        timeLabel.layer.borderColor = UIColor.white.cgColor
    }
}
