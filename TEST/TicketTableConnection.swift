//
//  TicketModel.swift
//  TEST
//
//  Created by Jared Hughes on 4/11/18.
//  Copyright © 2018 Jared Hughes. All rights reserved.
//

import Foundation

protocol TicketModelProtocol: class {
    func responseArray(items: NSArray)
}
var instanceTicket = TicketModel()
class TicketModel: NSObject, URLSessionDataDelegate {
    
    //properties
    //let usableTicket = Ticket()
    //var usableTickets = NSMutableArray()
    
    weak var delegate: TicketModelProtocol!
    
    var data = Data()
    
    let serverPath: String = "http://digdug.cs.endicott.edu/~jhughes/Thesis/connect2.php"
    
    func responseArray() {
        
        let url: URL = URL(string: serverPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download database response")
            }else {
                self.parseJSON(data!)
                print("Database response download successful")

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
        let tickets = NSMutableArray()
        
        for i in 0 ..< jsonResponse.count
        {
            //print(jsonResponse[i])

            jsonElement = jsonResponse[i] as! NSDictionary
            
            let ticket = Ticket()
            
            
                 ticket.ticketNum = jsonElement["ticketnumber"] as? String
                 ticket.ticketPrice = jsonElement["price"] as? String
                 ticket.cruiseName = jsonElement["cruisename"] as? String
                 ticket.used = jsonElement["Used"] as? Bool
            
//                ticket.ticketNum = ticketNum
//                ticket.ticketPrice = ticketPrice
//                ticket.cruiseName = cruiseName
//                ticket.used = used
            
            
            tickets.add(ticket)
            print(tickets)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.responseArray(items: tickets)
            
        })
    }
    
}
