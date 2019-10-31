//
//  ViewController.swift
//  LocateMyAddress
//
//  Created by D2V iMac on 31/10/19.
//  Copyright © 2019 D2V iMac. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      self.locationManager.delegate = self
      self.locationManager.startUpdatingLocation()
        
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

    }


    @IBAction func changeLocationAction(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
           autocompleteController.delegate = self
           let filter = GMSAutocompleteFilter()
           filter.country = "IND"
           autocompleteController.autocompleteFilter = filter
           self.present(autocompleteController, animated: false, completion: nil)
        
    }
    
    func zoomToMyLocation(lat: Double, long: Double, placeName: String) {
        
        let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
             let marker = GMSMarker(position: position)
             marker.title = placeName
             marker.map = mapView
             self.mapView.animate(toLocation: position)
             self.mapView.animate(toZoom: 18.0)
            addressLbl.text = placeName
    }
}


extension ViewController: GMSAutocompleteViewControllerDelegate {

  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
  {

    
    zoomToMyLocation(lat: place.coordinate.latitude, long: place.coordinate.longitude, placeName: place.formattedAddress ?? "")
     
      dismiss(animated: true, completion: nil)
      
  }
  
  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {

      print("Error: ", error.localizedDescription)
  }

  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
      
      dismiss(animated: false) {
      }
  }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.last
        
        guard location != nil else {
            print("Failed to fetch current location")
            return
        }

        zoomToMyLocation(lat: location?.coordinate.latitude ?? 0.00, long: location?.coordinate.longitude ?? 0.00, placeName: "Current Location")

        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()

    }
}
