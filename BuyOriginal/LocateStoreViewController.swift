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
    var account:AccountModel!;
    var annotation: MKPointAnnotation!;
    var mapClicked=false;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Guesture
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("foundTap:"))
        self.mapView.addGestureRecognizer(tapRecognizer)
        tapRecognizer.numberOfTapsRequired = 1;
        tapRecognizer.numberOfTouchesRequired = 1;
        self.mapView.delegate = self
        
        let backBtn = UIBarButtonItem(title: "فروشگاه >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;
        
        
        // Set map view delegate with controller
        self.mapView.delegate = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // ToDo: Remove
        /*
        if (appDelegate.curLocationLat == nil) {
            appDelegate.curLocationLat=35.790493;
            appDelegate.curLocationLong=51.435261;
        }
        */
        // var curLat = String(format:"%f",appDelegate.curLocationLat)
        // var curLon = String(format:"%f",appDelegate.curLocationLong)
        
        appDelegate.alertLocationRequired(self);
        let location:CLLocationCoordinate2D = appDelegate.getUserLocation();
        
        self.annotation = MKPointAnnotation();
        self.annotation.coordinate = location
        self.annotation.title = "فروشگاه من"
        mapView.addAnnotation(self.annotation)
        self.zoomIn();
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed () {
        self.navigationController?.popViewControllerAnimated(true);
    }

    @IBAction func continuePressed (sender:AnyObject?) {
        
        
        if (self.mapClicked==false) {
            
            let errMsg = "با حرکت دادن نقشه فروشگاه خود را بیایید و روی آن کلیک کنید" ;
            let alert = UIAlertView()
            alert.title = ""
            alert.message = errMsg
            alert.addButtonWithTitle("ادامه")
            alert.tag = 1
            alert.show()
        }
        else {
            self.performSegueWithIdentifier("seguePushStorePhoneEntry", sender: sender)
        }
        
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
            anView!.image = UIImage(named:"Pin.Store")
            anView!.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        
        return anView
    }
    
    func foundTap(recognizer: UIGestureRecognizer) {
        let point = recognizer.locationInView(self.mapView) as CGPoint;
        let tapPoint = self.mapView.convertPoint(point, toCoordinateFromView: self.view);
        let point1 = MKPointAnnotation();
        point1.coordinate = tapPoint;
        point1.subtitle = "mehran";
        self.mapView.removeAnnotation(self.annotation)
        self.mapView.addAnnotation(point1);
        self.annotation = point1;
        
        self.account.store.sLat = String(format: "%f",point1.coordinate.latitude);
        self.account.store.sLong = String(format: "%f",point1.coordinate.longitude);
        self.mapClicked=true;
    }
    
    
    func zoomIn() {
        
        var location:CLLocationCoordinate2D;
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        location = appDelegate.getUserLocation();
        
        let region = MKCoordinateRegionMakeWithDistance(
            location, 2000, 2000)
        
        self.mapView.setRegion(region, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "seguePushStorePhoneEntry"
        {
            if let destinationVC = segue.destinationViewController as? RegisterBusinessPhoneController{
                destinationVC.account = self.account;
            }
            
        }
        
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
