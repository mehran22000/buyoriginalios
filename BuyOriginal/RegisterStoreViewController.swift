//
//  RegisterStoreViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class RegisterStoreViewController: UIViewController {

    var account:AccountModel!;
    @IBOutlet var sNameTextField: UITextField!
    @IBOutlet var sAddressTextField: UITextField!
    @IBOutlet var sHoursTextField: UITextField!
    @IBOutlet var bDistributorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBtn = UIBarButtonItem(title: "برند >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
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
        
        if (self.isFormCompelete()){
            let store=StoreModel();
            store.sName = self.sNameTextField.text;
            store.sAddress = self.sAddressTextField.text;
            store.sHours = self.sHoursTextField.text;
            store.bDistributor = self.bDistributorTextField.text;
        
            self.account.store = store;
            self.performSegueWithIdentifier("seguePushRegisterLocation", sender: sender)
        }
    }
    
    func isFormCompelete() -> Bool {
        var err=0;
        var errMsg="";
        
        if (self.sNameTextField.text!.isEmpty) {
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_STORE_NAME;
            errMsg = "نام فروشگاه خود را وارد کنید" ;
        }
        else if (self.sAddressTextField.text!.isEmpty) {
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_STORE_ADDRESS;
            errMsg = "آدرس فروشگاه خود را وارد کنید" ;
        }
        else if (self.sHoursTextField.text!.isEmpty) {
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_STORE_HOURS;
            errMsg = "ساعات کار فروشگاه خود را وارد کنید" ;
        }
        /*
        else if (self.isHourseValid(self.sHoursTextField.text)==false){
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_STORE_HOURS_FORMAT;
            errMsg = "ساعات کار نادرست است. مثلا ۱۰-۲۱ یا ۸-۱۲ ۱۴-۲۲" ;
        }
        */
        if (err>0){
            let alert = UIAlertView()
            alert.title = ""
            alert.message = errMsg
            alert.addButtonWithTitle("ادامه")
            alert.tag = 1
            alert.show()
            return false;
        }
        
        return true;
        
    }
    
    /*
    // ToDo: Check Hours format
    func isHourseValid(hours:String) -> Bool {
        
        let hoursRegEx = "(\\d{1-2})-(\\d{1-2})"
        
        let hoursTest = NSPredicate(format:"SELF MATCHES %@", hoursRegEx)
        return hoursTest.evaluateWithObject(hours);
        
    }
    */
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "seguePushRegisterLocation"
        {
            if let destinationVC = segue.destinationViewController as? LocateStoreViewController{
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
