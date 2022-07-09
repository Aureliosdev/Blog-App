//
//  lAPManager.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 02.07.2022.
//

import Foundation
import Purchases
final class IAPManager {
    static let shared = IAPManager()
    
    //Revenue Cat Shared Secret
    //9eb0501030a848b2bcd519ef0c3941c0
    
    private init() {}
    
    func isPremium()-> Bool {
        return false
    }
    
    func subscribe() {
        
        
    }
    
    func restorePurchases() {
        
    }
}
