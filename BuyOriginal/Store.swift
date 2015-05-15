//
//  Store.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-12.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation

class StoreModel: NSObject, Printable {
    let brandId: String
    let name: String
    let storeLocation: String
    let phoneNumber: String
    
    override var description: String {
        return "brandId: \(brandId), name: \(name), address: \(storeLocation), phoneNumber: \(phoneNumber)"
    }
    
    
    init(brandId: String?, name: String?, storeLocation: String?, phoneNumber: String?) {
        self.brandId = brandId ?? ""
        self.name = name ?? ""
        self.storeLocation = storeLocation ?? ""
        self.phoneNumber = phoneNumber ?? ""
    }
}