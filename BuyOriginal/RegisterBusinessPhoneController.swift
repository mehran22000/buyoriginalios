//
//  RegisterBusinessPhoneController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-13.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class RegisterBusinessPhoneController: UIViewController {

    var account:AccountModel!;
    @IBOutlet var areaCodeTextField: UITextField!
    @IBOutlet var telTextField: UITextField!
    var screenMode=GlobalConstants.BUSINESS_PHONE_SCREEN_MODE_SIGNUP;
    var delegate:BuPhoneDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch (self.screenMode){
        case GlobalConstants.BUSINESS_PHONE_SCREEN_MODE_SIGNUP:
            let backBtn = UIBarButtonItem(title: "مکان یابی >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
            navigationItem.leftBarButtonItem = backBtn;
        case GlobalConstants.BUSINESS_PHONE_SCREEN_MODE_CHANGE:
            let backBtn = UIBarButtonItem(title: "پروفایل >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
            navigationItem.leftBarButtonItem = backBtn;
        default:
            self.navigationItem.title="";
        }
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed () {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func continuePressed (sender:AnyObject?) {
        
        
        var err=0;
        var errMsg="";
        
        if (Int(self.areaCodeTextField.text!) == nil){
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_AREACODE;
            errMsg = "کد شهر شما نادرست است" ;
        }
        else if (Int(self.telTextField.text!) == nil) {
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_PHONE;
            errMsg = "تلفن شما نادرست است" ;
        }
        else {
            self.account.store.sAreaCode = self.areaCodeTextField.text;
            self.account.store.sTel1 = self.telTextField.text;
            
            if (self.screenMode == GlobalConstants.BUSINESS_PHONE_SCREEN_MODE_SIGNUP) {
                self.performSegueWithIdentifier("seguePushTerms", sender: sender)
            }
            else if (self.screenMode == GlobalConstants.BUSINESS_PHONE_SCREEN_MODE_CHANGE) {
                self.delegate?.updatePhone(self.account.store.sTel1,newAreaCode: self.account.store.sAreaCode);
                self.navigationController?.popViewControllerAnimated(true);
            }
        }
        
        if (err>0){
            
            let alert = UIAlertView()
            alert.title = ""
            alert.message = errMsg
            alert.addButtonWithTitle("ادامه")
            alert.tag = 1
            alert.show()
        }
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "seguePushTerms"
        {
            if let destinationVC = segue.destinationViewController as? RegisterTermsViewController{
                destinationVC.account = self.account;
            }
            
        }
        
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
