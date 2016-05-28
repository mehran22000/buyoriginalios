//
//  AppUpdateVC.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2016-05-27.
//  Copyright © 2016 MandM. All rights reserved.
//

import UIKit

class AppUpdateVC: UIViewController {

    var newVesion:String?;
    var mandatoryUpdate:Bool?;
    @IBOutlet var continueBtn:UIButton?;
    @IBOutlet var msgLabel:UILabel?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.mandatoryUpdate == true){
            self.continueBtn?.hidden = true;
        }
        
        let msgStr = NSLocalizedString("update_required", comment: "");
        self.msgLabel?.text = String(format: msgStr, newVesion!);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continuePressed () {
        self.dismissViewControllerAnimated(false, completion:nil);
    }
    
    @IBAction func updatePressed () {
        var urlString:String;
        if #available(iOS 8.0, *) {
            urlString = String(format:GlobalConstants.iOSAppStoreURLFormat,GlobalConstants.ASLBEKHAR_STORE_ID);
        }
        else {
            urlString = String(format:GlobalConstants.iOS7AppStoreURLFormat,GlobalConstants.ASLBEKHAR_STORE_ID);
        }
        UIApplication.sharedApplication().openURL(NSURL(string:urlString)!);
        
        /*
        if UIApplication.sharedApplication().canOpenURL(url!) {
            UIApplication.sharedApplication().openURL(url!)
        }
        */
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
