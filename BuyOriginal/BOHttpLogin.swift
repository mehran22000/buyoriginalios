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
        let url: String = "https://buyoriginal.herokuapp.com/users/business/login"
        // var url: String = "http://localhost:5000/users/business/login"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        request.addValue(GlobalConstants.serverToken, forHTTPHeaderField: "token");
        
        let bodyData = "email="+(email as String)+"&password="+(password as String);
        // print(bodyData);
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            var jsonResult: NSArray!
            var accountInfo: AccountModel?
           // var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            if (data != nil){
                do {
                    try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSArray
                }
                catch {
                    
                }
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
              //  print("url: \(url)");
                
                let request : NSMutableURLRequest = NSMutableURLRequest()
                request.URL = NSURL(string: url)
                request.HTTPMethod = "GET"
                request.addValue(GlobalConstants.serverToken, forHTTPHeaderField: "token");
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                 //   var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                    var jsonResult: NSDictionary!
                    if (data != nil){
                        do {
                        try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        }
                        catch {
                            
                        }
                    }
                    if (jsonResult != nil) {
                        let parser = ResponseParser()
                        let result:String = parser.parseServiceResult(jsonResult) as String;
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
            // print("url: \(url)");
            
            let request : NSMutableURLRequest = NSMutableURLRequest()
            request.URL = NSURL(string: url)
            request.HTTPMethod = "GET"
            request.addValue(GlobalConstants.serverToken, forHTTPHeaderField: "token");
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
             //   var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                var jsonResult: NSDictionary!
                if (data != nil){
                    do {
                        try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    }
                    catch {
                        
                    }
                }
                if (jsonResult != nil) {
                    let parser = ResponseParser()
                    let result:String = parser.parseValidateEmail(jsonResult) as String;
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
            
            // print("url: \(url)");
            
            let request : NSMutableURLRequest = NSMutableURLRequest()
            request.URL = NSURL(string: url)
            request.HTTPMethod = "GET"
            request.addValue(GlobalConstants.serverToken, forHTTPHeaderField: "token");
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
      //          var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                var jsonResult: NSDictionary!
                if (data != nil){
                    do {
                        try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    }
                    catch {
                        
                    }
                }
                if (jsonResult != nil) {
                    let parser = ResponseParser()
                    let result:String = parser.parseServiceResult(jsonResult) as String;
                    completionHandler(result: result)
                    // process jsonResult
                } else {
                    // couldn't load JSON, look at error
                }
            })
    }
}
