//
//  ViewModelProtocols.swift
//  WeatherTask
//
//  Created by Mohamed Elhamoly on 12/7/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//


import Foundation

// MARK: - Resource View Model Delegate
protocol ResourcesViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}
