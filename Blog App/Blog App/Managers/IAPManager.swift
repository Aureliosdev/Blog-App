//
//  lAPManager.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 02.07.2022.
//

import Foundation
import Purchases
import StoreKit

final class IAPManager {
    static let shared = IAPManager()
    
    //Revenue Cat Shared Secret
    //9eb0501030a848b2bcd519ef0c3941c0
    
    private init() {}
    
    func isPremium()-> Bool {
        return UserDefaults.standard.bool(forKey: "premium")
    }
    func getSubscriptionStatus(completion: ((Bool)-> Void)?){
        Purchases.shared.purchaserInfo { info, error in
            guard let entitlements = info?.entitlements,
                  error == nil else { return }
           
            if entitlements.all["Premium"]?.isActive == true {
                UserDefaults.standard.set(true, forKey: "premium")
                completion?(true)
            }else {
                print("got updated status subscribe ")
                UserDefaults.standard.set(false , forKey: "premium")
                completion?(false)
            }
        
        }
    }
    
    func fetchPackages(completion: @escaping (Purchases.Package?)-> Void) {
        Purchases.shared.offerings { offerings, error in
            guard let package = offerings?.offering(identifier: "default")?.availablePackages.first,
                  error == nil else {
                    completion(nil)
                return
            }
            completion(package)
        }
    }
    
    public func subscribe(package: Purchases.Package, completion: @escaping( Bool)-> Void) {
        guard !isPremium() else {
            completion(true)
            print("User  already subscribed")
            return
        }
        Purchases.shared.purchasePackage(package) { transaction, info, error, userCancelled in
            guard let transaction  = transaction,
                  let entitlements = info?.entitlements,
                error == nil,
                    !userCancelled  else { return }
            switch transaction.transactionState {
            
            case .purchasing:
                print("purchasing")
            case .purchased:
                print("purchased \(entitlements)")
                if entitlements.all["Premium"]?.isActive == true {
                    UserDefaults.standard.set(true, forKey: "premium")
                    completion(true)
                    print("purchased")
                }else {
                    UserDefaults.standard.set(false , forKey: "premium")
                    completion(false)
                    print("purchase falied")
                }
            case .failed:
                print("failed")
            case .restored:
                print("restore")
            case .deferred:
                print("defered")
            @unknown default:
                print("default case")
            }
        }
        
    }
    
    func restorePurchases(completion: @escaping (Bool)-> Void) {
        Purchases.shared.restoreTransactions { info, error in
            guard let entitlements = info?.entitlements,
                  error == nil else { return }
            if entitlements.all["Premium"]?.isActive == true {
                UserDefaults.standard.set(true, forKey: "premium")
                completion(true)
                print("purchased")
            }else {
                UserDefaults.standard.set(false , forKey: "premium")
                completion(false)
                print("purchase falied")
            }
        }
        
    }
}
