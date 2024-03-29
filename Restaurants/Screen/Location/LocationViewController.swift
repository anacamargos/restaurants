//
//  LocationViewController.swift
//  Restaurants
//
//  Created by Ana Leticia Camargos on 23/02/19.
//  Copyright © 2019 Ana Leticia Camargos. All rights reserved.
//

import UIKit

protocol LocationActions: class {
    func didTapALlow()
}


class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationView: LocationView!
    //var locationService: LocationService?
    weak var delegate: LocationActions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationView.didTapAllow = {
            //self?.locationService?.requestLocationAuthorization()
            self.delegate?.didTapALlow()
        }
        
//        locationService?.didChangeStatus = { [weak self] success in
//            if success {
//                self?.locationService?.getLocation()
//            }
//        }
//
//        locationService?.newLocation = { [weak self] result in
//            switch result {
//            case .success(let location):
//                print(location)
//            case .failure(let error):
//                assertionFailure("Error getting the users location \(error)")
//            }
//        }
    }
    
    
}


//class LocationViewController: UIViewController {
//
//    @IBOutlet weak var locationView: LocationView!
//    var locationService: LocationService?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        locationView.didTapAllow = { [weak self] in
//            print("Tapped allow")
//            self?.locationService?.requestLocationAuthorization()
//        }
//
//        locationService?.didChangeStatus = { [ weak self ] success in
//            if success {
//                self?.locationService?.getLocation()
//            }
//        }
//
//        locationService?.newLocation = { [weak self ] result in
//            switch result {
//            case .success(let location):
//                print(location)
//            case .failure(let error):
//                assertionFailure("Error getting the users location \(error)")
//            }
//        }
//
//        // Do any additional setup after loading the view.
//    }
//
//
//}
