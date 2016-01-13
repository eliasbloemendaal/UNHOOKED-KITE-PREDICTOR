//
//  WheaterPredictionsViewController.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 07-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import UIKit

class WheaterPredictionsViewController: UIViewController, WeatherServiceDelegate {

    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var WindSpeedLabel: UILabel!
    @IBOutlet weak var WindDirectionLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var wheaterMoodLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    let weatherService = WeatherService()

    
    @IBAction func GetDataButton(sender: AnyObject) {
        self.cityNameLabel.text = CityTextField?.text!
        let name = CityTextField?.text
        self.weatherService.getWeather(name!)
        
//        weatherImage.image = UIImage(named: weather.icon)
        
        
//        
//        if weatherObject.getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=2de143494c0b295cca9337e1e96b00e0") {
//            cityNameLabel.text = weatherObject.cityName
//            WindSpeedLabel.text = weatherObject.windSpeed
//            TempLabel!.text! = weatherObject.tempInCelsius
//            WindDirectionLabel!.text! = weatherObject.windDirection
//            
//            updateLabels()
//        }

        
        
//        cityNameLabel!.text! = cityName
//        WindSpeedLabel!.text! = windSpeed
//        TempLabel!.text! = tempInCelsius
//        WindDirectionLabel!.text! = windDirection
//        print(cityName)
//        print(cityName)
    }
    
    func setWeather(weather: Weather) {
        print("set weather")
        print("City: \(weather.cityName) temp:\(weather.temp) description:\(weather.description) ")
        cityNameLabel.text = weather.cityName
        TempLabel.text = "\(weather.temp)"
        wheaterMoodLabel.text = weather.description
        weatherImage.image = UIImage(named: weather.icon)
        WindSpeedLabel.text = "\(weather.windSpeed)"
        WindDirectionLabel.text = "\(weather.windDeg)"
        
    }
    
    func updateLabels() {
        
//        cityNameLabel.text = String(cityName)
//        WindSpeedLabel.text = windSpeed
//        TempLabel.text = tempInCelsius
//        WindDirectionLabel.text = windDirection
//        nameofcity = weatherObject.cityName
//        cityNameLabel.text = weatherObject.cityName
//        print(nameofcity)
//        print(weatherObject.cityName)
//        print(weatherObject.windSpeed)
//        print(weatherObject.tempInCelsius)
//        print(weatherObject.windDirection)
        
//        cityNameLabel.text = weatherObject.cityName
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.weatherService.delegate = self
        
//        if weatherObject.getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=scheveningen&appid=2de143494c0b295cca9337e1e96b00e0") {
//             cityNameLabel.text = weatherObject.cityName
//        cityNameLabel!.text! = cityName
//        WindSpeedLabel!.text! = windSpeed
//        TempLabel!.text! = tempInCelsius
//        WindDirectionLabel!.text! = windDirection
//        print(cityName)
//        print(cityName)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func getWeatherData(urlString: String) {
//        let url = NSURL(string: urlString)
//        print(url)
//        print(urlString)
//
//        
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithURL(url!) { (data, response, error) in dispatch_async(dispatch_get_main_queue(), {
//            self.setLabels(data!)
//            })
//        }
//        task.resume()
//    }
////
////    //        var url : NSURL = NSURL(string: urlString)!
////    //        let session = NSURLSession.sharedSession()
////    //        var task = session.dataTaskWithURL(url, completionHandler: {
////    //            (data, response, error) -> Void in
////    //            self.setWeatherLabel(data!)
////    //        })
////    //        task.resume()﻿
////    
//    func setLabels(weatherData: NSData) {
//       
//        do {
//            let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
//            print(json)
//            
//            //cityNameLabel.text = json[("name")] as? String
//            if let name = json[("name")] as? String {
//                cityNameLabel.text = name
//            }
//            
//            if let main = json[("main")] as? NSDictionary {
//                if let temp = main[("temp")] as? Double {
//                    
//                    //convert kelvin to celsius
//                    let celsius = (temp - 273.15)
//                    print(celsius)
//                    TempLabel.text = String(format: "%.2f", celsius) + " Celsius"
//                    
//                    }
//                }
//            
//            if let main = json[("wind")] as? NSDictionary {
//                if let winddir = main[("deg")] as? Double {
//                    
//                    WindDirectionLabel.text = String(winddir) + " deg"
//                }
//            }
//            
//            if let main = json[("wind")] as? NSDictionary {
//                if let windspeed = main[("speed")] as? Double {
//                    
//                    WindSpeedLabel.text = String(windspeed) + " m/s"
//                }
//            }
//
//        } catch let error as NSError {
//        print(error)
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
