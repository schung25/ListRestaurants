//
//  MasterViewController.swift
//  ListRestaurants
//
//  Created by Sang Chung on 5/9/19.
//  Copyright © 2019 SangChung. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var RestaurantArray = [Restaurant]()
    
    func initilizeRestData() {
        // 1) Build the URL for the End Point
        let endPoint =  "https://api.myjson.com/bins/19lwxq"
        let jsURL:URL = URL(string: endPoint)!
        // 2) execute the End Point Resulting in bringing down the JSON
        let jsonUrlData = try? Data (contentsOf: jsURL)
        print(jsonUrlData ?? "ERROR: No Data To Print. JSONURLData is Nil")
        
        if(jsonUrlData != nil){
            //3) Consume the JSON
            // 4) take the JSON data and serialize it into a Dictionary
            let dictionary:NSDictionary =
                (try! JSONSerialization.jsonObject(with: jsonUrlData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            print(dictionary)
            
            let RestaurantDictionary = dictionary["Restaurants"]! as! [[String:AnyObject]]
            
            for index in 0...RestaurantDictionary.count - 1 {
                let singleRestaurant = RestaurantDictionary[index]
                let tr  = Restaurant()
                tr.RestaurantPopularity = singleRestaurant["RestaurantPopularity"] as! String
                tr.RestaurantName = singleRestaurant["RestaurantName"] as! String
                tr.RestaurantRating = singleRestaurant["RestaurantRating"] as! String
                tr.RestaurantReview = singleRestaurant["RestaurantReview"] as! String
                tr.RestaurantID = singleRestaurant["RestaurantID"] as! Int
                let imgName2 = singleRestaurant["RestaurantImage"] as! String
                tr.RestaurantImage = extractImage(named: imgName2)
                tr.RestaurantPriceRange = singleRestaurant["RestaurantPriceRange"] as! String
                tr.RestaurantHours = singleRestaurant["RestaurantHours"] as! String
                tr.RestaurantWebsite = singleRestaurant["RestaurantWebsite"] as! String
                RestaurantArray.append(tr)
                
            } //for loop close
        } // if condition close
    } // function close
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilizeRestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Find the right Segue
        if segue.identifier == "showDetail" {
           
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let selectedRT = RestaurantArray[indexPath.row]
             
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                // pass on the selected object from the Array to the detal controller's object.
                controller.detailItem = selectedRT
                
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantArray.count
    }
    
    func extractImage(named:String) -> UIImage {
        // get the image form the URL
        let urlString = "https://api.myjson.com/bins/19lwxq" + named
        let uri = URL(string: urlString)
        let dataBytes = try? Data(contentsOf: uri!)
        let img = UIImage(data: dataBytes!)
        
        return img!
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let selectedRT = RestaurantArray[indexPath.row]
        
        
        // style the table view
        tableView.separatorColor = UIColor.blue
        tableView.tableFooterView =
            UIView(frame: CGRect(x:0.0, y:0.0, width:0.0, height:0.0))
        // set style on the image view
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView!.layer.cornerRadius = 8
        cell.imageView!.clipsToBounds = true
        
        cell.textLabel!.text = selectedRT.RestaurantName
        cell.detailTextLabel!.text = selectedRT.RestaurantPopularity
        cell.imageView?.image = selectedRT.RestaurantImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
}

