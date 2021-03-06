//
//  ResponseParser.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import Foundation
class ResponseParser: NSObject {
    
    override init() {
    }
    
    /*
    func parseBrandJson(json: NSString?) -> [BrandModel] {
        
        var array = [BrandModel]()
        
        for elem: AnyObject in JSONParseArray(json! as String) {
            let bId = elem["bId"] as? String
            let bName = elem["bName"] as? String
            let bCategory = elem["bCategory"] as? String
            let sNumbers = elem["sNumbers"] as? String
            let sNearestLocation = elem["sNearestLocation"] as? String
            let bLogo = elem["bLogo"] as? String
        //    print("bId: \(bId)", "bName: \(bName)", "bCategory: \(bCategory)", "sNumbers: \(sNumbers)", "sNearestLocation: \(sNearestLocation)")
            let b = BrandModel(bId: bId, bName: bName, bCategory: bCategory, sNumbers: sNumbers, sNearestLocation: sNearestLocation, bLogo:bLogo);
            array+=[b]
            
        }
        
        return array;
    }
    */
    
    func parseBrandVerificationArray(array: NSArray) -> [VerificationModel] {
        
        var verificationArray = [VerificationModel]()
        
        for elem: AnyObject in array {
            
            let bId = elem["bId"] as? String
            let vId = elem["vId"] as? String
            let shortDesc = elem["shortDesc"] as? String
            let longDesc = elem["longDesc"] as? String
            let smallImage = elem["smallImage"] as? String
            let largeImage = elem["largeImage"] as? String
            let title = elem["title"] as? String
            let v = VerificationModel(bId: bId, vId: vId, shortDesc: shortDesc, longDesc: longDesc, smallImage:smallImage,largeImage:largeImage, title:title );
            verificationArray+=[v]
            
        }
        
        return verificationArray;
    }
    
    
    
    func parseAppInfo(dic: NSDictionary) -> AppInfoModel? {
        
        var appInfo:AppInfoModel?
        let currentVersion = dic["current"] as? String
        let lastValidVersion = dic["minSupport"] as? String
        if (((currentVersion) != nil) && ((lastValidVersion) != nil)){
            appInfo = AppInfoModel(_currentVersion: currentVersion,_lastValidVersion:lastValidVersion);
        }
        
        
        return appInfo;
    }
    
    
    
    
    
    func parseBrandArray(array:NSArray) -> [BrandModel] {
        
        var brands = [BrandModel]()
        
        for elem: AnyObject in array {
            let bId = elem["bId"] as? String
            let bName = elem["bName"] as? String
            let cName = elem["cName"] as? String
            let bLogo = elem["bLogo"] as? String
         //   print("bId: \(bId)", "bName: \(bName)", "cName: \(cName)", "bLogo: \(bLogo)")
            let b = BrandModel(bId: bId, bName: bName, bCategory: cName, bCategoryId: "", sNumbers: "", sNearestLocation: "", bLogo:bLogo);
            brands+=[b]
        }
        return brands;
    }
    
    /*
    
    func parseStoreArray(array:NSArray) -> [StoreModel] {
        
        var stores = [StoreModel]()
        
        for elem: AnyObject in array {
            let bId = elem["bId"] as? String
            let bName = elem["bName"] as? String
            let sId = elem["sId"] as? String
            let sName = elem["sName"] as? String
            let cName = elem["cName"] as? String
            let bLogo = bName?.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).lowercaseString
            let sHours = elem["sHours"] as? String
            let sAddress = elem["sAddress"] as? String
            let sLat = elem["sLat"] as? String
            let sLong = elem["sLong"] as? String
            let sTel1 = elem["sTel1"] as? String
            let sTel2 = elem["sTel2"] as? String
            let sDistance = elem["distance"] as? String
            let sVerified = elem["sVerified"] as? String
            let bCategory = elem["bCategory"] as? String
            let sDiscount = elem["sDiscount"] as? String
            let sAreaCode = elem["sAreaCode"] as? String
            
            let s = StoreModel(bId: bId, bName: bName, sId:sId, sName:sName, sAddress: sAddress, sTel1:sTel1, sTel2:sTel2, sDiscount: sDiscount, sDistance: sDistance, bCategory:bCategory, bLogo:bLogo, sLat:sLat, sLong:sLong, sVerified:sVerified, sAreaCode:sAreaCode,sHours:sHours);
            
            stores+=[s]
        }
        return stores;
    }
    */
    
