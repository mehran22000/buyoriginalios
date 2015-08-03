//
//  ResponseParser.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation
class ResponseParser: NSObject, Printable {
    
    override init() {
    }
    
    
    func parseBrandJson(json: NSString?) -> [BrandModel] {
        
        var array = [BrandModel]()
        
        for elem: AnyObject in JSONParseArray(json! as String) {
            let bId = elem["bId"] as? String
            let bName = elem["bName"] as? String
            let bCategory = elem["bCategory"] as? String
            let sNumbers = elem["sNumbers"] as? String
            let sNearestLocation = elem["sNearestLocation"] as? String
            let bLogo = elem["bLogo"] as! String
            println("bId: \(bId)", "bName: \(bName)", "bCategory: \(bCategory)", "sNumbers: \(sNumbers)", "sNearestLocation: \(sNearestLocation)")
            let b = BrandModel(bId: bId, bName: bName, bCategory: bCategory, sNumbers: sNumbers, sNearestLocation: sNearestLocation, bLogo:bLogo);
            array+=[b]
            
        }
        
        return array;
    }
    
    
    func parseBrandArray(array:NSArray) -> [BrandModel] {
        
        var brands = [BrandModel]()
        
        for elem: AnyObject in array {
            let bId = elem["bId"] as? String
            let bName = elem["bName"] as? String
            let cName = elem["cName"] as? String
            let bLogo = elem["bLogo"] as! String
            println("bId: \(bId)", "bName: \(bName)", "cName: \(cName)", "bLogo: \(bLogo)")
            let b = BrandModel(bId: bId, bName: bName, bCategory: cName, sNumbers: "", sNearestLocation: "", bLogo:bLogo);
            brands+=[b]
        }
        return brands;
    }
    
    /*
    
    func parseStoreArray(array:NSArray) -> [StoreModel] {
        
        var stores = [StoreModel]()
        
        for elem: AnyObject in array {
            let bId = elem["bId"] as? String
            let bName = elem["bName"] as? String
            let sId = elem["sId"] as? String
            let sName = elem["sName"] as? String
            let cName = elem["cName"] as? String
            let bLogo = bName?.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).lowercaseString
            let sHours = elem["sHours"] as? String
            let sAddress = elem["sAddress"] as? String
            let sLat = elem["sLat"] as? String
            let sLong = elem["sLong"] as? String
            let sTel1 = elem["sTel1"] as? String
            let sTel2 = elem["sTel2"] as? String
            let sDistance = elem["distance"] as? String
            let sVerified = elem["sVerified"] as? String
            let bCategory = elem["bCategory"] as? String
            let sDiscount = elem["sDiscount"] as? String
            let sAreaCode = elem["sAreaCode"] as? String
            
            let s = StoreModel(bId: bId, bName: bName, sId:sId, sName:sName, sAddress: sAddress, sTel1:sTel1, sTel2:sTel2, sDiscount: sDiscount, sDistance: sDistance, bCategory:bCategory, bLogo:bLogo, sLat:sLat, sLong:sLong, sVerified:sVerified, sAreaCode:sAreaCode,sHours:sHours);
            
            stores+=[s]
        }
        return stores;
    }
    */
    
    func parseStoreArray(array:NSArray) -> NSDictionary {
        
        var stores = [StoreModel]()
        var brands = [BrandModel]()
        
        for elem: AnyObject in array {
            let bId = elem["bId"] as? String
            let bName = elem["bName"] as? String
            let sId = elem["sId"] as? String
            let sName = elem["sName"] as? String
            let cName = elem["cName"] as? String
            let bLogo = bName?.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).lowercaseString
            let sHours = elem["sHours"] as? String
            let sAddress = elem["sAddress"] as? String
            let sLat = elem["sLat"] as? String
            let sLong = elem["sLong"] as? String
            let sTel1 = elem["sTel1"] as? String
            let sTel2 = elem["sTel2"] as? String
            let sDistance = elem["distance"] as? String
            let sVerified = elem["sVerified"] as? String
            let bCategory = elem["bCategory"] as? String
            let sDiscountStr = elem["dPrecentage"] as? String
            let sDiscount = sDiscountStr?.toInt()
            let sAreaCode = elem["sAreaCode"] as? String
            let bDistributor = elem["bDistributor"] as? String
            
            let s = StoreModel(bId: bId, bName: bName, sId:sId, sName:sName, sAddress: sAddress, sTel1:sTel1, sTel2:sTel2, sDiscount: sDiscount, sDistance: sDistance, bCategory:bCategory, bLogo:bLogo, sLat:sLat, sLong:sLong, sVerified:sVerified, sAreaCode:sAreaCode,sHours:sHours, bDistributor:bDistributor);
            stores+=[s]
            
            let b = BrandModel(bId: bId, bName: bName, bCategory: bCategory, sNumbers: "", sNearestLocation: "", bLogo: bLogo)
            
            var newBrand = true;
            for elem:BrandModel in brands{
                if (elem.bId==b.bId){
                    newBrand = false;
                }
            }
            
            if (newBrand) {
                brands+=[b]
            }
            
        }
        
