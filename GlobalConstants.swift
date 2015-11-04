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
    
}
