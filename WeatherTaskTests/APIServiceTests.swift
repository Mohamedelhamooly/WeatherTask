//
//  APIServiceTests.swift
//  WeatherTaskTests
//
//  Created by Mohamed Elhamoly on 12/8/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//

import XCTest
@testable import WeatherTask

class APIServiceTests: XCTestCase {
    var sut: APIService!
    
    override func setUp() {
        super.setUp()
        sut = APIService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetch_Weather_Data() {
        // Given
        let promise = XCTestExpectation(description: "Fetch photos completed")
        var responseError: Error?
        var responseWeather: WeatherData?
        
        // When
        guard let bundle = Bundle.unitTest.path(forResource: "stub", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        sut.fetchWeather(from: URLRequest(url: URL(fileURLWithPath: bundle))) { (respons, error) in
            responseError = error
            responseWeather = respons
            promise.fulfill()
        }
        
        
        wait(for: [promise], timeout: 1)
        
        // Then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseWeather)
        
        
    }
}
