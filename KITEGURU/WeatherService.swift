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

// https://www.youtube.com/watch?v=r-LZs0De7_U
// The class weatherservice, The JSON data will be retrieved from the website and some of them will be converted
class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    // Functions where the weather data will be retrieved en converted from JSON to Strings and Doubles
    func getWeather(city: String) {
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=e23df117a6d8bf3fd096882b8f88776e" 
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            print(">>>>>>>\(data)")
            let json = JSON(data: data!)
            var tempK = json["main"]["temp"].double
            var name = json["name"].string
            var desc = json["weather"][0]["description"].string
            var icon = json["weather"][0]["icon"].string
            var windSpeeds = json["wind"]["speed"].double
            var windDeg = json["wind"]["deg"].double
            
            // Temperature will be nil and will be converted to celsius here
            if tempK == nil {
                tempK = 273.15
            }
            let temp = tempK! - 273.15

            // Windspeeds will never be nil && it will be converted to knots
            if windSpeeds == nil {
                windSpeeds = 0
            }
            let windSpeed = (windSpeeds! * 1.94384449412)
            
            // Windircetion will never be nil
            if windDeg == nil {
                windDeg = 0
            }
            
            // Icon will never be nil
            if icon == nil {
                icon = "01d"
            }
            
            // Description of the weather will never be nil
            if desc == nil {
                desc = "Weather description"
            }
            
            // CityName will never be nil
            if name == nil {
                name = "CityName"
            }
            
            // Weather struct
            let weather = Weather(cityName: name!, temp: temp, description: desc!, icon: icon!, windSpeed: windSpeed, windDeg: windDeg!)
        
            // Als the delegate niet nil dan moet je update
            if self.delegate != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.setWeather(weather)
                })
            }
    }
        task.resume()
}
}