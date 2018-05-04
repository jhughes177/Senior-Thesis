//
//  FirstViewController.swift
//  TEST
//
//  Created by Jared Hughes on 11/29/17.
//  Copyright © 2017 Jared Hughes. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CruiseModelProtocol {
    
    var feedProducts: NSArray = NSArray()
    var selectedProduct : Product = Product()
    @IBOutlet weak var listTableView: UITableView!
    var nameOfCruise: String!
   
    
    func responseArray(items: NSArray) {
        feedProducts = items
        self.listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedProducts.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Segue to the third view controller
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get a reference to the third view controller
     let thirdViewController = segue.destination as! ThirdViewController
        
        // set a variable in the third view controller with the data to pass
        thirdViewController.recievedData = "hello"
        let indexPath = listTableView.indexPathForSelectedRow
        // Get the Row of the Index Path and set as index
        let index = indexPath?.row
        let item: Product = feedProducts[indexPath!.row] as! Product
        // Pass on the data to the Third ViewController
        thirdViewController.index = index
        thirdViewController.name = item.cruiseName
        thirdViewController.price = item.cruisePrice
        thirdViewController.cruiseDescription = item.cruiseDescription


    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve cell
        
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        let item: Product = feedProducts[indexPath.row] as! Product
        myCell.textLabel!.text = item.cruiseName
        nameOfCruise = item.cruiseName

        return myCell
    }
  
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.title = "Boston Harbor Cruises"
        let cruiseModel = CruiseModel()
        cruiseModel.delegate = self
        cruiseModel.responseArray()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

