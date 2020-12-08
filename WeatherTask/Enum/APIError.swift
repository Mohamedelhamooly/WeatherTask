//
//  APIError.swift
//  WeatherTask
//
//  Created by Mohamed Elhamoly on 12/7/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//
import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case noDataFound
    case errorMessage(String)
    case jsonParsingFailure
    case decoding
    
    var localizedDescription: String {
        switch self {
        case.errorMessage(let msg):
            return msg
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .decoding: return "An error occurred while decoding data"
        case .noDataFound:
             return "No data Found For This "
        }
    }
}
