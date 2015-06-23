//
//  TabBarController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-06-21.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    var areaCode:String="";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // var navVC:UINavigationController = self.viewControllers?[0] as! UINavigationController;
       // var brandVC:BrandViewController = navVC.topViewController as! BrandViewController;
       // brandVC.areaCode = self.areaCode;
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
}