        var results:NSDictionary = ["brands":brands,"stores":stores];
        
        return results;
    }
    
    
    func parseLogin(array:NSArray) -> AccountModel? {
        
        var account =  AccountModel()
        
        for elem: AnyObject in array {
            
            var err = elem["err"] as? String;
            
            if (err == nil){
            
                account.uEmail = elem["buEmail"] as? String;
                account.uPassword = elem["buPassword"] as? String;
            
                // City Object
                var city = CityModel()
                city.cityName = elem["buCityName"] as? String;
                city.cityNameFa = elem["buCityNameFa"] as? String;
                city.areaCode = elem["buAreaCode"] as? String;
                account.sCity = city;
            
                // Brand Object
                var brand = BrandModel()
                brand.bId = elem["buId"] as? String
                brand.bName = elem["buBrandName"] as? String
                brand.bCategory = elem["buBrandCategory"] as? String
                brand.bLogo = elem["buBrandLogoName"] as? String
                account.brand = brand;
            
                // Store Object
                var store = StoreModel()
                store.bId = elem["buBrandId"] as? String
                store.bName = elem["buBrandName"] as? String
                store.sId = elem["buStoreId"] as? String
                store.sName = elem ["buStoreName"] as? String
                store.sAddress = elem ["buStoreAddress"] as? String
                store.sTel1 = elem["buTel"] as? String
                store.bCategory = elem["buBrandCategory"] as? String
                store.bLogo = elem["buBrandLogo"] as? String
                store.sLat = elem["buStoreLat"] as? String
                store.sLong = elem["buStoreLon"] as? String
                store.sHours = elem["buStoreHours"] as? String
                store.sAreaCode = elem["buAreaCode"] as? String
                store.bDistributor = elem["buDistributor"] as? String
                account.store = store;
            
                // Discount Object
                var discount = DiscountModel()
                discount.startDateStr=elem["buDiscStartDate"] as? String
                discount.endDateStr=elem["buDiscEndDate"] as? String
                discount.startDateStrFa=elem["buDiscStartDateFa"] as? String
                discount.endDateStrFa=elem["buDiscEndDateFa"] as? String
                discount.precentage=elem["buDiscPrecentage"] as? String
                discount.note=elem["buDiscNote"] as? String
                account.discount=discount;
            }
            
        }
        
        return account;
    }
    
    

    func parsePost(array:NSArray) -> NSString {
        
        var result:String=""
        for elem: AnyObject in array {
            result = elem["result"] as! String;
        }
        
        return result;
    }
    
    

    /*
    func parseStoresJson(_bId: NSString?, json: NSString?) -> [StoreModel] {
        
        var array = [StoreModel]()
        
        for elem: AnyObject in JSONParseArray(json! as String) {
            let sId = elem["sId"] as? String
            let bId = elem["bId"] as? String
            let sName = elem["sName"] as? String
            let bName = elem["bName"] as? String
            
            let sAddress = elem["sAddress"] as? String
            let sTel = elem["sTel"] as? String
            let sDiscount = elem["sDiscount"] as? String
            let sDistance = elem["sDistance"] as? String
            let bLogo = elem["bLogo"] as? String
            let bCategory = elem["bCategory"] as? String
            
            println("sId: \(sId)", "sName: \(sName)","bId: \(bId)", "bName: \(bName)", "sAddress: \(sAddress)", "sTel: \(sTel)")
            
             let b = StoreModel(bId: bId, bName: bName, sId: sId, sName: sName, sAddress: sAddress, sTel: sTel, sDiscount: sDiscount, sDistance: sDistance, bCategory: bCategory, bLogo: bLogo)
            
            if _bId == bId {
                array+=[b]
            }
            else if _bId=="" {
                array+=[b]
            }
        }
        
        return array;
    }
    */
    
    func JSONParseArray(jsonString: String) -> [AnyObject] {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            if let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)  as? [AnyObject] {
                return array
            }
        }
        return [AnyObject]()
    }
    
}