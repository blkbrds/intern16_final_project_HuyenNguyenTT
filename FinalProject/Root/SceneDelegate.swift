//
//  SceneDelegate.swift
//  FinalProject
//
//  Created by MBA0321 on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SideMenu

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
        changeRoot(screen: .login)
        window.makeKeyAndVisible()
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

    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
        
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

