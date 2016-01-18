//
//  WheaterPredictionsViewController.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 07-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import UIKit
import MapKit

class WheaterPredictionsViewController: UIViewController, WeatherServiceDelegate, UISearchBarDelegate {

    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var WindSpeedLabel: UILabel!
    @IBOutlet weak var WindDirectionLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var wheaterMoodLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!

    let weatherService = WeatherService()

    @IBOutlet weak var mapView: MKMapView!
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    
    @IBAction func SearchNavigationBarButton(sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    
    
    func setWeather(weather: Weather) {
        print("set weather")
        print("City: \(weather.cityName) temp:\(weather.temp) description:\(weather.description) ")
        cityNameLabel.text = weather.cityName
        TempLabel.text = String(format: "%.2f", weather.temp) + " Celsius"
        wheaterMoodLabel.text = weather.description
        weatherImage.image = UIImage(named: weather.icon)
//        WindSpeedLabel.text = "\(weather.windSpeed)"
        WindSpeedLabel.text = String(format: "%.2f", weather.windSpeed) + " Knots"
        WindDirectionLabel.text = String(format: "%.2f", weather.windDeg) + " Direction"
        
    }
    
    func resetTextField() {
        CityTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.weatherService.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        //1
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        //2
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text

        let name = searchBar.text
        self.weatherService.getWeather(name!)
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


}
