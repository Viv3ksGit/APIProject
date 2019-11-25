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
    var listArray = [String]()
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        self.yourArray.insert(msg, at: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        self.tableView.endUpdates()
 */
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        cell.configureCell(weather: [self.city, self.temperature, self.condition])
        
        return cell
        
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        
        cell.configureCell(forecastData: forecastArray[indexPath.row])
        return cell*/
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return forecastArray.count
    }
}
