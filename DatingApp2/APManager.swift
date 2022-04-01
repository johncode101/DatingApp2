//
//  APManager.swift
//  DatingApp2
//
//  Created by Jonathan Hernandez on 3/10/22.
//

import Foundation
import Glassfy

final class APManager {
    static let shared = APManager()
    
    private init() {}
    
    enum Product: String {
        case premium
        
        var sku: String {
            return rawValue
        }
    }
    
    func configure() {
        Glassfy.initialize(apiKey: "9a02475f9de74c64a026fc3eccb30d93")
        
    }
    
    func getProduct(completion: @escaping (Glassfy.Sku) -> Void) {
        Glassfy.sku(id: Product.premium.rawValue) { sku, error in
            guard let sku = sku,error == nil else {
                return
            }
            completion(sku)
        }
    }
    
    func purschase(sku: Glassfy.Sku) {
        Glassfy.purchase(sku: sku) { transaction, error in
            guard let t = transaction, error == nil else {
                return
            }
            if t.permissions[Product.premium.rawValue]?.isValid == true {
                
            }
        }
        
    }
    
    func getPermissions() {
        Glassfy.permissions { permissions, error in
            guard let permissions = permissions, error == nil else {
                return
            }
            if permissions[Product.premium.rawValue]?.isValid == true {
                
            }
        }
        
    }
    
    func restorePurchases() {
        Glassfy.restorePurchases { permissions, error in
            guard let permissions = permissions, error == nil else {
                return
            }
            if permissions[Product.premium.rawValue]?.isValid == true {
                
            }
        }
        
    }
    
}
