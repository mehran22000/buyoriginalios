//
//  LocateStoreViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit
import MapKit

class LocateStoreViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        let backBtn = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;
        
        
        // Set map view delegate with controller
        self.mapView.delegate = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var curLat = String(format:"%f",appDelegate.curLocationLat)
        var curLon = String(format:"%f",appDelegate.curLocationLong)
        
        let location = CLLocationCoordinate2DMake(appDelegate.curLocationLat, appDelegate.curLocationLong)
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = location
        dropPin.title = "فروشگاه من"
        mapView.addAnnotation(dropPin)
        self.zoomIn();

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed () {
        self.navigationController?.popViewControllerAnimated(true);
    }

    @IBAction func continuePressed (sender:AnyObject?) {
        self.performSegueWithIdentifier("seguePushStorePhoneEntry", sender: sender)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if (annotation is MKUserLocation) {
            return nil
        }
        
        /*
        // Below condition is for custom annotation
        if (annotation.isKindOfClass(CustomAnnotation)) {
            let customAnnotation = annotation as? CustomAnnotation
            mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomAnnotation") as MKAnnotationView!
            
            if (annotationView == nil) {
                annotationView = customAnnotation?.annotationView()
            } else {
                annotationView.annotation = annotation;
            }
            
            self.addBounceAnimationToView(annotationView)
            return annotationView
        } else {
            return nil
        }
        */
        return nil;
    }
    
    func zoomIn() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let location = CLLocationCoordinate2DMake(appDelegate.curLocationLat, appDelegate.curLocationLong)
        let region = MKCoordinateRegionMakeWithDistance(
            location, 2000, 2000)
        
        self.mapView.setRegion(region, animated: true)
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
