//
//  BOHttpPost.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-24.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BOHttpPost: NSObject {
   
    func addBusiness (account:AccountModel, completionHandler:(result:NSString)->Void) -> () {
        
        var url: String = "https://buyoriginal.herokuapp.com/users/business/adduser"
     //   var url: String = "http://localhost:5000/users/business/adduser"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
    
        var bodyData = "buEmail="+(account.uEmail as String)+"&buPassword="+(account.uPassword as String)+"&buCityName="+(account.sCity.cityName as String)+"&buCityNameFa="+(account.sCity.cityNameFa as String)+"&buBrandId="+(account.brand.bId as String)+"&buBrandName="+(account.brand.bName as String)+"&buBrandCategory="+(account.brand.bCategory as String)+"&buStoreName="+(account.store.sName as String)+"&buStoreAddress="+(account.store.sAddress as String)+"&buStoreHours="+(account.store.sHours as String)+"&buDistributor="+(account.store.bDistributor as String)+"&buStoreLat="+(account.store.sLat as String)+"&buStoreLon="+(account.store.sLong as String)+"&buAreaCode="+(account.sCity.areaCode as String)+"&buTel="+(account.store.sTel1 as String)+"&buBrandLogoName="+(account.brand.bLogo as String);
        
        println(bodyData);
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            var jsonResult: NSArray!
            var postResult = "";
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            if (data != nil){
                jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as! NSArray
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                postResult = parser.parsePost(jsonResult) as String;
            }
            
            completionHandler(result: postResult);
        }
    }
    
    
    func addDiscount (account:AccountModel, discount:DiscountModel, completionHandler:(result:NSString)->Void) -> () {
        
         var url: String = "https://buyoriginal.herokuapp.com/stores/adddiscount"
        //  var url: String = "http://localhost:5000/stores/adddiscount"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        
        if (discount.note.isEmpty==true){
            discount.note = "";
        }
        if (discount.precentage.isEmpty==true){
            discount.precentage = "0";
        }
        
        var bodyData = "bId="+(account.store.bId as String)+"&sId="+(account.store.sId as String)+"&startDate="+(discount.startDateStr as String)+"&endDate="+(discount.endDateStr as String)+"&startDateFa="+(discount.startDateStrFa as String)+"&endDateFa="+(discount.endDateStrFa as String)+"&precentage="+(discount.precentage as String)+"&note="+(discount.note as String);
        
        println(bodyData);
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            var jsonResult: NSArray!
            var postResult = "";
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            if (data != nil){
                jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as! NSArray
            }
            if (jsonResult != nil) {
                
                let parser = ResponseParser()
                postResult = parser.parsePost(jsonResult) as String;
            }
            
            completionHandler(result: postResult);
        }
    }
    
    
    
    
}
