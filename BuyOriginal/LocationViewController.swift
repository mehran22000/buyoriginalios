//
//  LocationViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-06-06.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var lat = 0.0
    var long = 0.0
    var storeName = "";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
           self.showLocation(lat, long: long)
        // self.showDirection(lat, long: long)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showLocation(lat: Double, long: Double) {
        let latDelta:CLLocationDegrees = 0.01
    
        let longDelta:CLLocationDegrees = 0.01
    
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
    
        let region:MKCoordinateRegion = MKCoordinateRegionMake(pointLocation, theSpan)
        mapView.setRegion(region, animated: true)
    
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = storeName
        self.mapView.addAnnotation(objectAnnotation)
    }
    
    /*
    func showDirection (lat: Double, long: Double) {
        
        var lat = 42.290509;
        var long = -89.086539;
        
        let request = MKDirectionsRequest()
        request.setSource(MKMapItem.mapItemForCurrentLocation())
        
        var placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude:long), addressDictionary: nil);
        var destination = MKMapItem(placemark: placemark);
        request.setDestination(destination!)
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler({(response:
            MKDirectionsResponse!, error: NSError!) in
            
            if error != nil {
                // Handle error
            } else {
                self.showRoute(response)
            }
            
        })
    }
    */
    
    func showRoute(response: MKDirectionsResponse) {
        
        for route in response.routes {
            
            self.mapView.addOverlay(route.polyline,
                level: MKOverlayLevel.AboveRoads)
            
            for step in route.steps {
                print(step.instructions)
            }
        }
        
        let userLocation = self.mapView.userLocation
        
        print(userLocation);
        
        
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000, 2000)
        
        self.mapView.setRegion(region, animated: true)
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay
        overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            renderer.strokeColor = UIColor.blueColor()
            renderer.lineWidth = 5.0
            return renderer
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
