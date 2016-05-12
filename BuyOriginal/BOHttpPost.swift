//
//  BOHttpPost.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-24.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BOHttpPost: NSObject {
   
    func addOrUpdateBusiness (update:Bool, account:AccountModel, completionHandler:(result:NSString)->Void) -> () {
        
        var url: String;
        if (update == true) {
            url = "https://buyoriginal.herokuapp.com/services/v1/users/business/updateuser"
         //   url = "http://localhost:5000/users/business/updateuser"
        }
        else {
            url = "https://buyoriginal.herokuapp.com/services/v1/users/business/adduser"
       //   url = "http://localhost:5000/users/business/adduser"
        }
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        request.addValue(GlobalConstants.serverToken, forHTTPHeaderField: "token");
    
        var bodyData = "";
        if (update == true) {
            bodyData = "buId="+(account.uId as String)+"&buEmail="+(account.uEmail as String)+"&buPassword="+(account.uPassword as String)+"&buCityName="+(account.sCity.cityName as String)+"&buCityNameFa="+(account.sCity.cityNameFa as String)+"&buBrandId="+(account.brand.bId as String)+"&buBrandName="+(account.brand.bName as String)+"&buBrandCategory="+(account.brand.bCategory as String)+"&buStoreName="+(account.store.sName as String)+"&buStoreId="+(account.store.sId as String)+"&buStoreAddress="+(account.store.sAddress as String)+"&buStoreHours="+(account.store.sHours as String)+"&buDistributor="+(account.store.bDistributor as String)+"&buStoreLat="+(account.store.sLat as String)+"&buStoreLon="+(account.store.sLong as String)+"&buAreaCode="+(account.sCity.areaCode as String)+"&buTel="+(account.store.sTel1 as String)+"&buBrandLogoName="+(account.brand.bLogo as String);
        }
        else {
            bodyData = "buEmail="+(account.uEmail as String)+"&buPassword="+(account.uPassword as String)+"&buCityName="+(account.sCity.cityName as String)+"&buCityNameFa="+(account.sCity.cityNameFa as String)+"&buBrandId="+(account.brand.bId as String)+"&buBrandName="+(account.brand.bName as String)+"&buBrandCategory="+(account.brand.bCategory as String)+"&buStoreName="+(account.store.sName as String)+"&buStoreAddress="+(account.store.sAddress as String)+"&buStoreHours="+(account.store.sHours as String)+"&buDistributor="+(account.store.bDistributor as String)+"&buStoreLat="+(account.store.sLat as String)+"&buStoreLon="+(account.store.sLong as String)+"&buAreaCode="+(account.sCity.areaCode as String)+"&buTel="+(account.store.sTel1 as String)+"&buBrandLogoName="+(account.brand.bLogo as String);
        }
        
        print(bodyData);
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            var jsonResult: NSArray!
            var postResult = "";
           // var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            if (data != nil){
                do {
                    try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSArray
                }
                catch{
                    
                }
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                postResult = parser.parsePost(jsonResult) as String;
            }
            
            completionHandler(result: postResult);
        }
    }
    
    
    func addDiscount (account:AccountModel, discount:DiscountModel, completionHandler:(result:NSString)->Void) -> () {
        
        let url: String = "https://buyoriginal.herokuapp.com/services/v1/stores/adddiscount"
        //  var url: String = "http://localhost:5000/stores/adddiscount"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        request.addValue(GlobalConstants.serverToken, forHTTPHeaderField: "token");
        
        if (discount.note.isEmpty==true){
            discount.note = "";
        }
        if (discount.precentage.isEmpty==true){
            discount.precentage = "0";
        }
        
        
        
        let bodyData = "bId="+(account.store.bId as String)+"&sId="+(account.store.sId as String)+"&startDate="+(discount.startDateStr as String)+"&endDate="+(discount.endDateStr as String)+"&startDateFa="+(discount.startDateStrFa as String)+"&endDateFa="+(discount.endDateStrFa as String)+"&precentage="+(discount.precentage as String)+"&note="+(discount.note as String);
        
        // print(bodyData);
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            var jsonResult: NSArray!
            var postResult = "";
         //   var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            if (data != nil){
                do {
                    try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSArray
                }
                catch {
                    
                }
                
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                postResult = parser.parsePost(jsonResult) as String;
            }
            
            completionHandler(result: postResult);
        }
    }
    
    
    func deleteDiscount (sId:String, bId:String, completionHandler:(result:NSString)->Void) -> () {
        
        let url: String = "https://buyoriginal.herokuapp.com/services/v1/stores/deletediscount"
        // var url: String = "http://localhost:5000/stores/deletediscount"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        request.addValue(GlobalConstants.serverToken, forHTTPHeaderField: "token");
    
        let bodyData = "bId="+bId+"&sId="+sId;
        
        print(bodyData);
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            var jsonResult: NSDictionary!
            var postResult = "";
       //     var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            if (data != nil){
                do {
                    try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
                }
                catch {
                    
                }
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                postResult = parser.parseServiceResult(jsonResult) as String;
            }
            
            completionHandler(result: postResult);
        }
    }
    
    
    func postInterests (completionHandler:(result:NSString)->Void) -> () {
        
        let url: String = "https://buyoriginal.herokuapp.com/services/v1/users/interests"
        // let url: String = "http://localhost:5000/services/v1/users/interests"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        request.addValue(GlobalConstants.serverToken, forHTTPHeaderField: "token");
        
        let defaults = NSUserDefaults.standardUserDefaults();
        let array = defaults.objectForKey("userInterestsArray") as? [NSDictionary] ?? [NSDictionary]()
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(array, options:[])
            let str = String(data: data, encoding: NSUTF8StringEncoding)
            let bodyData = "interests="+str!;
            print("bodyData \(bodyData)");
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        } catch {
            
        }
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            var jsonResult: NSArray!
            var postResult = "";
            
            if (data != nil){
                do {
                    try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSArray
                }
                catch {
                    
                }
                
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                postResult = parser.parsePost(jsonResult) as String;
            }
            
            completionHandler(result: postResult);
        }
    }
    
    func postAnalytics (msg:[NSDictionary],completionHandler:(result:NSString)->Void) -> () {
        
         let url: String = "https://buyoriginal.herokuapp.com/services/v1/users/analytics"
        //let url: String = "http://192.168.2.12:5000/services/v1/users/analytics"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        request.addValue(GlobalConstants.serverToken, forHTTPHeaderField: "token");
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(msg, options:[])
            let str = String(data: data, encoding: NSUTF8StringEncoding)
            let bodyData = "analytics="+str!;
            print("bodyData \(bodyData)");
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        } catch {
            
        }
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            var jsonResult: NSArray!
            var postResult = "";
            
            if (data != nil){
                do {
                    try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSArray
                }
                catch {
                    
                }
                
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                postResult = parser.parsePost(jsonResult) as String;
            }
            
            completionHandler(result: postResult);
        }
    }
    
    
    
    
    
    
    
    func registerDevice (completionHandler:(result:NSString)->Void) -> () {
        
        let url: String = "https://buyoriginal.herokuapp.com/services/v1/users/register"
        // let url: String = "http://localhost:5000/services/v1/users/register"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        request.addValue(GlobalConstants.serverToken, forHTTPHeaderField: "token");
        
        let defaults = NSUserDefaults.standardUserDefaults();
        let deviceToken = defaults.objectForKey("deviceToken") as? NSString
        let currentCity = defaults.objectForKey("currentCity") as? NSString
       
        if ((deviceToken != nil) && (currentCity != nil )){
            let bodyData = "device="+(deviceToken as! String)+"&city="+(currentCity as! String);
            print(bodyData);
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
                
                response, data, error in
                
                var jsonResult: NSArray!
                var postResult = "";
                
                if (data != nil){
                    do {
                        try jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSArray
                    }
                    catch {
                        
                    }
                    
                }
                if (jsonResult != nil) {
                    
                    let parser = ResponseParser()
                    postResult = parser.parsePost(jsonResult) as String;
                }
                
                completionHandler(result: postResult);
            }
            
        }
        
        
    }
    
    
}
