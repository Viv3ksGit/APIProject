//
//  WeatherViewController.swift
//  APIProject
//
//  Created by Jeffrey Neil Dsouza on 2019-11-23.
//  Copyright © 2019 com.vivekmohanan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    var temperature = ""
    var city = ""
    var condition = ""
    var weatherArray = [String]()
    var cityArray = [String]()
    var temperatureArray = [String]()
    var conditionArray = [String]()
    
   /* @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
 */
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var weatherManager = WeatherManager()
        let locationManager = CLLocationManager()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
            
            weatherManager.delegate = self
            searchTextField.delegate = self
            
            //table view
            tableView.delegate = self
            tableView.dataSource = self
        }

    }

func weatherAdd(){
    
}

    //MARK: - UITextFieldDelegate
// passes the text from the text search field to weather manager
    extension WeatherViewController: UITextFieldDelegate {
        
        @IBAction func searchPressed(_ sender: UIButton) {
            searchTextField.endEditing(true)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchTextField.endEditing(true)
            return true
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != "" {
                return true
            } else {
                textField.placeholder = "Type something"
                return false
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            if let city = searchTextField.text {
                weatherManager.fetchWeather(cityName: city)
            }
            
            searchTextField.text = ""
            
        }
    }

    //MARK: - WeatherManagerDelegate

    //recieves weather conditions from weather model
    extension WeatherViewController: WeatherManagerDelegate {
        
        func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
            DispatchQueue.main.async {
                self.temperature = weather.temperatureString
                /*
                if #available(iOS 13.0, *) {
                    self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                    
                } else {
                    // Fallback on earlier versions
                }*/
                self.condition = weather.conditionName
                self.city = weather.cityName
                self.weatherArray = [self.city, self.temperature, self.condition]
                self.cityArray.insert(self.city, at: 0)
                self.temperatureArray.insert(self.temperature, at: 0)
                self.conditionArray.insert(self.condition, at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
                self.tableView.reloadData()
            }
            
        }
        
        func didFailWithError(error: Error) {
            print(error)
        }
    }

    //MARK: - CLLocationManagerDelegate


    extension WeatherViewController: CLLocationManagerDelegate {
        
        @IBAction func locationPressed(_ sender: UIButton) {
            locationManager.requestLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                locationManager.stopUpdatingLocation()
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                weatherManager.fetchWeather(latitude: lat, longitude: lon)
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
    }

// MARK: - UITableViewDelegate and UITableViewDataSource

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let WeatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell")
        
        if let lblCity = WeatherCell?.contentView.viewWithTag(101) as? UILabel {
            lblCity.text = cityArray[indexPath.row]
        }
        
        if let lbltemperature = WeatherCell?.contentView.viewWithTag(102) as? UILabel {
            lbltemperature.text = temperatureArray[indexPath.row]
        }
        
        if let imageCondition = WeatherCell?.contentView.viewWithTag(103) as? UIImageView {
          
            if #available(iOS 13.0, *) {
                imageCondition.image = UIImage(systemName: conditionArray[indexPath.row])
                
            } else {
                // Fallback on earlier versions
            }
        }
        if let btnDelete = WeatherCell?.contentView.viewWithTag(104) as? UIButton {
            btnDelete.addTarget(self, action: #selector(deleteRow(_ :)), for: .touchUpInside)
        }
        
        return WeatherCell!
    }
    
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    @objc func deleteRow(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else {
            return
        }
        cityArray.remove(at: indexPath.row)
        temperatureArray.remove(at: indexPath.row)
        conditionArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
