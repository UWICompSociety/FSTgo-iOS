//
//  MapView.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/22/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIViewController, CLLocationManagerDelegate {
    var selection:Places?
    
    @IBOutlet weak var map: MKMapView!
    let manager  = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //tracking the location of user
        let user = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(user.coordinate.latitude, user.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        
        //Assigning Destination
        let locateString = self.selection?.location
        var locationArray = locateString!.components(separatedBy: ",")
        let destlatitude = Double(locationArray[0])
        let destlongitude = Double(locationArray[1])
        let destlocation = CLLocationCoordinate2DMake( destlatitude! , destlongitude!)
        
        //annotation of destination
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = destlatitude!
        annotation.coordinate.longitude = destlongitude!
        
        annotation.title = "You have reached:"
        annotation.subtitle = self.selection?.placesFullname
        
        //Creating route to destination
        let destMark = MKPlacemark(coordinate: destlocation)
        let sourceMark = MKPlacemark(coordinate: location)
        
        let sourceItem = MKMapItem(placemark: sourceMark)
        let destItem = MKMapItem(placemark: destMark)
        
        let request = MKDirectionsRequest()
        request.source = sourceItem
        request.destination = destItem
        request.transportType = .walking
        
        let directons = MKDirections(request: request)
        directons.calculate(completionHandler: { response, error in
    
            let route = response!.routes[0]
            self.map.add(route.polyline, level: .aboveRoads)
            let journey = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegionForMapRect(journey), animated: true)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        

    }
    func mapView(_mapView:MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayPathRenderer{
        //Customize route
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */




}

