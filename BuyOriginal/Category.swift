//
//  Category.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-08-12.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation

class CategoryModel: NSObject, Printable {
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
    
    func getIconName(cNameFa: String?) -> String?{
        
        if (cNameFa=="پوشاک ورزشی"){
            return "Sports";
        }
        else if (cNameFa=="پوشاک"){
            return "Clothes";
        }
        else if (cNameFa=="آرایش و زیبایی"){
            return "Beauity";
        }
        else if (cNameFa=="کفش"){
            return "Shoes";
        }
        else if (cNameFa=="ساعت"){
            return "Watch";
        }
        else {
            return nil;
        }
    }
}