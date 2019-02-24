//
//  AppDelegate.swift
//  Restaurants
//
//  Created by Ana Leticia Camargos on 23/02/19.
//  Copyright © 2019 Ana Leticia Camargos. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()

    let locationService = LocationService()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let service = MoyaProvider<YelpService.BusinessProvider>()
    let jsonDecoder = JSONDecoder()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        
        locationService.didChangeStatus = { [weak self] success in
            if success {
                self?.locationService.getLocation()
            }
        }

        locationService.newLocation = { [weak self] result in
            switch result {
            case .success(let location):
                self?.loadBusinesses(with: location.coordinate)
            case .failure(let error):
                assertionFailure("Error getting the users location \(error)")
            }
        }
        
        
        
        // decide tela inicial
        switch locationService.status {
            
            case .notDetermined, .denied, .restricted:
                let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
                //locationViewController?.locationService = locationService
                locationViewController?.delegate = self
                window.rootViewController = locationViewController
            
            
            default:
                let nav = storyboard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
            
                window.rootViewController = nav
                locationService.getLocation()
                (nav?.topViewController as? RestaurantTableViewController)?.delegate = self
                //loadBusinesses()
        }
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    private func loadDetails(withId id: String) {
        service.request(.details(id:id)) { [weak self] (result) in
            switch result {
                
            case .success(let response):
                guard let strongSelf = self else { return }
                let details = try? strongSelf.jsonDecoder.decode(Details.self, from: response.data)
                print("Details \n\n \(details)")
            case .failure(let error):
                print("Failed to get details \(error)")
            }
        }
    }
    
    private func loadBusinesses(with coordinate: CLLocationCoordinate2D ) {
        
        // pega request da api
        //service.request(.search(lat: 42.361145, long: -71.057083)) { (result ) in
        //service.request(.search(lat: -19.857119, long: -43.986524)) { (result ) in
        service.request(.search(lat: coordinate.latitude, long: coordinate.longitude)) { [ weak self ] (result ) in
            switch result {
                
            case .success(let response):
                guard let strongSelf = self else { return }
                
                //print(try? JSONSerialization.jsonObject(with: response.data, options: []) )
                
                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
                
                let viewModels = root?.businesses
                    .compactMap(RestaurantListViewModel.init)
                    .sorted(by: { $0.distance < $1.distance })
                
                if let nav = strongSelf.window.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? RestaurantTableViewController {
                    restaurantListViewController.viewModels = viewModels ?? []
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }

}

extension AppDelegate: LocationActions, ListActions {
    func didTapALlow() {
        locationService.requestLocationAuthorization()
    }
    
    func didTapCell(_ viewModel: RestaurantListViewModel) {
        loadDetails(withId: viewModel.id)
    }
}


