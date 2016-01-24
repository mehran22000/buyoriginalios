//
//  AppDelegate.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-04.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
// Google Analytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var manager:CLLocationManager!
    var myLocations: [CLLocation] = []
    var curLocationLat: Double!
    var curLocationLong: Double!
    // ToDo: Read current city from user settings
    var cities = [CityModel]();
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            manager.requestWhenInUseAuthorization()
        } else {
            // Fallback on earlier versions
        }
        manager.startUpdatingLocation()
        manager.delegate = self;
        
        // Google Analytics
        GAI.sharedInstance().trackUncaughtExceptions = true
        GAI.sharedInstance().dispatchInterval = 20
        GAI.sharedInstance().logger.logLevel = GAILogLevel.Verbose
        GAI.sharedInstance().trackerWithTrackingId("UA-64002918-1")
        
        
        // Flurry
        Flurry.setCrashReportingEnabled(true)
        Flurry.startSession("QGNJ37JTCSSMS9Z6D5TK");
        
        initCities();
        
        
        // Check if it was crashed last launch
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let appStatus = defaults.stringForKey("appStatus")
        {
            if (appStatus == "running"){
                print("app crashed last time it was lanuched")
                self.clearCache();
            }
        }
        
        defaults.setObject("appStatus", forKey: "running")
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("background", forKey: "appStatus")
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("running", forKey: "appStatus")
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("terminated", forKey: "appStatus")
        
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        // self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "ir.mandm.BuyOriginal" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] 
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("BuyOriginal", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    /*
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("BuyOriginal.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
            }
        }
        return coordinator
    }()
    */
    /*
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    */
    // MARK: - Core Data Saving support
    /*
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
    */
    
    // ToDo: Add logic for iOS 7
    func getUserLocation() -> CLLocationCoordinate2D {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var currentCityStr = defaults.objectForKey("currentCity") as? String;
        if (currentCityStr == nil){
            currentCityStr = "Tehran";
        }
        
        // ToDo: Find iOS7 device and check the location. Till that it returans city center location
        
        if SimulatorUtility.isRunningSimulator{
            return getCityCenterLocation(currentCityStr);
        }
        
        if #available(iOS 8.0, *) {
            if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse) {
                return manager.location!.coordinate;
            }
            else {
                return getCityCenterLocation(currentCityStr);
            }
        } else {
            return getCityCenterLocation(currentCityStr);
        }
        
    }
    
    
    func getCityCenterLocation(currentCityStr:String?) -> CLLocationCoordinate2D {
        
        let currentCity = CityModel.getCityConstantValue(currentCityStr!);
        
        switch (currentCity){
        case GlobalConstants.CITIES.Tehran:
            return self.cities[0].centerLocation;
        case GlobalConstants.CITIES.Isfahan:
            return self.cities[1].centerLocation;
        case GlobalConstants.CITIES.Kish:
            return self.cities[2].centerLocation;
        case GlobalConstants.CITIES.Shiraz:
            return self.cities[3].centerLocation;
        case GlobalConstants.CITIES.Mashhad:
            return self.cities[4].centerLocation;
        case GlobalConstants.CITIES.Tabriz:
            return self.cities[5].centerLocation;
        case GlobalConstants.CITIES.Karaj:
            return self.cities[6].centerLocation;
        case GlobalConstants.CITIES.None:
            return self.cities[0].centerLocation;
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        self.curLocationLat = locValue.latitude
        self.curLocationLong = locValue.longitude
        // print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
        
    func initCities() {
        var loc:CLLocationCoordinate2D = CLLocationCoordinate2D.init();
        
        //  Tehran
        loc.latitude = 32.629198
        loc.longitude = 51.684084
        var c = CityModel(cityName: "Tehran", areaCode: "021", cityNameFa: "تهران", imageName: "tehran", centerLoc: loc);
        self.cities+=[c];
        
        // Isfahan
        loc.latitude = 32.654627
        loc.longitude = 51.667983
        c = CityModel(cityName: "Isfahan", areaCode: "031", cityNameFa: "اصفهان", imageName: "isfahan", centerLoc: loc);
        self.cities+=[c];
        
        // Kish
        loc.latitude = 26.543289
        loc.longitude = 53.999226
        c = CityModel(cityName: "Kish", areaCode: "076", cityNameFa: "کیش", imageName: "kish",centerLoc: loc);
        self.cities+=[c];
        
        // Shiraz
        loc.latitude = 29.591768
        loc.longitude = 52.583698
        c = CityModel(cityName: "Shiraz", areaCode: "071", cityNameFa: "شیراز", imageName: "shiraz",centerLoc: loc);
        self.cities+=[c];
        
        // Mashhad
        loc.latitude = 36.260462
        loc.longitude = 59.616755
        c = CityModel(cityName: "Mashhad", areaCode: "051", cityNameFa: "مشهد", imageName: "mashhad",centerLoc: loc);
        self.cities+=[c];
        
        // Tabriz
        loc.latitude = 38.078940
        loc.longitude = 46.296548
        c = CityModel(cityName: "Tabriz", areaCode: "041", cityNameFa: "تبریز", imageName: "tabriz",centerLoc: loc);
        self.cities+=[c];
        
        // Karaj
        loc.latitude = 35.840019
        loc.longitude = 50.939091
        c = CityModel(cityName: "Karaj", areaCode: "026", cityNameFa: "کرج", imageName: "karaj",centerLoc: loc);
        self.cities+=[c];
            
    }
    
    
    func clearCache(){
        
        let fileManager = NSFileManager.defaultManager()
        
        let documentDirectoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        
        for var i = 0; i < self.cities.count; i++
        {
            print("\(self.cities[i].areaCode)")
            
            do {
                let fileDestinationUrl = documentDirectoryURL.URLByAppendingPathComponent(self.cities[i].areaCode+".txt")
                try fileManager.removeItemAtURL(fileDestinationUrl)
                
            }
            catch let error as NSError {
                print("Ooops! Something went wrong: \(error)")
            }
        }
    
    }
}

