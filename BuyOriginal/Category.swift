//
//  Category.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-08-12.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation

class CategoryModel: NSObject {
    var cId: String!
    var cName: String!
    var cNameFa: String!
   
    override var description: String {
        return "cId: \(cId), cName: \(cName), cNameFa: \(cNameFa) \n"
    }
    
    override init() {
        super.init();
    }
    
    
    init(cId: String?, cName: String?, cNameFa: String?) {
        self.cId = cId ?? ""
        self.cName = cName ?? ""
        self.cNameFa = cNameFa ?? ""
        super.init();
    }
    
    func getCatEnName(cNameFa: String?) -> String?{
        
        if (cNameFa=="پوشاک ورزشی"){
            return "sports_clothes";
        }
        else if (cNameFa=="پوشاک"){
            return "clothes";
        }
        else if (cNameFa=="آرایش و زیبایی"){
            return "beauty";
        }
        else if (cNameFa=="کفش"){
            return "shoes";
        }
        else if (cNameFa=="ساعت"){
            return "watches";
        }
        else if (cNameFa=="پوشاک آقایان"){
            return "men_clothes";
        }
        else if (cNameFa=="لوازم و پوشاک کودک"){
            return "baby_clothes";
        }
        else if (cNameFa=="پوشاک بانوان"){
            return "women_clothes";
        }
        else if (cNameFa=="موبایل"){
            return "cellphone";
        }
        else if (cNameFa=="چرم"){
            return "leather";
        }
        else if (cNameFa=="طلاوجواهر"){
            return "jewelry";
        }
        else if (cNameFa=="لباس عروس"){
            return "wedding";
        }
        else if (cNameFa=="عطر و ادکلن"){
            return "perfume";
        }
        else {
            return nil;
        }
    }
}