//
//  ViewController.swift
//  Memorable Places
//
//  Created by Ivaylo Todorov on 28.11.15 г..
//  Copyright © 2015 г. Ivaylo Todorov. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager: CLLocationManager!
    
    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        uilpgr.minimumPressDuration = 2.0
        
        map.addGestureRecognizer(uilpgr)
    /*    var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        uilpgr.minimumPressDuration = 2.0
        
        map.addGestureRecognizer(uilpgr)
      */
    }
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            var touchPoint = gestureRecognizer.locationInView(self.map)
            var newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
    /*func action(gestureRecognizer: UIGestureRecognizer){
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
            var touchPoint = gestureRecognizer.locationInView(self.map)
            
            var newCoordinate:CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
       */
                var title = ""
                
                if (error == nil) {
                    
                    if let p = placemarks?.first {
                        
                        var subThoroughfare:String = ""
                        
                        var thoroughfare:String = ""
                        
                        if p.subThoroughfare != nil {
                            
                            subThoroughfare = p.subThoroughfare!
                            
                        }
                        
                        if p.thoroughfare != nil {
                            
                            thoroughfare = p.thoroughfare!
                            
                        }
                        
                       title = "\(subThoroughfare) \(thoroughfare)"
                    }
                }
                
                if title == "" {
                    
                    title = "Added \(NSDate())"
                    
                }
                
                places.append(["name":title,"lat":"\(newCoordinate.latitude)", "lon":"\(newCoordinate.longitude)"])
                
            })
            
            var annotation = MKPointAnnotation()
            
            annotation.title = title
            
            self.map.addAnnotation(annotation)
            
        }
    }
    
    
    
    
    
    
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var userLocation:CLLocation = locations[0] 
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        var coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        self.map.setRegion(region, animated: true)

    
   

    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    }

}


