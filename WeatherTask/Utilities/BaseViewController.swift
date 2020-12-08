//
//  BaseViewController.swift
//
//  Created by Mohamed Elhamoly on 10/8/19.
//  Copyright © 2019 team. All rights reserved.
//

import Foundation
import UIKit


class BaseViewController:UIViewController {
    
    
    //MARK: Loading View
    var containerView = UIView()
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    func showLoading() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = UIColor(hex: 0xffffff, alpha: 0.3)
        
        overlayView.frame = CGRect(x:0, y:0, width:80, height:80)
        overlayView.center = CGPoint(x: window.frame.width / 2.0, y: window.frame.height / 2.0)
        overlayView.backgroundColor = UIColor.init(hex: 0xB0AB8E, alpha: 0.3 )
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        
        activityIndicator.frame = CGRect(x:0, y:0, width:40, height:40)
        activityIndicator.style = .large
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        
        overlayView.addSubview(activityIndicator)
        containerView.addSubview(overlayView)
        
        window.addSubview(containerView)
        activityIndicator.startAnimating()
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(containerView)
        
        
    }
    func hideLoading() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideLoading()
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
extension Date {
    
    init(millis: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(millis / 1000))
        self.addTimeInterval(TimeInterval(Double(millis % 1000) / 1000 ))
    }
}
