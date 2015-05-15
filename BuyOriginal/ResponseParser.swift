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
            let id = elem["id"] as! String
            let name = elem["name"] as! String
            let category = elem["category"] as! String
            let storesNo = elem["storesNo"] as! String
            let nearestLocation = elem["nearestLocation"] as! String
            let logo = elem["logo"] as! String
            println("Id: \(id)", "Name: \(name), Category: \(category)", "StoresNo: \(storesNo)", "nearestLocation: \(nearestLocation)")
            let b = BrandModel(brandId: id, name: name, category: category, storesNo: storesNo, nearestLocation: nearestLocation, logo:logo);
            array+=[b]
            
        }
        
        return array;
    }

    
    func parseStoresJson(brandId: NSString?, json: NSString?) -> [StoreModel] {
        
        var array = [StoreModel]()
        
        for elem: AnyObject in JSONParseArray(json! as String) {
            let id = elem["brandId"] as! String
            let name = elem["name"] as! String
            let address = elem["address"] as! String
            let phoneNumber = elem["phoneNumber"] as! String
            
            if id == brandId {
                println("Id: \(id)", "Name: \(name), address: \(address)", "phoneNumber: \(phoneNumber)")
                let b = StoreModel(brandId: id, name: name, storeLocation:address, phoneNumber:phoneNumber);
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