//
//  Analytics.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2016-03-14.
//  Copyright © 2016 MandM. All rights reserved.
//

import Foundation

public class Analytics {
    
    class func saveInterest(_key:String!, _value: String!)
    {
        // create date sring
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: NSDate())
        let year = String(components.year)
        let month = String(components.month)
        let day = String(components.day);
        
        // get user location information
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var lat = "";
        var lon = "";
        if (appDelegate.curLocationLat != nil){
            lat = String(format:"%f",appDelegate.curLocationLat)
            lon = String(format:"%f",appDelegate.curLocationLong)
        }
        
        // get device token
        let deviceToken = appDelegate.deviceToken;
        
        let defaults = NSUserDefaults.standardUserDefaults();
        
        let jsonDic = ["key":_key,"value":_value,"year":year,"month":month, "day":day,"lat":lat,"long":lon,"device":deviceToken];
        
        
        var array = defaults.objectForKey("userInterestsArray") as? [NSDictionary] ?? [NSDictionary]()
        
        print ("------ Analytics");
        print ("Current array of interest: \(array.description)");
        array.append(jsonDic);
        print ("New array of interests: \(array.description)");
        
        defaults.removeObjectForKey("userInterestsArray");
        defaults.setObject(array, forKey: "userInterestsArray");
        
    }
    
    class func buildAnalyticsObj(_key:String!, _value: String!, _unique: Bool) -> [NSDictionary]?
    {
        // create date sring
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: NSDate())
        let year = String(components.year)
        let month = String(components.month)
        let day = String(components.day);
        
        // get user location information
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var lat = "";
        var lon = "";
        if (appDelegate.curLocationLat != nil){
            lat = String(format:"%f",appDelegate.curLocationLat)
            lon = String(format:"%f",appDelegate.curLocationLong)
        }
        
        // get device token
        let deviceToken = appDelegate.deviceToken;
        let jsonDic = ["key":_key,"value":_value,"year":year,"month":month, "day":day,"lat":lat,"long":lon,"device":deviceToken];
        
        var array = [NSDictionary]();
        array.append(jsonDic);
        
        let defaults = NSUserDefaults.standardUserDefaults();
        let prevValue = defaults.objectForKey(_key) as? String;
        
        if (_unique == true) {
            defaults.setObject(_value, forKey: _key)
            if (prevValue == _value){
                return nil;
            }
        }
    
        return array;
    }
    
    
    class func postInterest()
    {
        
        let defaults = NSUserDefaults.standardUserDefaults();
        let array = defaults.objectForKey("userInterestsArray") as? [NSDictionary] ?? [NSDictionary]()
        if (array.count <= 0){
            return;
        }
        
        let httpPost = BOHttpPost();
        httpPost.postInterests({ (result) -> Void in
            if (result == "success"){
                print("postInterests success");
                defaults.removeObjectForKey("userInterestsArray");
            }
        });
        
    }
    
    class func registeDevice()
    {
        let httpPost = BOHttpPost();
        httpPost.registerDevice({ (result) -> Void in
            if (result == "success"){
                print("registering device was successful");
            }
        });
    }
    
    class func postAnalytics(_key:String!, _value: String!, _unique: Bool)
    {
        let msg = buildAnalyticsObj(_key, _value: _value, _unique: _unique) as [NSDictionary]?;
        if ((msg) != nil){
            let httpPost = BOHttpPost();
        
            httpPost.postAnalytics(msg!, completionHandler: { (result) -> Void in
                if (result == "success"){
                    print("postAnalytics success");
                }
            });
        }
    }
    
}
