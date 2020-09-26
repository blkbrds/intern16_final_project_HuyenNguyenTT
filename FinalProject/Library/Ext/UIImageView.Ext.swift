//
//  UIImageView.Ext.swift
//  FinalProject
//
//  Created by bu on 9/25/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UIView {
    // For insert layer in Foreground
    func addBlackGradientLayerInForeground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map { $0.cgColor }
        self.layer.addSublayer(gradient)
    }
    // For insert layer in background
    func addBlackGradientLayerInBackground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}
