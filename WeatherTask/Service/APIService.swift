//
//  APIService.swift
//  WeatherTask
//
//  Created by Mohamed Elhamoly on 12/7/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//

import Foundation


class APIService: APIServiceProtocol {
    func fetchWeatherData(parameters: [String : String]?, complete: @escaping (WeatherData?, APIError?) -> ()) {
        
        var par = parameters
        par!["appid"] = ResourceType.weather.appid
        var urlComponents: URLComponents {
            var components = URLComponents(string: ResourceType.weather.base)!
            components.path = ResourceType.weather.path
            components.queryItems = par!.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            
            return components
        }
        var request: URLRequest {
            let url = urlComponents.url!
            return URLRequest(url: url)
            
        }
        fetchWeather(from: request, complete: complete)
        
    }
    func fetchWeather(from request: URLRequest, complete: @escaping (WeatherData?, APIError?) -> ()) {
        
        URLSession(configuration: .default).dataTask(with: request) { data, response, error in
            
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.hasSuccessStatusCode {
                    if let data = data {
                        do {
                            let genericModel = try JSONDecoder().decode(WeatherData.self, from: data)
                            complete(genericModel, nil)
                        } catch {
                            complete(nil, .jsonConversionFailure)
                        }
                    } else {
                        complete(nil, .invalidData)
                    }
                }
                else {
                    if let data = data {
                        do {
                            let error = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                            
                            if let message = error!["message"] as? String {
                                
                                complete(nil, .errorMessage(message))
                                
                            } else if let message = error!["message"] as? Int {
                                
                                complete(nil, .errorMessage(String(describing: "Bad Request = \(message)")))
                            }
                            
                        } catch {
                            complete(nil, .jsonConversionFailure)
                        }
                    } else {
                        complete(nil, .invalidData)
                    }
                }
            }
            else {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(WeatherData.self, from: data)
                        complete(genericModel, nil)
                    } catch {
                        complete(nil, .jsonConversionFailure)
                    }
                } else {
                    complete(nil, .invalidData)
                }
            }
            
            
        }.resume()
        
    }
    
}


