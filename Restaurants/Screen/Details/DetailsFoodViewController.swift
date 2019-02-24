//
//  DetailsFoodViewController.swift
//  Restaurants
//
//  Created by Ana Leticia Camargos on 23/02/19.
//  Copyright © 2019 Ana Leticia Camargos. All rights reserved.
//

import UIKit

class DetailsFoodViewController: UIViewController {
    
    @IBOutlet weak var detailsFoodView: DetailsFoodView?
    var viewModel: DetailsViewModel? {
        didSet{
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func updateView( ) {
        if let viewModel = viewModel {
            detailsFoodView?.priceLabel?.text = viewModel.price
            detailsFoodView?.hoursLabel?.text = viewModel.isOpen
            detailsFoodView?.locationLabel?.text = viewModel.phoneNumber
            detailsFoodView?.ratingsLabel?.text = viewModel.rating
        }
    }
    

}
