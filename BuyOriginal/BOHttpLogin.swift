//
//  BOHttpLogin.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-19.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BOHttpLogin: NSObject {
    
    func login (email: NSString, password:NSString, completionHandler:(result:NSString)->Void) -> () {
        var url: String = "https://buyoriginal.herokuapp.com/users/business/login"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        
        var bodyData = "email="+(email as String)+"&password="+(password as String);
        println(bodyData);
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            var jsonResult: NSArray!
            var loginResult = "";
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            if (data != nil){
                jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as! NSArray
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                loginResult = parser.parseLogin(jsonResult) as String;
            }
            
            completionHandler(result: loginResult);
        }
        
        /*
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            var jsonResult: NSArray!
            if (data != nil){
                jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSArray
            }
            if (jsonResult != nil) {
                
           //     let parser = ResponseParser()
           //     var parsedArray = parser.parseBrandArray(jsonResult)
           //     completionHandler(result: parsedArray)
                // process jsonResult
            } else {
                // couldn't load JSON, look at error
            }
        })

        */
    }
}
