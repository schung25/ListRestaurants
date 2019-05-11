//
//  DetailViewController.swift
//  ListRestaurants
//
//  Created by Sang Chung on 5/9/19.
//  Copyright © 2019 SangChung. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblImage: UIImageView!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.RestaurantName
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        lblImage.image = detailItem?.RestaurantImage
        
        lblRating.text = detailItem?.RestaurantRating
        lblReview.text = detailItem?.RestaurantReview
        lblPrice.text = detailItem?.RestaurantPriceRange
        lblHours.text = detailItem?.RestaurantHours
    }

    var detailItem: Restaurant? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Find the right Segue
        if segue.identifier == "showSubDetail" {
            let controller = segue.destination as! SubDetailViewController
            // pass on the selected object from the Array to the detail controller's object.
            controller.selectedRestaurant = detailItem!
        }
    }

}

