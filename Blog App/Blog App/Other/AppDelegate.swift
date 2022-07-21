//
//  AppDelegate.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 02.07.2022.
//

import UIKit
import Purchases
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_uKGlHGzcgiDtzSovnEkBphgmRAw")
        IAPManager.shared.getSubscriptionStatus(completion: nil)
        IAPManager.shared.fetchPackages { package in
            guard let package = package else { return }
            print("Got Package! ")
            IAPManager.shared.subscribe(package: package) { success in
                print("Success \(success)")
            }
                
            
        }
        return true
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
    }


}