    func parseStoreArray(array:NSArray) -> NSDictionary {
        
        var stores = [StoreModel]()
        var brands = [BrandModel]()
        var categoryBrands = [String:[BrandModel]]();
        var brandStores = [String:[StoreModel]]();
       // var catCounter = 0;
        var brandCounter = 0;
        let cat=CategoryModel();
     
        
        for elem: AnyObject in array {
            let bId = elem["bId"] as? String
            let bName = elem["bName"] as? String
            let sId = elem["sId"] as? String
            let sName = elem["sName"] as? String
            // let cName = elem["cName"] as? String
            let bLogo = bName?.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).lowercaseString
            let sHours = elem["sHours"] as? String
            let sAddress = elem["sAddress"] as? String
            let sLat = elem["sLat"] as? String
            let sLong = elem["sLong"] as? String
            let sTel1 = elem["sTel1"] as? String
            let sTel2 = elem["sTel2"] as? String
            let sDistance = elem["distance"] as? String
            
            let sVerified = elem["sVerified"] as? String
            
            let bCategory = elem["bCategory"] as? String
            let sDiscountStartDateFa = elem["dStartDateFa"] as? String
            let sDiscountEndDateFa = elem["dEndDateFa"] as? String
            let sDiscountStartDate = elem["dStartDate"] as? String
            let sDiscountEndDate = elem["dEndDate"] as? String
            let sDiscountNote = elem["dNote"] as? String
            let sDiscountPercentage = elem["dPrecentage"] as? Int
            
            let catName = cat.getCatEnName(bCategory);
            let bCategoryId = elem["bCategoryId"] as? String;
            
            let sAreaCode = elem["sAreaCode"] as? String
            let bDistributor = elem["bDistributor"] as? String
            
            let s = StoreModel(bId: bId, bName: bName, sId:sId, sName:sName, sAddress: sAddress, sTel1:sTel1, sTel2:sTel2, sDistance: sDistance, bCategory:bCategory, bCategoryId:bCategoryId, bLogo:bLogo, sLat:sLat, sLong:sLong, sVerified:sVerified, sAreaCode:sAreaCode,sHours:sHours, bDistributor:bDistributor, sDiscountStartDateFa:sDiscountStartDateFa, sDiscountStartDate:sDiscountStartDate,sDiscountEndDateFa:sDiscountEndDateFa,sDiscountEndDate:sDiscountEndDate,sDiscountNote:sDiscountNote,sDiscountPercentage:sDiscountPercentage);
            stores+=[s]
            
            let b = BrandModel(bId: bId, bName: bName, bCategory: bCategory, bCategoryId:bCategoryId, sNumbers: "", sNearestLocation: "", bLogo: bLogo)
            
            var newBrand = true;
            for elem:BrandModel in brands{
                if (elem.bId==b.bId){
                    newBrand = false;
                }
            }
            
            if (newBrand) {
                brands+=[b]
            }
            
            
            if ((bCategory != nil) && (categoryBrands[bCategory!] == nil)) {
                var newCatBrands = [BrandModel]();
                newCatBrands=[b];
                categoryBrands[bCategory!]=newCatBrands;
            }
            else if (bCategory != nil){
                let exCatBrands = categoryBrands[bCategory!] as [BrandModel]?;
                var newBrand = true;
                var newCatBrands =  [BrandModel]();
                
                for elem:BrandModel in exCatBrands!{
                    newCatBrands+=[elem];
                    if (elem.bName==b.bName){
                        newBrand = false;
                    }
                }
                
                if (newBrand) {
                    newCatBrands+=[b];
                    categoryBrands.updateValue(newCatBrands, forKey: bCategory!);
                    brandCounter = brandCounter+1;
                }
            
            }
            
            /*
            for (cat, brandsArray) in categoryBrands {
                println("New Category:"+cat);
                for elem:BrandModel in brandsArray {
                    println(elem.bName);
                }
            }
            */
            
            // Brands - Stores
            let arrayIndex = catName! + bName!
            if (brandStores[arrayIndex] == nil) {
                var newBrandStores = [StoreModel]();
                newBrandStores=[s];
                brandStores[arrayIndex]=newBrandStores;
            }
            else {
                let exBrandStores = brandStores[arrayIndex] as [StoreModel]?;
                // var newStore = true;
                var newBrandStore =  [StoreModel]();
                
                for elem:StoreModel in exBrandStores!{
                    newBrandStore+=[elem];
                }
                newBrandStore+=[s];
                brandStores.updateValue(newBrandStore, forKey: arrayIndex);
                
            }
        
        }
    
        let sortedIndex = sortCategories(categoryBrands);
        
