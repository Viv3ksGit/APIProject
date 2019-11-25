//
//  WeatherCell.swift
//  APIProject
//
//  Created by Jeffrey Neil Dsouza on 2019-11-24.
//  Copyright © 2019 com.vivekmohanan. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var condition: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell (weather: [String])/*(temp: String, city: String, Wcondition: String)*/ {
        self.lblCity.text = weather[0]
        self.lblTemperature.text = weather[1]
        if #available(iOS 13.0, *) {
            self.condition.image = UIImage(systemName: weather[2])
            
        } else {
            // Fallback on earlier versions
        }
        
    }
}
