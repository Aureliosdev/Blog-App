//
//  TabBarController.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 02.07.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

      setUpControllers()
    }
    
    private func setUpControllers() {
    let  home = HomeViewController()
        home.title = "Home"
    let profile = ProfileViewController()
        profile.title = " Profile"
        home.navigationItem.largeTitleDisplayMode = .always
        profile.navigationItem.largeTitleDisplayMode = .always
        home.tabBarItem.image = UIImage(systemName: "house")
        profile.tabBarItem.image = UIImage(systemName: "person.circle")
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: profile)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        setViewControllers([nav1,nav2], animated: true)
    }
 

}
