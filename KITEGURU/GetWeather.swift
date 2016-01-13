//
//  GetWeather.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 08-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import Foundation




class weather {
    
    var cityName = String()
    var tempInCelsius = String()
    var windDirection = String()
    var windSpeed = String()
    
func getWeatherData(urlString: String) -> Bool {
    let url = NSURL(string: urlString)
    print(url)
    print(urlString)
    
    
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        print(">>>>>>>\(data)")
        let json = JSON(data: data!)
        let temp = json["main"]["temp"].double
        
        self.tempInCelsius = String(temp)
    }
          
    

    task.resume()
    WheaterPredictionsViewController().updateLabels()
    
    return true
}

func setLabels(weatherData: NSData) {
    
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
        print(json)
        
        //cityNameLabel.text = json[("name")] as? String
        if let name = json[("name")] as? String {
//            WindSpeedLabel.text = name
            cityName = name
            print(cityName)
        }
        
        if let main = json[("main")] as? NSDictionary {
            if let temp = main[("temp")] as? Double {
                
                //convert kelvin to celsius
                let celsius = (temp - 273.15)
                print(celsius)
//                TempLabel.text = String(format: "%.2f", celsius) + " Celsius"
                tempInCelsius = String(format: "%.2f", celsius) + " Celsius"
            }
        }
        
        if let main = json[("wind")] as? NSDictionary {
            if let winddir = main[("deg")] as? Double {
                windDirection = String(winddir) + " deg"
            }
        }
        
        if let main = json[("wind")] as? NSDictionary {
            if let windspeed = main[("speed")] as? Double {
                windSpeed = String(windspeed) + " m/s"
            }
        }
        
    } catch let error as NSError {
        print(error)
    }
}
}