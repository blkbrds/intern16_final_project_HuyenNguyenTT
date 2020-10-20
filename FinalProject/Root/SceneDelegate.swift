//
//  SceneDelegate.swift
//  FinalProject
//
//  Created by MBA0321 on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SideMenu
import SVProgressHUD

typealias HUD = SVProgressHUD

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    enum Screen {
        case login
        case home
    }
    
    static var shared: SceneDelegate {
        guard let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError("Can not case scene delegate")
        }
        return scene
    }
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window = self.window
        }
        changeRoot(screen: .login)
        window.makeKeyAndVisible()
        customHUD()
    }
    
    func changeRoot(screen: Screen) {
        switch screen {
        case .login:
            window?.rootViewController = LoginViewController()
        case .home:
            let homeVC = HomeViewController()
            let navigationController = UINavigationController(rootViewController: homeVC)
            window?.rootViewController = navigationController
        }
    }
    
    func customHUD() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(#colorLiteral(red: 0.999976337, green: 0.6980721354, blue: 0.1373093724, alpha: 1))
        SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.1293964982, green: 0.1294215322, blue: 0.1293910444, alpha: 1))
    }
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
        
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

