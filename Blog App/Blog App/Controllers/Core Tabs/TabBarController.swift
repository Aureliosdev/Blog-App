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
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: profile)
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 2)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        setViewControllers([nav1,nav2], animated: true)
    }
 

}