        let results:NSDictionary = ["brands":brands,"stores":stores, "catBrands":categoryBrands, "brandStores":brandStores, "sortedIndex":sortedIndex];
        
        
        return results;
    }
    
    
    func sortCategories (result: [String:[BrandModel]]) -> (NSArray) {
        
        var sortedIndex:[Int]=[];
        var catBrandNumber:[Int]=[];
        
        var allKeys = Array(result.keys);
        for var i=0; i < result.count; i++ {
            let key = allKeys[i] as String;
            catBrandNumber.append(result[key]!.count);
            sortedIndex.append(i);
        }
        
        for var i=0; i<catBrandNumber.count-1; i++ {
            for var j=i+1; j<catBrandNumber.count; j++ {
                if catBrandNumber[i] < catBrandNumber[j] {
                    var tempInt = catBrandNumber[i];
                    catBrandNumber[i] = catBrandNumber[j];
                    catBrandNumber[j] = tempInt;
                    
                    tempInt = sortedIndex[i];
                    sortedIndex[i] = sortedIndex[j];
                    sortedIndex[j] = tempInt;
                }
                
            }
        }
        return sortedIndex;
    }
    

    
    func parseLogin(array:NSArray) -> AccountModel? {
        
        let account =  AccountModel()
        
        for elem: AnyObject in array {
            
            let err = elem["err"] as? String;
            
            if (err == nil){
            
                account.uEmail = elem["buEmail"] as? String;
                account.uPassword = elem["buPassword"] as? String;
                account.uId = elem["buId"] as? String;
            
                // City Object
                let city = CityModel()
                city.cityName = elem["buCityName"] as? String;
                city.cityNameFa = elem["buCityNameFa"] as? String;
                city.areaCode = elem["buAreaCode"] as? String;
                account.sCity = city;
            
                // Brand Object
                let brand = BrandModel()
                brand.bId = elem["buBrandId"] as? String
                brand.bName = elem["buBrandName"] as? String
                brand.bCategory = elem["buBrandCategory"] as? String
                brand.bLogo = elem["buBrandLogoName"] as? String
                account.brand = brand;
            
                // Store Object
                let store = StoreModel()
                store.bId = elem["buBrandId"] as? String
                store.bName = elem["buBrandName"] as? String
                store.sId = elem["buStoreId"] as? String
                store.sName = elem ["buStoreName"] as? String
                store.sAddress = elem ["buStoreAddress"] as? String
                store.sTel1 = elem["buTel"] as? String
                store.bCategory = elem["buBrandCategory"] as? String
                store.bLogo = elem["buBrandLogo"] as? String
                store.sLat = elem["buStoreLat"] as? String
                store.sLong = elem["buStoreLon"] as? String
                store.sHours = elem["buStoreHours"] as? String
                store.sAreaCode = elem["buAreaCode"] as? String
                store.bDistributor = elem["buDistributor"] as? String
                account.store = store;
            
                // Discount Object
                let discount = DiscountModel()
                discount.startDateStr=elem["dStartDate"] as? String
                discount.endDateStr=elem["dEndDate"] as? String
                discount.startDateStrFa=elem["dStartDateFa"] as? String
                discount.endDateStrFa=elem["dEndDateFa"] as? String
                // ToDo: Change this to ?
                let dPrec:Double? = elem["dPrecentage"] as? Double;
                if (dPrec != nil) {
                    discount.precentage = String(format:"%.0f", dPrec!);
                }
                discount.note=elem["dNote"] as? String
                account.discount=discount;
            }
            else {
                return nil;
            }
        }
        
        return account;
    }
    
    

    func parsePost(array:NSArray) -> NSString {
        
        var result:String=""
        for elem: AnyObject in array {
            result = elem["result"] as! String;
        }
        
        return result;
    }
    
    
    func parseServiceResult(dic:NSDictionary) -> NSString {
        
        var result:String="";
        if ((dic["result"]) != nil){
            result = dic["result"] as! String;
        }
        else if ((dic["err"]) != nil){
            result = dic["err"] as! String;
        }
        return result;
    }
    
    
    func parseValidateEmail(dic:NSDictionary) -> NSString {
        
        var result:String="";
        if ((dic["duplicate"]) != nil){
            result = dic["duplicate"] as! String;
        }
        else if ((dic["err"]) != nil){
            result = dic["err"] as! String;
        }
        return result;
    }
    
    

    /*
    func parseStoresJson(_bId: NSString?, json: NSString?) -> [StoreModel] {
        
        var array = [StoreModel]()
        
        for elem: AnyObject in JSONParseArray(json! as String) {
            let sId = elem["sId"] as? String
            let bId = elem["bId"] as? String
            let sName = elem["sName"] as? String
            let bName = elem["bName"] as? String
            
            let sAddress = elem["sAddress"] as? String
            let sTel = elem["sTel"] as? String
            let sDiscount = elem["sDiscount"] as? String
            let sDistance = elem["sDistance"] as? String
            let bLogo = elem["bLogo"] as? String
            let bCategory = elem["bCategory"] as? String
            
            println("sId: \(sId)", "sName: \(sName)","bId: \(bId)", "bName: \(bName)", "sAddress: \(sAddress)", "sTel: \(sTel)")
            
             let b = StoreModel(bId: bId, bName: bName, sId: sId, sName: sName, sAddress: sAddress, sTel: sTel, sDiscount: sDiscount, sDistance: sDistance, bCategory: bCategory, bLogo: bLogo)
            
            if _bId == bId {
                array+=[b]
            }
            else if _bId=="" {
                array+=[b]
            }
        }
        
        return array;
    }
    */
    
    func JSONParseArray(jsonString: String) -> [AnyObject] {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let array = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0));
                if (array as? [AnyObject] != nil) {
                    return array as! [AnyObject]
                }
            }
            catch {
                
            }
        }
        return [AnyObject]()
    }
    
}