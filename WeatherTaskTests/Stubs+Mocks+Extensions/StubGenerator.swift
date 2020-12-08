//
//  StubGenerator.swift
//  WeatherTaskTests
//
//  Created by Mohamed Elhamoly on 12/8/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//

import Foundation
@testable import WeatherTask

class StubGenerator {
    func stubWeather() -> WeatherData? {
        guard let path = Bundle.unitTest.path(forResource: "stub", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let Weather = try? decoder.decode(WeatherData.self, from: data)
        return Weather
    }
}
