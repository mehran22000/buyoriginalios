//
//  NSDate+Persian.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-08-02.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation

extension NSDate
{
    func convertPersianDate(dateStr:String)->NSDate {
        let df  = NSDateFormatter()
        df.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierPersian)!
        df.dateStyle = NSDateFormatterStyle.MediumStyle;
        df.dateFormat = "yyyy/MM/dd"
        let date = df.dateFromString(dateStr);
        print(date);
        return date!;
    }
    
    func dateToString()-> String {
        let df  = NSDateFormatter()
        df.dateFormat = "yyyy/MM/dd";
        let result = df.stringFromDate(self);
        return result;
        
    }
    
}
