//
//  Store.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-12.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation

class StoreModel: NSObject, Printable {
    let bId: String
    let bName: String
    let sId: String
    let sName: String
    let sAddress: String
    let sTel1: String
    let sTel2: String
    let sDiscount: String
    let sDistance: String
    let bCategory: String
    let bLogo: String
    let sLat: String
    let sLong: String
    let sVerified: String
    let sHours: String
    let sAreaCode: String
    var bLogoImage: UIImage

    
    override var description: String {
        return "bId: \(bId), bName: \(bName),sId: \(sId), sName: \(sName), sAddress: \(sAddress), sTel1: \(sTel1), sTel2: \(sTel2), sDiscount: \(sDiscount), sDistance: \(sDistance), bCategory: \(bCategory), bLogo: \(bLogo), sLat: \(sLat), sLong: \(sLong),sVerified: \(sVerified), \n"
    }
    
    init(bId: String?, bName: String?, sId: String?, sName: String?, sAddress: String?, sTel1: String?, sTel2: String?, sDiscount: String?, sDistance: String?, bCategory: String?, bLogo: String?, sLat: String?, sLong: String?, sVerified: String?, sAreaCode:String?, sHours:String?) {
        self.bId = bId ?? ""
        self.bName = bName ?? ""
        self.sId = sId ?? ""
        self.sName = sName ?? ""
        self.sAddress = sAddress ?? ""
        self.sTel1 = sTel1 ?? ""
        self.sTel2 = sTel2 ?? ""
        self.sDiscount = sDiscount ?? ""
        self.sDistance = sDistance ?? ""
        self.bCategory = bCategory ?? ""
        self.bLogo = bLogo ?? ""
        self.sLat = sLat ?? ""
        self.sLong = sLong ?? ""
        self.sVerified = sVerified ?? ""
        self.sHours = sHours ?? ""
        self.sAreaCode = sAreaCode ?? ""
        self.bLogoImage = UIImage();
        
        super.init();
        
        println("store:"+self.description);
        
    }
}