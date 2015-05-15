//
//  Brand.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-08.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation


class BrandModel: NSObject, Printable {
    let brandId: String
    let name: String
    let category: String
    let storesNo: String
    let nearestLocation: String
    let logo: String
    
    override var description: String {
        return "brandId: \(brandId), name: \(name), category: \(category), storesNo: \(storesNo) nearestLocation: \(nearestLocation), logo: \(logo)\n"
    }
    
    
    init(brandId: String?, name: String?, category: String?, storesNo: String?, nearestLocation: String?, logo: String?) {
        self.brandId = brandId ?? ""
        self.name = name ?? ""
        self.category = category ?? ""
        self.storesNo = storesNo ?? ""
        self.nearestLocation = nearestLocation ?? ""
        self.logo = logo ?? ""
    }
}