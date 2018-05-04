//
//  ProductModel.swift
//  TEST
//
//  Created by Jared Hughes on 2/6/18.
//  Copyright © 2018 Jared Hughes. All rights reserved.
//

import Foundation

class Product: NSObject {
    var SKU: String?
    var cruiseName: String?
    var cruisePrice: String?
    var cruiseDescription: String?
    
    override init() {
        
    }
    
    init(SKU: String, cruiseName: String, cruisePrice: String, cruiseDescription: String) {
        
        self.SKU = SKU
        self.cruiseName = cruiseName
        self.cruisePrice = cruisePrice
        self.cruiseDescription = cruiseDescription
    
    }
    
    override var description: String {
        return "SKU: \(String(describing: SKU)), Cruise Name: \(String(describing: cruiseName)), Cruise Price: \(String(describing: cruisePrice)),Cruise Description: \(String(describing: cruiseDescription)) "
        
    }
    
}
