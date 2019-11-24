//
//  WeatherData.swift
//  APIProject
//
//  Created by Jeffrey Neil Dsouza on 2019-11-23.
//  Copyright © 2019 com.vivekmohanan. All rights reserved.
//


import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
