//
//  AppDelegate.swift
//  Restaurants
//
//  Created by Ana Leticia Camargos on 23/02/19.
//  Copyright © 2019 Ana Leticia Camargos. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()

    let locationService = LocationService()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let service = MoyaProvider<YelpService.BusinessProvider>()
    let jsonDecoder = JSONDecoder()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        
        
        // decide tela inicial
        switch locationService.status {
            
            case .notDetermined, .denied, .restricted:
                let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
                locationViewController?.locationService = locationService
                window.rootViewController = locationViewController
            
            
            default:
                let nav = storyboard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
            
                window.rootViewController = nav
                loadBusinesses()
        }
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    private func loadBusinesses( ) {
        
        // pega request da api
        service.request(.search(lat: 42.361145, long: -71.057083)) { (result ) in
            switch result {
                
            case .success(let response):
                //print(try? JSONSerialization.jsonObject(with: response.data, options: []) )
                let root = try? self.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(RestaurantListViewModel.init)
                if let nav = self.window.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? RestaurantTableViewController {
                    restaurantListViewController.viewModels = viewModels ?? []
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }

}

