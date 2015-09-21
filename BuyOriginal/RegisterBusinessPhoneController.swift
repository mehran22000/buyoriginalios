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
        
        let backBtn = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;
        
        
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
        
        if (self.areaCodeTextField.text.toInt() == nil){
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_AREACODE;
            errMsg = "کد شهر شما نادرست است" ;
        }
        else if (self.telTextField.text.toInt() == nil) {
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
            
            let alertController = UIAlertController(title: "", message:errMsg, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "ادامه", style:UIAlertActionStyle.Default) { (action) in
            }
            
            alertController.addAction(okAction);
            
            self.presentViewController(alertController, animated: true, completion: nil)
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
