//
//  HomeVc.swift
//  WeatherTask
//
//  Created by Mohamed Elhamoly on 12/7/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//

import UIKit

class HomeVc: BaseViewController,UISearchBarDelegate {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Private Variables
    private var viewModel: HomeViewModel!
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init viewModel
        viewModel = HomeViewModel(delegate: self)
        
        // Setup tableview
        setupTableView()
        
        searchBar.delegate = self
        
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Remove navigation bar border and background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    @IBAction func didTabSegment (segment :UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            self.viewModel.clear()
            if searchBar.text != "" {
                
                self.viewModel.fetchApiData(city: searchBar.text!)
                
            }
            self.searchBar.isHidden = false
        }
        else if segment.selectedSegmentIndex == 1 {
            self.viewModel.fetchOfflineData()
            self.searchBar.isHidden = true
            
        }
    }
    
    // MARKK: - Helpers
    private func setupTableView() {
        tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        // Remove the last cell separator inset
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.showLoading()
    if searchBar.text != nil {
        self.viewModel.fetchApiData(city: searchBar.text!)
        
    }
}
    
}

// MARK: - UITableView DataSource
extension HomeVc: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
            return WeatherCell()
        }
        
        // Configure tableView cell
        cell.configureCell(with: viewModel.resource(at: indexPath.row))
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension HomeVc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - HomeViewModel Delegate
extension HomeVc: ResourcesViewModelDelegate {
    func onFetchCompleted() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.hideLoading()
        }
    }
    
    func onFetchFailed(with reason: String) {
        // Show alert to user
        DispatchQueue.main.async {
            self.hideLoading()
            self.view.makeToast(reason)
            print(reason)
        }
        
    }
}

