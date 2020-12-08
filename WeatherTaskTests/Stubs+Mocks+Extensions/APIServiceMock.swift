//
//  APIServiceMock.swift
//  WeatherTaskTests
//
//  Created by Mohamed Elhamoly on 12/8/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//

import Foundation
@testable import WeatherTask
// The mock APIService(APIServiceMock) object doesn’t connect to the real server,
// it’s an object designed only for the test.
// Both APIServiceand APIServiceMock conform to APIServiceProtocol,
// so that we are able to inject different dependency in different situation.
class APIServiceMock: APIServiceProtocol{
    
    
    var fetchWeatherDataIsCalled = false
    var fetchWeatherIsCalled = false
    
    var Weather:WeatherData?
    var completeClosure: ((WeatherData?, APIError?) -> ())!
    
    
    func fetchSuccess() {
        completeClosure(Weather, nil)
    }
    
    func fetchFail(error: APIError?) {
        completeClosure(nil, error)
    }
    
    func fetchWeatherData(parameters: [String : String]?, complete: @escaping (WeatherData?, APIError?) -> ()) {
        fetchWeatherDataIsCalled = true
        completeClosure = complete
    }
    
    func fetchWeather(from request: URLRequest, complete: @escaping (WeatherData?, APIError?) -> ()) {
        fetchWeatherIsCalled = true
        
    }
}
