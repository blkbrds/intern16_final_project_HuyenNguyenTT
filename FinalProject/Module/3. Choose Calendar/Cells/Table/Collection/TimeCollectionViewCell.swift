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
        configButton()
        }
    
    private func configButton() {
        timeButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction private func chooseTimeTouchUpInside(sender: UIButton) {
        sender.layer.backgroundColor = #colorLiteral(red: 0.999976337, green: 0.6980721354, blue: 0.1373093724, alpha: 1)
    }

}
