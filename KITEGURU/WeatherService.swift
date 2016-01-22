//
//  WeatherService.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 12-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    func setWeather (weather: Weather)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    func getWeather(city: String) {
        
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=2fdc8916da4f87fa4b5d42fce7c0139b" //appid=2de143494c0b295cca9337e1e96b00e0"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            print(">>>>>>>\(data)")
            let json = JSON(data: data!)
//            let lon = json["coord"]["lon"].double
//            let lat = json["coord"]["lon"].double
            var tempK = json["main"]["temp"].double
            if tempK == nil {
                tempK = 273.15
            }
            let temp = tempK! - 273.15

            
            var name = json["name"].string
            var desc = json["weather"][0]["description"].string
            var icon = json["weather"][0]["icon"].string
            var windSpeeds = json["wind"]["speed"].double
            
            if windSpeeds == nil {
                windSpeeds = 0
            }
            let windSpeed = (windSpeeds! * 1.94384449412)
            
            var windDeg = json["wind"]["deg"].double
            if windDeg == nil {
                windDeg = 0
            }
            
            if icon == nil {
                icon = "01d"
            }
            
            if desc == nil {
                desc = "Weather description"
            }
            
            if name == nil {
                name = "CityName"
            }
            
//            print("lon: \(lon!) lat: \(lat!) temp: \(temp)")
            
            let weather = Weather(cityName: name!, temp: temp, description: desc!, icon: icon!, windSpeed: windSpeed, windDeg: windDeg!)
        
        
            if self.delegate != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.setWeather(weather)
                })

                
            }
        
        
    }
        task.resume()
    
}
}