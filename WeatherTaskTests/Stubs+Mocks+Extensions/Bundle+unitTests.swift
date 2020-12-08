//
//  Bundle+unitTests.swift
//  WeatherTaskTests
//
//  Created by Mohamed Elhamoly on 12/8/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//
import Foundation

extension Bundle {
    public class var unitTest: Bundle {
        return Bundle(for: HomeViewModelTest.self)
    }
}
