//
//  Brand.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-08.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation


class BrandModel: NSObject{
    var bId: String!
    var bName: String!
    var bCategory: String!
    var sNumbers: String!
    var sNearestLocation: String!
    var bLogo: String!
    var bLogoImage: UIImage!
        
    override var description: String {
        return "bId: \(bId), bName: \(bName), bCategory: \(bCategory), sNumbers: \(sNumbers), sNearestLocation: \(sNearestLocation), bLogo: \(bLogo) \n"
    }
    
    override init() {
        super.init();
    }
    
    
    init(bId: String?, bName: String?, bCategory: String?, sNumbers: String?, sNearestLocation: String?, bLogo: String?) {
        self.bId = bId ?? ""
        self.bName = bName ?? ""
        self.bCategory = bCategory ?? ""
        self.sNumbers = sNumbers ?? ""
        self.sNearestLocation = sNearestLocation ?? ""
        self.bLogo = bLogo ?? ""
        self.bLogoImage = UIImage();
        super.init();
    }
}