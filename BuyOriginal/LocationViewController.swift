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
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let storeAnnotation = MKPointAnnotation()
        storeAnnotation.coordinate = pinLocation
        storeAnnotation.title = storeName
        self.mapView.addAnnotation(storeAnnotation)
        
        
        // Display a pin for current location
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       
        var currentPinLocation : CLLocationCoordinate2D?;
        
        //TODO: Remove
        // if (appDelegate.curLocationLat == nil) {
        //    appDelegate.curLocationLat=35.790493;
        //    appDelegate.curLocationLong=51.435261;
        // }
        
        appDelegate.alertLocationRequired(self);
        if ((appDelegate.curLocationLat) != nil){
            
            currentPinLocation = CLLocationCoordinate2DMake(appDelegate.curLocationLat, appDelegate.curLocationLong)
            let currentAnnotation = MKPointAnnotation()
            
            currentAnnotation.coordinate = currentPinLocation!
            currentAnnotation.title = "Current Location"
            self.mapView.addAnnotation(currentAnnotation)
            self.mapView.addAnnotations([storeAnnotation,currentAnnotation]);
            
            self.fitMapViewToAnnotaionList([storeAnnotation,currentAnnotation])
        
        }
        else {
            self.mapView.addAnnotations([storeAnnotation]);
            
            let latDelta:CLLocationDegrees = 0.01
            let longDelta:CLLocationDegrees = 0.01
            let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(pinLocation, theSpan)
            mapView.setRegion(region, animated: true)
        }
        
        
        
//        // Show Region
//        var centerLocation = CLLocationCoordinate2D();
//        if (currentPinLocation != nil){
//            centerLocation.latitude = ((currentPinLocation?.latitude)! + pinLocation.latitude) / 2;
//            centerLocation.longitude = ((currentPinLocation?.longitude)! + pinLocation.longitude) / 2;
//        }
//        else {
//            centerLocation = pinLocation;
//        }
//        
//        
//        let region:MKCoordinateRegion = MKCoordinateRegionMake(centerLocation, theSpan)
//        mapView.setRegion(region, animated: true)

        
        
    }
    
    func fitMapViewToAnnotaionList(annotations: [MKPointAnnotation]) -> Void {
        
        let mapEdgePadding = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        var zoomRect:MKMapRect = MKMapRectNull
        
        for index in 0..<annotations.count {
            let annotation = annotations[index]
            let aPoint:MKMapPoint = MKMapPointForCoordinate(annotation.coordinate)
            let rect:MKMapRect = MKMapRectMake(aPoint.x, aPoint.y, 0.1, 0.1)
            
            if MKMapRectIsNull(zoomRect) {
                zoomRect = rect
            } else {
                zoomRect = MKMapRectUnion(zoomRect, rect)
            }
        }
        
        mapView.setVisibleMapRect(zoomRect, edgePadding: mapEdgePadding, animated: true)
        
        
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

    
    
    
    
    @objc func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            if (annotation.title! == "Current Location"){
                anView!.image = UIImage(named:"pin.user")
            }
            else {
                anView!.image = UIImage(named:"pin.destination")
            }
            anView!.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        
        return anView
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
