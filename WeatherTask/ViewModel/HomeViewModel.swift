//
//  HomeViewModel.swift
//  WeatherTask
//
//  Created by Mohamed Elhamoly on 12/7/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//

import Foundation
class HomeViewModel {
    // MARK: - Private Variables
    private weak var delegate: ResourcesViewModelDelegate?
    private var isFetchInProgress = false
    private var resources: [List] = []
    
    let apiService: APIServiceProtocol
    var error: String?
    
    // MARK: - Public Varibles
    public var totalCount: Int {
        return resources.count
    }
    
    // MARK: - Initializer
    init(delegate: ResourcesViewModelDelegate,apiService: APIServiceProtocol = APIService()) {
        self.delegate = delegate
        self.apiService = apiService
    }
    
    // MARK: - Helprs
    func resource(at index: Int) -> List {
        return resources[index]
        
    }
    
    func clear()  {
        resources = []
        self.delegate?.onFetchCompleted()
        
    }
    // MARK: - Network Call
    func fetchApiData(city:String) {
        
        // Check for avoiding multiple network calls
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        var par: [String : String] = [:]
        par["q"] = city
        apiService.fetchWeatherData(parameters: par) { [weak self] (resource, error) in
            if error != nil {
                self?.isFetchInProgress = false
                self?.error =  error!.localizedDescription
                self?.delegate?.onFetchFailed(with: error!.localizedDescription)
            }
            else if resource != nil {
                self?.isFetchInProgress = false
                if resource!.list != nil {
                    self?.resources = resource!.list!
                    self?.delegate?.onFetchCompleted()
                    
                }
            }
        }
    }
    
    //  MARK: - Offline Call
    
    func fetchOfflineData() {
        
        guard let dataFromOffline  = JsonHelper.shared.readLocalFile(forName: "offlineData") else {
            self.delegate?.onFetchFailed(with: "No File Found")
            return
        }
        JsonHelper.shared.parse(jsonData: dataFromOffline, decodeType: WeatherData.self) { [weak self](result,error ) in
            if error != nil {
                self?.error =  error
                self?.delegate?.onFetchFailed(with: error!)
            } else
                if result != nil {
                    if result?.list != nil {
                        self?.resources = result!.list!
                        self?.isFetchInProgress = false
                        // Notify the delegate
                        self?.delegate?.onFetchCompleted()
                    }
                }else {
                    self?.delegate?.onFetchFailed(with: "No Data Found")
                    
            }
            
        }
        
    }
    
}
