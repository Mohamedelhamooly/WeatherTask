//
//  APIServiceProtocol.swift
//  WeatherTask
//
//  Created by Mohamed Elhamoly on 12/7/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func fetchWeatherData(parameters: [String : String]?,complete: @escaping (_ Weather: WeatherData?, _ error: APIError?)->())
    func fetchWeather(from request: URLRequest, complete: @escaping (_ Weather: WeatherData?, _ error: APIError?)->())
}
