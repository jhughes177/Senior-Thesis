//
//  Ticket.swift
//  TEST
//
//  Created by Jared Hughes on 4/11/18.
//  Copyright © 2018 Jared Hughes. All rights reserved.
//

import Foundation

class Ticket: NSObject {
    var ticketNum: String?
    var ticketPrice: String?
    var cruiseName: String?
    var used: Bool?
    
    override init() {
        
    }
    
    init(ticketNum: String, ticketPrice: String, cruiseName: String, used: Bool) {
        
        self.ticketNum = ticketNum
        self.ticketPrice = ticketPrice
        self.cruiseName = cruiseName
        self.used = used
        
    }
    
    override var description: String {
        return "ticketnumber: \(String(describing: ticketNum)), ticket price: \(String(describing: ticketPrice)), Cruise Name: \(String(describing: cruiseName)), ticket used: \(String(describing: used))"
        
    }
    
}
