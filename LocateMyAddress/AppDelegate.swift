//
//  AppDelegate.swift
//  LocateMyAddress
//
//  Created by D2V iMac on 31/10/19.
//  Copyright © 2019 D2V iMac. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSPlacesClient.provideAPIKey("xxxxxxxxxxxxxxxxxxxxXXXXXXXXXX")
        GMSServices.provideAPIKey("xxxxxxxxxxxxxxxxxxxxXXXXXXXXXXXX")
        return true
    }


}

