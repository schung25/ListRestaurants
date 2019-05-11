//
//  SubDetailViewController.swift
//  ListRestaurants
//
//  Created by Sang Chung on 5/10/19.
//  Copyright © 2019 SangChung. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import AVKit

class SubDetailViewController : UIViewController{

    @IBOutlet weak var wbBrowser: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: ("http://" + (selectedRestaurant.RestaurantWebsite)))
        
        let myRequest = URLRequest(url: myURL!)
        
        wbBrowser.load(myRequest)
    }
    
     var selectedRestaurant:Restaurant = Restaurant()
}

