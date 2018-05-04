//
//  TicketViewController.swift
//  TEST
//
//  Created by Jared Hughes on 4/11/18.
//  Copyright © 2018 Jared Hughes. All rights reserved.
//

import UIKit

class TicketViewController: UIViewController, TicketModelProtocol {

    var feedTickets: NSArray = NSArray()
    var selectedTicket : Ticket = Ticket()
    @IBOutlet weak var scanCodeLabel: UILabel!
    @IBOutlet weak var cruiseNameLabel: UILabel!
    var scan: String!
    var cruiseName: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let ticketModel = TicketModel()
//        ticketModel.delegate = self7
//        ticketModel.responseArray()
        scanCodeLabel.text = scan
        cruiseNameLabel.text = cruiseName
        print("view loaded")
        print(cruiseName)
        print(scan)
        //let item: Ticket = feedTickets[0] as! Ticket
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func responseArray(items: NSArray) {
        feedTickets = items
    }
   

}
