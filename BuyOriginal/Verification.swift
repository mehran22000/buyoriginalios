//
//  Verification.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2016-02-23.
//  Copyright © 2016 MandM. All rights reserved.
//

import Foundation

class VerificationModel: NSObject{
    var bId: String!
    var vId: String!
    var shortDesc: String!
    var longDesc: String!
    var smallImageName: String!
    var largeImageName: String!
    var smallImage: UIImage?
    var largeImage: UIImage?
    var title: String!
    
    
    override var description: String {
        return "bId: \(bId), vId: \(vId), shortDesc: \(shortDesc), longDesc: \(longDesc), title: \(title), smallImage: \(smallImage), largeImage: \(largeImage) \n"
    }
    
    override init() {
        super.init();
    }
    
    
    init(bId: String?, vId: String?, shortDesc: String?, longDesc: String?, smallImage: String?, largeImage: String?, title: String?) {
        self.bId = bId ?? ""
        self.vId = vId ?? ""
        self.shortDesc = shortDesc ?? ""
        self.longDesc = longDesc ?? ""
        self.smallImageName = smallImage ?? ""
        self.largeImageName = largeImage ?? ""
        self.smallImage = nil;
        self.largeImage = nil;
        self.title=title ?? ""
        super.init();
    }
}