//
//  City.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-06-23.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation

class CityModel: NSObject, Printable {
    var cityName: String!
    var cityNameFa: String!
    var areaCode: String!
    var imageName:String!
    
    override init() {
        super.init();
    }
    
    override var description: String {
        return "cityName: \(cityName), cityNameFa: \(cityNameFa), areaCode: \(areaCode), imageName: \(imageName) \n"
    }
    
    init(cityName: String?, areaCode: String?, cityNameFa: String?, imageName: String?) {
        self.cityName = cityName ?? ""
        self.cityNameFa = cityNameFa ?? ""
        self.areaCode = areaCode ?? ""
        self.imageName = imageName ?? ""
        super.init();
    }
}