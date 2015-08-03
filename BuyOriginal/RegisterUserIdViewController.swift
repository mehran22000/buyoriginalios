//
//  RegisterUserIdViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class RegisterUserIdViewController: UIViewController {
    
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
        
        if (self.isValidEmail(self.emailTextField.text)==false){
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_EMAIL;
            errMsg = "ایمیل شما نادرست است" ;
        }
        else if (self.passwordTextField.text.isEmpty) {
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_PASSWORD;
            errMsg = "رمز کاربری را وارد کنید" ;
        }
        else {
            self.account.uEmail=self.emailTextField.text;
            self.account.uPassword=self.passwordTextField.text;
            self.performSegueWithIdentifier("seguePushCities", sender: sender)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
