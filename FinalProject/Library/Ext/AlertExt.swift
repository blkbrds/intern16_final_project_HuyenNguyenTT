//
//  AlertExt.swift
//  FinalProject
//
//  Created by Huyen Nguyen T.T.[2] on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(alertText: String, alertMessage: String) {
    let alert = UIAlertController(title: alertText,
                   message: alertMessage,
                   preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
