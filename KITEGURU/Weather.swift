 //
//  Weather.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 12-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import Foundation

 //https://www.youtube.com/watch?v=YPFrQkZpIKw
 // these collections of video's, will have a total time of 2/3 hours
 struct Weather {
    
    let cityName: String
    let temp: Double
    let description: String
    let icon: String
    let windSpeed: Double
    let windDeg: Double
    
    
    init(cityName: String, temp: Double, description: String, icon: String, windSpeed: Double, windDeg: Double) {
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.icon = icon
        self.windSpeed = windSpeed
        self.windDeg = windDeg
    }
    
 }
 