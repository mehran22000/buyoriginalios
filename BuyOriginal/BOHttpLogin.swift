//
//  BOHttpLogin.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-19.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BOHttpLogin: NSObject {
    
    func login (email: NSString, password:NSString, completionHandler:(result:AccountModel?)->Void) -> () {
        var url: String = "https://buyoriginal.herokuapp.com/users/business/login"
        // var url: String = "http://localhost:5000/users/business/login"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        
        var bodyData = "email="+(email as String)+"&password="+(password as String);
        println(bodyData);
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            var jsonResult: NSArray!
            var accountInfo: AccountModel?
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            if (data != nil){
                jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as! NSArray
            }
            if (jsonResult != nil) {
                let parser = ResponseParser()
                accountInfo = parser.parseLogin(jsonResult);
            }
            
            completionHandler(result: accountInfo);
        }
    }
    
    func recoverPassword (email:String,
            completionHandler:(result: String)->Void) -> () {
                
          let url = "https://buyoriginal.herokuapp.com/users/business/forgetpassword/"+email;
    //    let url = "http://localhost:5000/users/business/forgetpassword/"+email;
                println("url: \(url)");
                
                var request : NSMutableURLRequest = NSMutableURLRequest()
                request.URL = NSURL(string: url)
                request.HTTPMethod = "GET"
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                    var jsonResult: NSDictionary!
                    if (data != nil){
                        jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
                    }
                    if (jsonResult != nil) {
                        let parser = ResponseParser()
                        var result:String = parser.parseServiceResult(jsonResult) as String;
                        completionHandler(result: result)
                        // process jsonResult
                    } else {
                        // couldn't load JSON, look at error
                    }
                })
        }
    
    
    func duplicateEmail (email:String,
        completionHandler:(result: String)->Void) -> () {
            
            let url = "https://buyoriginal.herokuapp.com/users/business/validateemail/"+email;
            // let url = "http://localhost:5000/users/business/validateemail/"+email;
            println("url: \(url)");
            
            var request : NSMutableURLRequest = NSMutableURLRequest()
            request.URL = NSURL(string: url)
            request.HTTPMethod = "GET"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                var jsonResult: NSDictionary!
                if (data != nil){
                    jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
                }
                if (jsonResult != nil) {
                    let parser = ResponseParser()
                    var result:String = parser.parseValidateEmail(jsonResult) as String;
                    completionHandler(result: result)
                    // process jsonResult
                } else {
                    // couldn't load JSON, look at error
                }
            })
    }
    
    func deleteUserAccount (email:String?,sid:String?,
        completionHandler:(result: String)->Void) -> () {
            
            let url = "https://buyoriginal.herokuapp.com/users/business/deleteuser/"+email!+"/"+sid!;
        //    let url = "http://localhost:5000/users/business/deleteuser/"+email!+"/"+sid!;
            
            println("url: \(url)");
            
            var request : NSMutableURLRequest = NSMutableURLRequest()
            request.URL = NSURL(string: url)
            request.HTTPMethod = "GET"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                var jsonResult: NSDictionary!
                if (data != nil){
                    jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
                }
                if (jsonResult != nil) {
                    let parser = ResponseParser()
                    var result:String = parser.parseServiceResult(jsonResult) as String;
                    completionHandler(result: result)
                    // process jsonResult
                } else {
                    // couldn't load JSON, look at error
                }
            })
    }
}
