//
//  HTTPURLResponseExt.swift
//  WeatherTask
//
//  Created by Mohamed Elhamoly on 12/7/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//

import Foundation

// MARK: - HTTPURLResponse Extension to check the success response code
extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
