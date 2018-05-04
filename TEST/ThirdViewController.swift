//
//  ThirdViewController.swift
//  TEST
//
//  Created by Jared Hughes on 2/14/18.
//  Copyright © 2018 Jared Hughes. All rights reserved.
//

import UIKit
import Stripe
import AFNetworking

class ThirdViewController: UIViewController {

    var recievedData = ""
    var index: Int!
    var name: String!
    var price: String!
    var cruiseDescription: String!
    var clientEmailText: String!
    var ticketsForBosToCh: [String] = ["5ftm0k", "t0m4j2","mxm6d6","ymd4tt","324kxd","dhxhtx","bpxsur","bfbjbf"]
    var ticketsForChToBos: [String] = ["5ix0ai", "ct2fqb","w7pwe1","pw7idj","n5f0wf","re7qsv","psscoq","75znph"]
    var ticketsForProvToBos: [String] = ["qa7wno", "witvhk","f5pm33","ixcb37","dmjxjf","zerugk","eg5rjo","63na4n"]
    var ticketsForBosToProv: [String] = ["p5eau6", "imqy0s","r5ra45","oaitio","r6s4vt","pyxuzj","c3ak2g","ng76si"]



    

//    init(configuration: STPPaymentConfiguration){}
  //  convenience init(publishableKey: String){}
    var stripCard = STPCardParams()
    let firstViewController = FirstViewController()
    let ticketViewController = TicketViewController()
    //Create an array of tickets
//    var feedTickets: NSArray = NSArray()
//    var selectedTicket : Ticket = Ticket()


    @IBOutlet weak var cruisePriceLabel: UILabel!
    @IBOutlet weak var cruiseNameLabel: UILabel!    
    
    @IBOutlet weak var cruiseDescriptionLabel: UITextView!
    @IBOutlet weak var purchaseButton: UIButton!
    
    @IBAction func purchaseButtonPressed(_ sender: Any) {
        //ticketViewController.ticketLabel.text = cruiseNameLabel.text
        showInputDialog()
        
    }
    
//    func responseArray(items: NSArray) {
//        feedTickets = items
//    }
//
//
    override func viewDidLoad() {
        super.viewDidLoad()
        print(recievedData)
        cruiseNameLabel.text = (name)
        cruisePriceLabel.text = ("Price: $" + price)
        cruiseDescriptionLabel.text = (cruiseDescription)
        purchaseButton.layer.cornerRadius = 6;
    
        
        
        //cruiseNameLabel.text = ProductModel.cruise
        // Do any additional setup after loading the view.
        
        
    }
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        self.tabBarController!.selectedIndex = 1
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let ticketViewController = segue.destination as! TicketViewController


        if(name == "Boston Ferry to Charlestown"){
            ticketViewController.scan = ticketsForBosToCh[0]
            ticketViewController.cruiseName = name
        }
        if(name == "Charlestown Ferry to Boston"){
            ticketViewController.scan = ticketsForChToBos[0]
            ticketViewController.cruiseName = name
        }
        if(name == "Provincetown Ferry to Boston"){
            ticketViewController.scan = ticketsForProvToBos[0]
            ticketViewController.cruiseName = name
        }
        if(name == "Boston Ferry to Provincetown"){
            ticketViewController.scan = ticketsForBosToProv[0]
            ticketViewController.cruiseName = name
        }

        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleError(error: NSError) {
        UIAlertView(title: "Please Try Again",
                    message: error.localizedDescription,
                    delegate: nil,
                    cancelButtonTitle: "OK").show()
        
    }
    func postStripeToken(token: STPToken) {
        
        let URL = "http://digdug.cs.endicott.edu/~jhughes/Thesis/web.php"
        let params = ["stripeToken": token.tokenId,
                      "amount": self.price,
                      "currency": "usd",
                      "livemode": "true",
                      "receipt_email": self.clientEmailText,
                      "description": self.clientEmailText]
        
        let manager = AFHTTPSessionManager()
        manager.post(URL, parameters: params, success: { (operation, responseObject) -> Void in
            if let response = responseObject as? [String: String] {
                UIAlertView(title: response["status"],
                            message: response["message"],
                            delegate: nil,
                            cancelButtonTitle: "OK").show()
            }
            
        }) { (operation, error) -> Void in
        }
    }
    //This functions prompts the user for credit card info
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Credit Card Information", message: "Please enter your credit card information below", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let userEmail = alertController.textFields?[0].text
            let userCreditCardNum = alertController.textFields?[1].text
            let userMonth = alertController.textFields?[2].text
            let userYear = alertController.textFields?[3].text
            let userCvc = alertController.textFields?[4].text
            
            //Assigns variables to appropriate places
            self.clientEmailText = userEmail
            self.stripCard.number = userCreditCardNum
            self.stripCard.expMonth = UInt(userMonth!)!
            self.stripCard.expYear = UInt(userYear!)!
            self.stripCard.cvc = userCvc
            
            //SUCCESS LINE
            STPAPIClient.shared().createToken(withCard: self.stripCard, completion: { (token, error) -> Void in
                
                if error != nil {
                    self.handleError(error: error! as NSError)
                    return
                }
                if error == nil {
                    UIAlertView(title: "Payment Successful!",
                                message: "Thanks for the money",
                                delegate: nil,
                                cancelButtonTitle: "Dismiss").show()
                    print("itworked!!asjd;lasjd;!")
                    self.performSegue(withIdentifier: "ticketSegue", sender: self)
//                    self.tabBarController!.selectedIndex = 1
                    return

                }
                self.postStripeToken(token: token!)
                
            })
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Email"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Credit Card Number"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Month"
        }
        alertController.addTextField { (textField) in
                textField.placeholder = "Enter Year"
            }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter CVC"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    }

  



