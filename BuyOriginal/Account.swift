//
//  Account.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-20.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation

class AccountModel: NSObject {
    
    var uEmail: String!
    var uPassword: String!
    var sCity: CityModel!
    var brand: BrandModel!
    var store: StoreModel!
    var discount: DiscountModel!
    
    
    override init() {
        self.brand = BrandModel();
        self.store = StoreModel();
        self.sCity = CityModel();
        self.discount=DiscountModel();
        super.init();
    }
    
    
    
    override var description: String {
        return "uEmail: \(uEmail),uPassword: \(uPassword), sCity: \(sCity.cityName), sAreaCode: \(store.sAreaCode), bId: \(brand.bId), bName: \(brand.bName), sName: \(store.sName), sAddress: \(store.sAddress), sHours: \(store.sHours), bDistributor: \(store.bDistributor), sLat:\(store.sLat), sLon:\(store.sLong), sTel:\(store.sTel1)";
    }
   
}
