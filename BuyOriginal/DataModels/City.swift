//
//  City.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-06-23.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation
import CoreLocation

class CityModel: NSObject {
    var cityName: String!
    var cityNameFa: String!
    var areaCode: String!
    var imageName:String!
    var centerLocation: CLLocationCoordinate2D!
    
    override init() {
        super.init();
    }
    
    override var description: String {
        return "cityName: \(cityName), cityNameFa: \(cityNameFa), areaCode: \(areaCode), imageName: \(imageName) \n"
    }
    
    init(cityName: String?, areaCode: String?, cityNameFa: String?, imageName: String?, centerLoc: CLLocationCoordinate2D?) {
        self.cityName = cityName ?? ""
        self.cityNameFa = cityNameFa ?? ""
        self.areaCode = areaCode ?? ""
        self.imageName = imageName ?? ""
        self.centerLocation = centerLoc
        super.init();
    }
    
    static func getCityConstantValue(name: String) -> GlobalConstants.CITIES {
        
        if (name == "Tehran"){
            return GlobalConstants.CITIES.Tehran
        }
        else if (name == "Isfahan"){
            return GlobalConstants.CITIES.Isfahan
        }
        else if (name == "Kish"){
            return GlobalConstants.CITIES.Kish
        }
        else if (name == "Shiraz"){
            return GlobalConstants.CITIES.Shiraz
        }
        else if (name == "Mashhad"){
            return GlobalConstants.CITIES.Mashhad
        }
        else if (name == "Tabriz"){
            return GlobalConstants.CITIES.Tabriz
        }
        else if (name == "Karaj"){
            return GlobalConstants.CITIES.Karaj
        }
        else {
            return GlobalConstants.CITIES.None
        }
    }
}