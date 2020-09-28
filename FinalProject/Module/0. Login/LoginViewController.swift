//
//  LoginViewController.swift
//  FinalProject
//
//  Created by bu on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userNameTextField: UITextField!
    
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: - Properties
    private var viewModel = LoginViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Private func
    private func configUI() {
        userNameLabel.text = "Tên đăng nhập"
        userNameTextField.placeholder = "Nhập tên đăng nhập"
        userNameTextField.delegate = self
        passwordLabel.text = "Mật khẩu"
        passwordTextField.placeholder = "Nhập mật khẩu đăng nhập"
        passwordTextField.delegate = self
        
        loginButton.layer.cornerRadius = loginButton.bounds.height / 2
                
        userNameTextField.returnKeyType = UIReturnKeyType.next
        passwordTextField.returnKeyType = UIReturnKeyType.done
        
        backgroundImageView.addBlackGradientLayerInForeground(frame: self.backgroundImageView.bounds, colors: [.clear, .black])
    }
    
    // MARK: - IBActions
    @IBAction private func loginButtonTouchUpInside(_ sender: UIButton) {
        guard let userName = userNameTextField.text, let password = passwordTextField.text, !userName.isEmpty, !password.isEmpty else {
            #warning("Show alert need input value")
            return
        }
        viewModel.requestLogin(username: userName, password: password) { isSuccess in
            switch isSuccess {
            case true:
                SceneDelegate.shared.changeRoot(screen: .home)
            case false:
                // Show alert
                break
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    private func switchBasedNextTextField(_ textField: UITextField) {
    switch textField {
    case self.userNameTextField:
        passwordTextField.becomeFirstResponder()
    default:
        loginButtonTouchUpInside(loginButton)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
}
