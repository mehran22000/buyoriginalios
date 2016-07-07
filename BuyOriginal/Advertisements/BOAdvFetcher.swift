//
//  BOAdvFetcher.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2016-06-28.
//  Copyright © 2016 MandM. All rights reserved.
//

import UIKit

class BOAdvFetcher: NSObject {

    class func advExists(adName:String, type:GlobalConstants.ADV_TYPE, completion: (data: NSData?) -> Void) {
        
        let req: NSMutableURLRequest;
        var urlStr: String;
        switch (type) {
        case GlobalConstants.ADV_TYPE.BANNER:
            urlStr = Utilities.url(GlobalConstants.SERVICE_TYPE.ADV_BANNER)+adName;
            req = BOUrlGenerator.urlReq(urlStr, serviceType: GlobalConstants.SERVICE_TYPE.ADV_BANNER)
            print("Ad urlStr "+urlStr);
        case GlobalConstants.ADV_TYPE.FULL_SCREEN:
            urlStr = Utilities.url(GlobalConstants.SERVICE_TYPE.ADV_FULLSCREEN)+adName;
            req = BOUrlGenerator.urlReq(urlStr, serviceType: GlobalConstants.SERVICE_TYPE.ADV_FULLSCREEN)
            print("Ad urlStr "+urlStr);
        }
        
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
                if ((response as? NSHTTPURLResponse)?.statusCode ?? -1) == 200 {
                    print ("Ad Found!!! " + adName )
                    let nsurl = NSURL(string: urlStr);
                    if let imgData = NSData(contentsOfURL: nsurl!) {
                        completion(data: imgData);
                    }
                    
                }
                else {
                    print ("Ad not found " + adName);
                    completion(data:nil);
                }
        }
    }
}

