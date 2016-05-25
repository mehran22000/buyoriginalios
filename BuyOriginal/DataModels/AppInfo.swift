//
//  AppInfo.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2016-05-24.
//  Copyright © 2016 MandM. All rights reserved.
//

import Foundation

class AppInfoModel: NSObject {
    
    var currentVersion: String!
    var lastValidVersion: String!
    
    
    init(_currentVersion: String!, _lastValidVersion: String!) {
        self.currentVersion = _currentVersion;
        self.lastValidVersion = _lastValidVersion;
        super.init();
    }
    
    
    
    override var description: String {
        return "currentVersion: \(currentVersion),lastValidVersion: \(lastValidVersion)";
    }
    
}
