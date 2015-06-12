//
//  Brand.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-08.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation


class BrandModel: NSObject, Printable {
    let bId: String
    let bName: String
    let bCategory: String
    let sNumbers: String
    let sNearestLocation: String
    let bLogo: String
    
    override var description: String {
        return "bId: \(bId), bName: \(bName), bCategory: \(bCategory), sNumbers: \(sNumbers), sNearestLocation: \(sNearestLocation), bLogo: \(bLogo) \n"
    }
    
    init(bId: String?, bName: String?, bCategory: String?, sNumbers: String?, sNearestLocation: String?, bLogo: String?) {
        self.bId = bId ?? ""
        self.bName = bName ?? ""
        self.bCategory = bCategory ?? ""
        self.sNumbers = sNumbers ?? ""
        self.sNearestLocation = sNearestLocation ?? ""
        self.bLogo = bLogo ?? ""
        
        super.init();
        
    }
}