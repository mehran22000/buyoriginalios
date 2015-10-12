//
//  RegisterUserIdViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class RegisterUserIdViewController: UIViewController, UIAlertViewDelegate {
    
    var account:AccountModel!;
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBtn = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;
        self.account = AccountModel();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func continuePressed (sender:AnyObject?) {
        
        var err=0;
        var errMsg="";
        
        if (self.isValidEmail(self.emailTextField.text!)==false){
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_EMAIL;
            errMsg = "ایمیل شما نادرست است" ;
        }
        else if (self.passwordTextField.text!.isEmpty) {
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_PASSWORD;
            errMsg = "رمز کاربری را وارد کنید" ;
        }
        else {
            self.duplicatedEmailValidation();
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
    
    
    func duplicatedEmailValidation () {
        
        let httpLogin = BOHttpLogin();
        
        httpLogin.duplicateEmail(self.emailTextField.text!) { (result) -> Void in
            print("duplicateEmail response back");
            if (result=="false"){
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.account.uEmail=self.emailTextField.text;
                self.account.uPassword=self.passwordTextField.text;
                self.performSegueWithIdentifier("seguePushCities", sender:nil)
                    });
            }
            else {
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let alert = UIAlertView()
                    alert.title = ""
                    alert.message =  "این ایمیل آدرس ثبت شده است. یک آدرس جدید وارد کنید"
                    alert.addButtonWithTitle("ادامه")
                    alert.tag = 1
                    alert.show()
                
                });
            }
        };
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "seguePushCities"
        {
            if let destinationVC = segue.destinationViewController as? CitiesTableViewController{
                destinationVC.screenMode = GlobalConstants.CITIES_SCREEN_MODE_SIGNUP
                destinationVC.account = self.account;
            }
            
        }

    }
    
    @IBAction func backPressed () {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    func isValidEmail(email:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
    }
    
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int)
    {
        if alertView.tag==1
        {
            if buttonIndex==0
            {
                self.emailTextField.text="";
                self.passwordTextField.text="";
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
