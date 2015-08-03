//
//  Store.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-12.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation

class StoreModel: NSObject, Printable {
    var bId: String!
    var bName: String!
    var sId: String!
    var sName: String!
    var sAddress: String!
    var sTel1: String!
    var sTel2: String!
    var sDiscount: Int!
    var sDistance: String!
    var bCategory: String!
    var bLogo: String!
    var sLat: String!
    var sLong: String!
    var sVerified: String!
    var sHours: String!
    var sAreaCode: String!
    var bDistributor: String!
    var bLogoImage: UIImage!
    
    
    override var description: String {
        return "bId: \(bId), bName: \(bName),sId: \(sId), sName: \(sName), sAddress: \(sAddress), sTel1: \(sTel1), sTel2: \(sTel2), sDiscount: \(sDiscount), sDistance: \(sDistance), bCategory: \(bCategory), bLogo: \(bLogo), sLat: \(sLat), sLong: \(sLong),sVerified: \(sVerified), bDistributor: \(bDistributor) \n"
    }
    
    override init() {
        super.init();
    }
    
    
    init(bId: String?, bName: String?, sId: String?, sName: String?, sAddress: String?, sTel1: String?, sTel2: String?, sDiscount: Int!, sDistance: String?, bCategory: String?, bLogo: String?, sLat: String?, sLong: String?, sVerified: String?, sAreaCode:String?, sHours:String?, bDistributor:String?) {
        self.bId = bId ?? ""
        self.bName = bName ?? ""
        self.sId = sId ?? ""
        self.sName = sName ?? ""
        self.sAddress = sAddress ?? ""
        self.sTel1 = sTel1 ?? ""
        self.sTel2 = sTel2 ?? ""
        if (sDiscount==nil){
            self.sDiscount = 0;
        }
        else {
            self.sDiscount=sDiscount;
        }
        self.sDistance = sDistance ?? ""
        self.bCategory = bCategory ?? ""
        self.bLogo = bLogo ?? ""
        self.sLat = sLat ?? ""
        self.sLong = sLong ?? ""
        self.sVerified = sVerified ?? ""
        self.sHours = sHours ?? ""
        self.sAreaCode = sAreaCode ?? ""
        self.bLogoImage = UIImage();
        self.bDistributor = bDistributor ?? ""
        
        super.init();
        
        println("store:"+self.description);
        
    }
}