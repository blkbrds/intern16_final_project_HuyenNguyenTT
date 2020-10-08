//
//  UIViewControllerExt.swift
//  FinalProject
//
//  Created by bu on 10/8/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

var vSpinner: UIView?

extension UIViewController {
    func showSpinner(onView: UIView) {
        // Add UIView
        let spinnerView = UIView()
        spinnerView.frame = onView.bounds
        spinnerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        spinnerView.alpha = 0.5
        
        // Add UIActivityIndicatorView
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = .white
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
