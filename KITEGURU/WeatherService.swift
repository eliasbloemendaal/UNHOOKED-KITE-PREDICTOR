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
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=2de143494c0b295cca9337e1e96b00e0"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            print(">>>>>>>\(data)")
            let json = JSON(data: data!)
            let lon = json["coord"]["lon"].double
            let lat = json["coord"]["lon"].double
            let tempK = json["main"]["temp"].double!
            let temp = tempK - 273.15
            let name = json["name"].string
            let desc = json["weather"][0]["description"].string
            let icon = json["weather"][0]["icon"].string
            let windSpeed = json["wind"]["speed"].double
            let windDeg = json["wind"]["deg"].double
           
            
            
            print("lon: \(lon!) lat: \(lat!) temp: \(temp)")
            
            let weather = Weather(cityName: name!, temp: temp, description: desc!, icon: icon!, windSpeed: windSpeed!, windDeg: windDeg!)
        
        
            if self.delegate != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.setWeather(weather)
                })

                
            }
        
        
//        print("Weather service city: \(city)")
//        
//        let weather = Weather(cityName: city, temp: 237.12, description: "A nice day")
//        
//        if delegate != nil {
//            delegate?.setWeather(weather)
//        }
    }
        task.resume()
    
}
}