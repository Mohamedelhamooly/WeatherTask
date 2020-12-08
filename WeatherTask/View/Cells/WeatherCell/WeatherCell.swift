//
//  WeatherCell.swift
//  WeatherTask
//
//  Created by Mohamed Elhamoly on 12/7/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//
import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var imgWeatherIcon: UIImageView!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Configure Cell
    public func configureCell(with weather: List) {
    
        self.lbltime.text = weather.dt_txt
        self.lbldate.text = weather.dt_txt
        self.lblTemp.text =  String(describing: weather.main!.temp!)
        let iconUrl = ResourceType.weather.baseImage + weather.weather![0].icon! + ".png"
        self.imgWeatherIcon.loadImage(fromURL: iconUrl)
        
    }
}
