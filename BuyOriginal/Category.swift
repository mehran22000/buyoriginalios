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
            return "sports";
        }
        else if (cNameFa=="پوشاک"){
            return "clothes";
        }
        else if (cNameFa=="آرایش و زیبایی"){
            return "beauity";
        }
        else if (cNameFa=="کفش"){
            return "shoes";
        }
        else if (cNameFa=="ساعت"){
            return "watch";
        }
        else if (cNameFa=="پوشاک آقایان"){
            return "menCloths";
        }
        else if (cNameFa=="لوازم و پوشاک کودک"){
            return "baby";
        }
        else if (cNameFa=="پوشاک بانوان"){
            return "womenCloths";
        }
        else if (cNameFa=="موبایل"){
            return "mobile";
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