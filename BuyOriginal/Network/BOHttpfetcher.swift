//
//  BOHttpfetcher.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-30.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BOHttpfetcher: NSObject {
    
    func fetchBrands (completionHandler:(result: NSArray)->Void) -> () {
        let url : String = "https://buyoriginal.herokuapp.com/brands/brandlist"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            var jsonResult: NSArray!
            if (data != nil){
                do {
                try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as? NSArray
                }
                catch {
                    
                }
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                let parsedArray = parser.parseBrandArray(jsonResult)
                completionHandler(result: parsedArray)
                // process jsonResult
            } else {
                // couldn't load JSON, look at error
            }
        })
    }
    
    
    func fetchStores (brandId:String,
                      distance:String!,
                      lat: String!,
                      lon: String!,
                      areaCode: String,
                      discount: Bool,
                      completionHandler:(result: NSArray)->Void) -> () {
        
        var url : String;
        if (discount) {
           url = "https://buyoriginal.herokuapp.com/stores/storelist/discounts/"+lat+"/"+lon+"/"+distance;
         //  url = "http://localhost:5000/stores/storelist/discounts/"+lat+"/"+lon+"/"+distance;
        }
        else if (distance != nil){
            url = "https://buyoriginal.herokuapp.com/stores/storelist/"+brandId+"/"+lat+"/"+lon+"/"+distance;
        //    url = "http://localhost:5000/stores/storelist/"+brandId+"/"+lat+"/"+lon+"/"+distance;
        }
        else {
                url = "https://buyoriginal.herokuapp.com/stores/storelist/city/"+areaCode+"/"+brandId;
        }
        print("url: \(url)");
                        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
          //  var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            var jsonResult: NSArray!
            if (data != nil){
                do {
                    try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as? NSArray
                }
                catch {
                    
                }
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                let dic:NSDictionary = parser.parseStoreArray(jsonResult);
                let storesArray:NSArray = dic.objectForKey("stores") as! NSArray;
                completionHandler(result: storesArray)
                // process jsonResult
            } else {
                // couldn't load JSON, look at error
            }
        })
    }
    
    
    func fetchCityBrands (areaCode:String,
                          completionHandler:(result: NSArray)->Void) -> () {
            
            var url : String;
           // url = "http://localhost:5000/stores/storelist/city/"+areaCode;
            url = "https://buyoriginal.herokuapp.com/stores/storelist/city/"+areaCode;
            print("url: \(url)");
            
            let request : NSMutableURLRequest = NSMutableURLRequest()
            request.URL = NSURL(string: url)
            request.HTTPMethod = "GET"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
               // var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                var jsonResult: NSArray!
                if (data != nil){
                    do {
                        try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as? NSArray
                    }
                    catch {
                        
                    }
                }
                if (jsonResult != nil) {
                    
                    let parser = ResponseParser()
                    let dic:NSDictionary = parser.parseStoreArray(jsonResult);
                    let brandsArray:NSArray = dic.objectForKey("brands") as! NSArray;
                    completionHandler(result: brandsArray)
                    // process jsonResult
                } else {
                    // couldn't load JSON, look at error
                }
            })
    }
    
    
    
    func fetchCityCategories (areaCode:String,
        completionHandler:(result: NSDictionary)->Void) -> () {
            
            var url : String;
            // url = "http://localhost:5000/stores/storelist/storelist/city/"+areaCode;
            url = "https://buyoriginal.herokuapp.com/stores/storelist/city/"+areaCode;
            print("url: \(url)");
            
            let request : NSMutableURLRequest = NSMutableURLRequest()
            request.URL = NSURL(string: url)
            request.HTTPMethod = "GET"
            
            if (Utilities.isConnectedToNetwork()){
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                    
                   // var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                    var jsonResult: NSArray!
                    if (data != nil){
                        do {
                            try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as? NSArray
                        }
                        catch {
                            
                        }
                    }
                    if (jsonResult != nil) {
                    
                        // Store data for Offline use
                        let documentDirectoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
                    
                        let fileDestinationUrl = documentDirectoryURL.URLByAppendingPathComponent(areaCode+".txt")
                        let text = NSString(data:data!, encoding:NSUTF8StringEncoding);
                        do {
                            try text!.writeToURL(fileDestinationUrl, atomically: true, encoding: NSUTF8StringEncoding)
                        }
                        catch {
                            
                        }
                        
                    
                        // Parse response
                        let parser = ResponseParser()
                        let dic:NSDictionary = parser.parseStoreArray(jsonResult);
                        completionHandler(result: dic)
                    
                    } else {
                        // couldn't load JSON, look at error
                    }
                })
            }
            else {
                // Reading data from the file
                
                // var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                var jsonResult: NSArray!
                
                
                let documentDirectoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
                
                let fileDestinationUrl = documentDirectoryURL.URLByAppendingPathComponent(areaCode+".txt")
                
                do {
                    let mytext = try String(contentsOfURL: fileDestinationUrl, encoding: NSUTF8StringEncoding)
                    if (mytext.characters.count>0) {
                        
                        let data = (mytext as NSString).dataUsingEncoding(NSUTF8StringEncoding)
                        
                        try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as? NSArray
                        // Parse response
                        let parser = ResponseParser()
                        let dic:NSDictionary = parser.parseStoreArray(jsonResult);
                        completionHandler(result: dic)
                        
                    }
                    else {
                        let dic:NSDictionary = NSDictionary();
                        completionHandler(result: dic);
                    }
                }
                catch {
                    
                }
                
            }
    }
    
    
    
    
    func fetchBrandLogo (logo:String, completionHandler:(imgData:NSData!)->Void) -> () {
        
        let logoUrl : String = "https://buyoriginal.herokuapp.com/images/logos/"+logo+".jpg";
    //    println("logoUrl: \(logoUrl)");
        
        if let url = NSURL(string: logoUrl) {
            let imageDataFromURL = NSData(contentsOfURL: url)
            if ((imageDataFromURL) != nil){
                completionHandler(imgData: imageDataFromURL!);
            }
            else {
                completionHandler(imgData: nil);
            }
        }
    }
    
}

