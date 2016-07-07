//
//  Utilities.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-08-12.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation
import SystemConfiguration

public class Utilities {
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.Reachable)
        let needsConnection = flags.contains(.ConnectionRequired)
        return (isReachable && !needsConnection)
    }
    
    class func url(type:GlobalConstants.SERVICE_TYPE) -> String {
        
        var urlStr = "";
        
        switch GlobalConstants.ENV {
        case GlobalConstants.ENV_TYPE.DEV:
            urlStr = GlobalConstants.BASE_URL_DEV
        case GlobalConstants.ENV_TYPE.LOCAL:
            urlStr = GlobalConstants.BASE_URL_LOCAL
        default:
            urlStr = GlobalConstants.BASE_URL_PROD
        }
        
        switch type {
            case GlobalConstants.SERVICE_TYPE.UPDATE_AVAILABLE:
                urlStr = urlStr + GlobalConstants.RELETIVE_URL_UPDATE_AVAILABLE
            case GlobalConstants.SERVICE_TYPE.ADV_FULLSCREEN:
                urlStr = GlobalConstants.BASE_URL_ADVERTISEMENT + GlobalConstants.RELETIVE_URL_ADV_FULL
            case GlobalConstants.SERVICE_TYPE.ADV_BANNER:
                urlStr = GlobalConstants.BASE_URL_ADVERTISEMENT + GlobalConstants.RELETIVE_URL_ADV_BANNER
        }
        
        
        return urlStr;
    }
    
    class func serverToken() -> String {
        
        switch GlobalConstants.ENV {
        case GlobalConstants.ENV_TYPE.DEV:
            return GlobalConstants.serverToken_DEV
        case GlobalConstants.ENV_TYPE.LOCAL:
            return GlobalConstants.serverToken_DEV
        default:
            return GlobalConstants.serverToken_PROD
        }
    
    }
    
    
    
}
