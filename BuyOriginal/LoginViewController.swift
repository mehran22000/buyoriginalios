//
//  LoginViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    var accountInfo: AccountModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.passwordTextField.text = "";
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func registerPressed (sender:AnyObject?) {
        self.performSegueWithIdentifier("segueRegister", sender: sender)
    }
    
    @IBAction func loginPressed (sender:AnyObject?) {
        
        let email = self.emailTextField.text as NSString;
        let password = self.passwordTextField.text as NSString;
        
        let httpLogin = BOHttpLogin()
        
        
        httpLogin.login(email, password: password) { (accountInfo) -> Void in
            println("Login Successful");
            if ((accountInfo) != nil){
                self.accountInfo = accountInfo;
                self.performSegueWithIdentifier("segueLogin", sender: sender)
                
            }
            else {
                self.loginFailed();
            }
        };
        
        
        
    }
    
    func loginFailed () {
        let alertController = UIAlertController(title: "", message:
            "نام کاربری یا رمز عبور شما نادرست است.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "دوباره تلاش کنید", style:UIAlertActionStyle.Default) { (action) in
            self.navigationController?.popToRootViewControllerAnimated(false);
        }
        
        alertController.addAction(okAction);
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func forgetPasswordPressed (sender:AnyObject?) {
        self.performSegueWithIdentifier("segueForgetPassword", sender: sender)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "segueRegister"
        {
            
        }
        else if segue.identifier == "segueLogin"
        {
            var tabBarVC = segue.destinationViewController as! UITabBarController;
            var navVC = tabBarVC.viewControllers?[0] as! UINavigationController;
            var discountVC = navVC.viewControllers?[0] as! DiscountViewController;
            discountVC.account = self.accountInfo;
        }
        else if segue.identifier == "segueForgetPassword"
        {
            
        }
    }
    
}
