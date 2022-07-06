//
//  SceneDelegate.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 02.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
       
        let vc: UIViewController
        if AuthManager.shared.isSignedIn {
            vc = TabBarController()
        }else {
            let SignInVC = SignInViewController()
            SignInVC.navigationItem.largeTitleDisplayMode = .always
            let NavVc = UINavigationController(rootViewController: SignInVC)
            NavVc.navigationBar.prefersLargeTitles = true
            vc = NavVc
            
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
        
      
    }

    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
     
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

