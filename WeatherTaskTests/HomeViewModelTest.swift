//
//  HomeViewModelTest.swift
//  WeatherTaskTests
//
//  Created by Mohamed Elhamoly on 12/8/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//

import XCTest
@testable import WeatherTask

class HomeViewModelTest: XCTestCase, ResourcesViewModelDelegate {
    
    
    var sut: HomeViewModel!
    var apiServiceMock: APIServiceMock!
    
    override func setUp() {
        super.setUp()
        apiServiceMock = APIServiceMock()
        sut = HomeViewModel(delegate: self, apiService: apiServiceMock)
    }
    
    override func tearDown() {
        sut = nil
        apiServiceMock = nil
        super.tearDown()
    }
    
    func test_fetch_WeatherData() {
        // When
        sut.fetchApiData(city: "Cairo")
        
        // Then
        XCTAssert(apiServiceMock.fetchWeatherDataIsCalled)
    }
    
    func test_fetch_Online_WeatherData() {
        //Given a sut with fetched WetherData
        guard let WetherData = StubGenerator().stubWeather() else {
            XCTFail("Failed to generate photos")
            return
        }
        apiServiceMock.Weather = WetherData
        sut.fetchApiData(city: "Cairo")
        apiServiceMock.fetchSuccess()
        let testItem = apiServiceMock.Weather?.list?[0].dt_txt
        
        // When
        let vm = sut.resource(at: 0)
        
        //Assert
        XCTAssertEqual(vm.dt_txt, testItem)
    }
    func test_fetch_WeatherData_fail() {
        // Given
        let error = APIError.noDataFound
        
        // When
        sut.fetchApiData(city: "Cairo")
        apiServiceMock.fetchFail(error: error)
        
        let errorvm = sut.error
        
        
        // Then
        XCTAssertEqual(errorvm, error.localizedDescription)
    }
    func testWeatherDataisEmpty() {
        sut.clear()
        XCTAssertEqual(sut.totalCount, 0, "Weather Data must be 0")
    }
    func testWeatherDataisCount() {
        //Given a sut with fetched WetherData
        guard let WetherData = StubGenerator().stubWeather() else {
            XCTFail("Failed to generate photos")
            return
        }
        apiServiceMock.Weather = WetherData
        sut.fetchApiData(city: "Cairo")
        apiServiceMock.fetchSuccess()
        let testCount = apiServiceMock.Weather?.list?.count
        // When
        let vm = sut.totalCount
        
        //Assert
        XCTAssertEqual(vm, testCount, "Weather Data must be Equal")
    }
    func testGetItemWeather() {
        //Given a sut with fetched WetherData
        guard let WetherData = StubGenerator().stubWeather() else {
            XCTFail("Failed to generate photos")
            return
        }
        apiServiceMock.Weather = WetherData
        sut.fetchApiData(city: "Cairo")
        apiServiceMock.fetchSuccess()
        let testItem = apiServiceMock.Weather?.list?[0].dt_txt
        
        // When
        let vm = sut.resource(at: 0)
        
        //Assert
        XCTAssertEqual(vm.dt_txt, testItem)
    }
    
    func onFetchCompleted() {
        
    }
    
    func onFetchFailed(with reason: String) {
        
    }
}
