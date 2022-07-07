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
    
    private init() {}
    
    func isPremium()-> Bool {
        return false
    }
    
    func subscribe() {
        
        
    }
    
    func restorePurchases() {
        
    }
}
