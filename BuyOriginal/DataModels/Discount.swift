//
//  Discount.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-08-03.
//  Copyright (c) 2015 MandM. All rights reserved.
//


import Foundation


class DiscountModel: NSObject {
    var startDateStr: String!
    var startDate: NSDate!
    var endDateStr: String!
    var endDate: NSDate!
    var startDateStrFa: String!
    var endDateStrFa: String!
    var precentage: String!
    var note: String!
    
    
    override var description: String {
        return "startDate: \(startDateStr), endDate: \(endDateStr), startDateFa: \(startDateStrFa), endDateFa: \(endDateStrFa), precentage: \(precentage), note: \(note) \n"
    }
    
    override init() {
        super.init();
        
    }
    
    
    init(startDateStrFa: String?, endDateStrFa: String?, precentage: String?, note: String?) {
        
        self.startDateStrFa = startDateStrFa;
        self.endDateStrFa = endDateStrFa;
        self.startDate = NSDate();
        self.endDate = NSDate();
        self.startDate = startDate.convertPersianDate(self.startDateStrFa);
        self.endDate = endDate.convertPersianDate(self.endDateStrFa);
        self.startDateStr = startDate.dateToString();
        self.endDateStr = endDate.dateToString();
        self.precentage = precentage;
        self.note = note;
        
        super.init();
    }
    
    
}