//
//  SignInViewController.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 07.07.2022.
//

import UIKit

class SignInViewController: UITabBarController {

    //Header View
    
    
    //Email field
    
    //password field
    
    //Sign in button
    
    //Create Account
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
                title = " Sign In"
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if !IAPManager.shared.isPremium() {
                let vc = PayWallViewController()
                let navVC = UINavigationController(rootViewController: vc)
                self.present(navVC,animated: true,completion: nil)
            }
        }
    }
    

 

}
