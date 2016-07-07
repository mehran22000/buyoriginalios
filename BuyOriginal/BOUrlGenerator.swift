//
//  BOURLGenerator.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2016-06-28.
//  Copyright © 2016 MandM. All rights reserved.
//

import UIKit

class BOUrlGenerator: NSObject {
    
    class func urlReq(urlStr: String, serviceType:GlobalConstants.SERVICE_TYPE) -> NSMutableURLRequest {
        
        let nsurl = NSURL(string: urlStr);
        let req = NSMutableURLRequest(URL: nsurl!)
        
        // Commong properties
        req.timeoutInterval = 0.5
        
        // Service specific properties
        switch (serviceType){
            
        case GlobalConstants.SERVICE_TYPE.ADV_BANNER,GlobalConstants.SERVICE_TYPE.ADV_FULLSCREEN:
            req.HTTPMethod = "HEAD"
        default:
            break
        }
        
        return req;
    }

}
