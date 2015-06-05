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
    let sTel: String
    let sDiscount: String
    let sDistance: String
    let bCategory: String
    let bLogo: String
    
    override var description: String {
        return "bId: \(bId), bName: \(bName),sId: \(sId), sName: \(sName), sAddress: \(sAddress), sTel: \(sTel), sDiscount: \(sDiscount), sDistance: \(sDistance), bCategory: \(bCategory), bLogo: \(bLogo) \n"
    }
    
    init(bId: String?, bName: String?, sId: String?, sName: String?, sAddress: String?, sTel: String?, sDiscount: String?, sDistance: String?, bCategory: String?, bLogo: String?) {
        self.bId = bId ?? ""
        self.bName = bName ?? ""
        self.sId = sId ?? ""
        self.sName = sName ?? ""
        self.sAddress = sAddress ?? ""
        self.sTel = sTel ?? ""
        self.sDiscount = sDiscount ?? ""
        self.sDistance = sDistance ?? ""
        self.bCategory = bCategory ?? ""
        self.bLogo = bLogo ?? ""
    }
}