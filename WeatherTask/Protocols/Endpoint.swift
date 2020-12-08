//
//  Endpoint.swift
//  WeatherTask
//
//  Created by Mohamed Elhamoly on 12/7/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//


import Foundation

protocol Endpoint {
    var base: String { get }
    var baseImage: String { get }
    var path: String { get }
    var appid: String { get }
    
}
enum ResourceType {
    case weather
}

extension ResourceType: Endpoint {
    var baseImage: String {
        return "http://openweathermap.org/img/w/"
    }
    
    var appid: String {
        return "0116a89d22cab74335cff102d13d9d82"
    }
    var base: String {
        return "https://api.openweathermap.org"
    }
    
    var path: String {
        switch self {
        case .weather: return "/data/2.5/forecast"
        }
    }
}

