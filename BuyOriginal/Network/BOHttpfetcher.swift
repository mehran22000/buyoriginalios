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
        var url : String = "https://buyoriginal.herokuapp.com/brands/brandlist"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            var jsonResult: NSArray!
            if (data != nil){
                jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSArray
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                var parsedArray = parser.parseBrandArray(jsonResult)
                completionHandler(result: parsedArray)
                // process jsonResult
            } else {
                // couldn't load JSON, look at error
            }
        })
    }
    
    func fetchBrandLogo (logo:String, completionHandler:(imgData:NSData)->Void) -> () {
        
        var logoUrl : String = "https://buyoriginal.herokuapp.com/images/logos/"+logo+".jpg";
        println("logoUrl: \(logoUrl)");
        
        if let url = NSURL(string: logoUrl) {
            let imageDataFromURL = NSData(contentsOfURL: url)
            if ((imageDataFromURL) != nil){
                completionHandler(imgData: imageDataFromURL!);
            }
        }
    }
}

