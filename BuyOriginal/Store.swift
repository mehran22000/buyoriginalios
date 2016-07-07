//
//  Store.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-12.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation

class StoreModel: NSObject{
    var bId: String!
    var bName: String!
    var sId: String!
    var sName: String!
    var sAddress: String!
    var sTel1: String!
    var sTel2: String!
    var sDistance: String!
    var bCategory: String!
    var bCategoryId: String!
    var bLogo: String!
    var sLat: String!
    var sLong: String!
    var sVerified: String!
    var sHours: String!
    var sAreaCode: String!
    var bDistributor: String!
    var bLogoImage: UIImage!
    var sDiscountStartDateFa: String!
    var sDiscountEndDateFa: String!
    var sDiscountStartDate: String!
    var sDiscountEndDate: String!
    var sDiscountNote: String!
    var sDiscountPercentage: Int!
    
    
    override var description: String {
        return "bId: \(bId), bName: \(bName),sId: \(sId), sName: \(sName), sAddress: \(sAddress), sTel1: \(sTel1), sTel2: \(sTel2), sDistance: \(sDistance), bCategory: \(bCategory), bCategoryId: \(bCategoryId),bLogo: \(bLogo), sLat: \(sLat), sLong: \(sLong),sVerified: \(sVerified), bDistributor: \(bDistributor), sDiscountStartDateFa: \(sDiscountStartDateFa),sDiscountStartDate: \(sDiscountStartDate), sDiscountEndDateFa: \(sDiscountEndDateFa), sDiscountEndDate: \(sDiscountEndDate), sDiscountNote: \(sDiscountNote), sDiscountPrecentage: \(sDiscountPercentage) \n"
    }
    
    override init() {
        super.init();
    }
    
    
    func hasDiscount()-> Bool {
        if (sDiscountNote.isEmpty){
            return true;
        }
        else if (sDiscountPercentage>0){
            return true;
        }
        else{
            return false;
        }
    }
    
    init(bId: String?, bName: String?, sId: String?, sName: String?, sAddress: String?, sTel1: String?, sTel2: String?, sDistance: String?, bCategory: String?, bCategoryId: String?, bLogo: String?, sLat: String?, sLong: String?, sVerified: String?, sAreaCode:String?, sHours:String?, bDistributor:String?, sDiscountStartDateFa: String!, sDiscountStartDate: String!, sDiscountEndDateFa: String!, sDiscountEndDate: String!,sDiscountNote: String!, sDiscountPercentage: Int!) {
        self.bId = bId ?? ""
        self.bName = bName ?? ""
        self.sId = sId ?? ""
        self.sName = sName ?? ""
        self.sAddress = sAddress ?? ""
        self.sTel1 = sTel1 ?? ""
        self.sTel2 = sTel2 ?? ""
        self.sDistance = sDistance ?? ""
        self.bCategory = bCategory ?? ""
        self.bCategoryId = bCategoryId ?? ""
        self.bLogo = bLogo ?? ""
        self.sLat = sLat ?? ""
        self.sLong = sLong ?? ""
        self.sVerified = sVerified ?? ""
        self.sHours = sHours ?? ""
        self.sAreaCode = sAreaCode ?? ""
        self.bLogoImage = UIImage();
        self.bDistributor = bDistributor ?? ""
        self.sDiscountStartDate=sDiscountStartDate ?? ""
        self.sDiscountStartDateFa=sDiscountStartDateFa ?? ""
        self.sDiscountEndDateFa=sDiscountEndDateFa ?? ""
        self.sDiscountEndDate=sDiscountEndDate ?? ""
        self.sDiscountEndDateFa=sDiscountEndDateFa ?? ""
        self.sDiscountNote=sDiscountNote ?? ""
        self.sDiscountPercentage = sDiscountPercentage ?? -1
    
        
        super.init();
        
     //   println("store:"+self.description);
        
    }
}