//
//  CruiseTableConnection.swift
//  TEST
//
//  Created by Jared Hughes on 2/6/18.
//  Copyright © 2018 Jared Hughes. All rights reserved.
//

import Foundation

protocol CruiseModelProtocol: class {
    func responseArray(items: NSArray)
}

class CruiseModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: CruiseModelProtocol!
    
    var data = Data()
    
    let serverPath: String = "http://digdug.cs.endicott.edu/~jhughes/Thesis/connect.php"
    
    func responseArray() {
        
        let url: URL = URL(string: serverPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download database response")
            }else {
                print("Database response download successful")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResponse = NSArray()
        
        do{
            jsonResponse = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let products = NSMutableArray()
        
        for i in 0 ..< jsonResponse.count
        {
            
            jsonElement = jsonResponse[i] as! NSDictionary
            
            let product = Product()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let SKU = jsonElement["SKU"] as? String,
                let cruiseName = jsonElement["Name"] as? String,
                let cruisePrice = jsonElement["Price"] as? String,
                let cruiseDescription = jsonElement["Description"] as? String

            {
                
                product.SKU = SKU
                product.cruiseName = cruiseName
                product.cruisePrice = cruisePrice
                product.cruiseDescription = cruiseDescription
              
                
            }
            
            products.add(product)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.responseArray(items: products)
            
        })
    }
    
}
