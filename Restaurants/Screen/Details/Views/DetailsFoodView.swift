//
//  DetailsFoodView.swift
//  Restaurants
//
//  Created by Ana Leticia Camargos on 23/02/19.
//  Copyright © 2019 Ana Leticia Camargos. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable class DetailsFoodView: BaseView {
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageControl: UIPageControl?
    
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var hoursLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var ratingsLabel: UILabel?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func handleControl ( _ sender: UIPageControl) {
        
    }
    
    
    
    
    
    
    
}
