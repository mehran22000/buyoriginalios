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
    @IBOutlet var noInternetConnectionView: UIView!
    
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
        
        if (Utilities.isConnectedToNetwork() == false) {
            self.noInternetConnectionView.hidden = false
        }
        else {
            self.noInternetConnectionView.hidden = true
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
    
    @IBAction func registerPressed (sender:AnyObject?) {
        self.performSegueWithIdentifier("segueRegister", sender: sender)
    }
    
    @IBAction func loginPressed (sender:AnyObject?) {
        
        let email = self.emailTextField.text as String?;
        let password = self.passwordTextField.text as String?;
        
        
        let httpLogin = BOHttpLogin()
        
        
        httpLogin.login(email!, password: password!) { (accountInfo) -> Void in
            print("Login Successful");
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
        let alert = UIAlertView(title: "دوباره تلاش کنید", message: "نام کاربری یا رمز عبور شما نادرست است.", delegate: nil, cancelButtonTitle: "پایان")
        alert.tag=1;
        alert.show()
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
            let tabBarVC = segue.destinationViewController as! UITabBarController;
            let discNavVC = tabBarVC.viewControllers?[0] as! UINavigationController;
            let discountVC = discNavVC.viewControllers[0] as! DiscountViewController;
            discountVC.account = self.accountInfo;
            let profNavVC = tabBarVC.viewControllers?[1] as! UINavigationController;
            let profileVC = profNavVC.viewControllers[0] as! BussinessProfileController;
            profileVC.account = self.accountInfo;
        }
        else if segue.identifier == "segueForgetPassword"
        {
            
        }
    }
    
}
