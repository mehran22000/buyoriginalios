//
//  ForgetPasswordViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-15.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    
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

    
    @IBAction func emailBtnPressed () {
        
        
        var err=0;
        var errMsg="";
        
        if (self.isValidEmail(self.emailTextField.text)==false){
            err = GlobalConstants.REGISTER_BUSINESS_INVALID_EMAIL;
            errMsg = "ایمیل شما نادرست است" ;
        }
        else {
            sendPassword();
        }
        
        if (err>0){
            
            let alertController = UIAlertController(title: "", message:errMsg, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "دوباره تلاش کنید", style:UIAlertActionStyle.Default) { (action) in
            }
            
            alertController.addAction(okAction);
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    
    func sendPassword () {
        let okAction = UIAlertAction(title: "", style:UIAlertActionStyle.Default) { (action) in
            self.navigationController?.popToRootViewControllerAnimated(false);
        }
        
        let httpLogin = BOHttpLogin();
        
        httpLogin.recoverPassword (self.emailTextField.text) { (result) -> Void in
            println("Send Password Request Completed");
            if (result=="success"){
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    let alertController = UIAlertController(title: "", message:
                        "رمز عبور شما با موفقیت ارسال شد", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okAction = UIAlertAction(title: "ادامه", style:UIAlertActionStyle.Default) { (action) in
                        self.navigationController?.popViewControllerAnimated(true);
                    }
                    
                    alertController.addAction(okAction);
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                });
            }
            else {
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let alertController = UIAlertController(title: "", message:
                    "خطادر ارسال رمز عبور لطفا دوباره تلاش کنید", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "ادامه", style:UIAlertActionStyle.Default) { (action) in
                        self.emailTextField.text="";
                    }
                    alertController.addAction(okAction);
                    self.presentViewController(alertController, animated: true, completion: nil);
                });
            }
        };
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
