//
//  LocationManager.swift
//  ZJXT_Swift
//
//  Created by User on 2017/10/25.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MapKit

class LocationManager: NSObject
{
    static let manager = LocationManager.init()

    fileprivate lazy var locationManager:CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        return locationManager
    }()
    
    fileprivate var finish:((CLLocationCoordinate2D)->Void)?
    fileprivate var reverse:(([CLPlacemark])->Void)?
    
    class func startLocation(finish:((CLLocationCoordinate2D)->Void)?,reverse:(([CLPlacemark])->Void)?)
    {
        LocationManager.manager.finish = finish
        LocationManager.manager.reverse = reverse
        LocationManager.manager.start()
    }
    
    fileprivate func start()
    {
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager:CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status
        {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.first?.coordinate
        self.locationManager.stopUpdatingLocation()
        if self.finish != nil
        {
            self.finish!(newLocation!)
        }
        
        if self.reverse != nil
        {
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(locations.first!) { (placeMark, error) in
                if error == nil
                {
                    self.reverse!(placeMark!)
                }
            }
        }
        
        
    }
}
