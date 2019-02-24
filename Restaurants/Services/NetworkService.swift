//
//  NetworkService.swift
//  Restaurants
//
//  Created by Ana Leticia Camargos on 23/02/19.
//  Copyright © 2019 Ana Leticia Camargos. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "QzpxCxA2ZlEihMZNho_QCdpeNHClNabOMuync3oP7SoMf9XfATQ1G2e2BwN3k9PXpFrQhO5F2MAz8JS-fXs0fw7LZTfeBeOX4S0bj7Hu18WBqrky_fuJABtr1M9xXHYx"

enum YelpService {
    enum BusinessProvider: TargetType {
        
        case search(lat: Double, long: Double)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses" )!
        }
        
        var path: String {
            switch self {
            case .search:
                return "/search"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case let .search(lat,long):
                return .requestParameters(parameters: ["latitude": lat, "longitude": long, "limit": 10], encoding: URLEncoding.queryString)
            }
        }
        
        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)" ]
        }
        
        
    }
}
