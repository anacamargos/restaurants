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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        service.request(.search(lat: 42.361145, long: -71.057083)) { (result ) in
            switch result {
                case .success(let response):
                    print(try? JSONSerialization.jsonObject(with: response.data, options: []) )
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
        
        switch locationService.status {
        case .notDetermined, .denied, .restricted:
            let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
            
            locationViewController?.locationService = locationService
            
            window.rootViewController = locationViewController
            
            
        default:
            assertionFailure()
            //voltar aqui
        }
        
        window.makeKeyAndVisible()
        
        return true
    }

    


}

