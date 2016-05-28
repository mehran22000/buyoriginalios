//
//  GlobalConstants.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation

struct GlobalConstants {
    
    static let CITIES_SCREEN_MODE_SEARCH = 1;
    static let CITIES_SCREEN_MODE_SIGNUP = 2;
    static let CITIES_SCREEN_MODE_CHANGE = 3;
    
    static let BRANDS_SCREEN_MODE_SEARCH = 1;
    static let BRANDS_SCREEN_MODE_SIGNUP = 2;
    static let BRANDS_SCREEN_MODE_CHANGE = 3;
    
    static let REGISTER_BUSINESS_INVALID_EMAIL = 1;
    static let REGISTER_BUSINESS_INVALID_PASSWORD = 2;
    static let REGISTER_BUSINESS_INVALID_STORE_NAME = 3;
    static let REGISTER_BUSINESS_INVALID_STORE_ADDRESS = 4;
    static let REGISTER_BUSINESS_INVALID_STORE_HOURS = 5;
    static let REGISTER_BUSINESS_INVALID_STORE_HOURS_FORMAT = 6;
    static let REGISTER_BUSINESS_INVALID_AREACODE = 7;
    static let REGISTER_BUSINESS_INVALID_PHONE = 8;
    static let DISCOUNT_ADD_INCOMPLETE_DATE = 9;
    static let DISCOUNT_ADD_DISCOUNT_DETAILS_REQUIRED = 10;
    static let DISCOUNT_ADD_INVALID_DATE = 11;
    
    static let CATEGORIES_SCREEN_MODE_SEARCH = 1;
    static let CATEGORIES_SCREEN_MODE_SIGNUP = 2;
    
    static let PROFILE_NEWPASSWORD_INVALID_OLDPASSWORD = 1;
    static let PROFILE_NEWPASSWORD_NOMATCH = 2;
    
    static let BUSINESS_PHONE_SCREEN_MODE_SIGNUP = 1;
    static let BUSINESS_PHONE_SCREEN_MODE_CHANGE = 2;
    
    static let STORES_SCREEN_MODE_SEARCH = 1;
    static let STORES_SCREEN_MODE_DISCOUNT = 2;
    
    enum CITIES {
        case Tehran
        case Isfahan
        case Kish
        case Shiraz
        case Mashhad
        case Tabriz
        case Karaj
        case None
    }
    
    
    // Security Token
    static let serverToken_PROD = "YnV5b3JpZ2luYWxicmFuZHNieWFzbGJla2hhcg=="
    static let serverToken_DEV = "YnV5b3JpZ2luYWxicmFuZHNieWFzbGJla2hhcg=="
    
    // Network URL
    
    enum ENV_TYPE {
        case PROD
        case DEV
        case LOCAL
    }
    static let ENV = ENV_TYPE.PROD
    
    enum SERVICE_TYPE {
        case UPDATE_AVAILABLE
    }
    
    
    static let BASE_URL_PROD = "https://buyoriginal.herokuapp.com/services/v1/"
    static let BASE_URL_DEV = "https://buyoriginal.herokuapp.com/services/v1/dev/"
    static let BASE_URL_LOCAL = "http://localhost:5000/services/v1/dev/"
    
    static let RELETIVE_URL_UPDATE_AVAILABLE = "appInfo/version/iOS"
    
    
    static let ASLBEKHAR_STORE_ID = 1001305181 //Change this one to your ID
    
    static let iOS7AppStoreURLFormat = "itms-apps://itunes.apple.com/app/id%d";
    static let iOSAppStoreURLFormat = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d"

    
}
