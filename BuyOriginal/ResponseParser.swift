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

    
    func JSONParseArray(jsonString: String) -> [AnyObject] {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            if let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)  as? [AnyObject] {
                return array
            }
        }
        return [AnyObject]()
    }
    
}