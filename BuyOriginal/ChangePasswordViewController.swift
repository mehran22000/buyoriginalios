//
//  ChangePasswordViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-14.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController{

    @IBOutlet var oldPasswordTextField: UITextField!
    @IBOutlet var newPasswordTextField: UITextField!
    @IBOutlet var reNewPasswordTextField: UITextField!
    var account: AccountModel?
    var delegate: BuPasswordDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBtn = UIBarButtonItem(title: "پروفایل >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
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
    
    @IBAction func savePasswordPressed () {
        
        var err=0;
        var errMsg="";

        
        // Check old password is valid
        if (self.oldPasswordTextField.text != self.account?.uPassword) {
        
            err = GlobalConstants.PROFILE_NEWPASSWORD_INVALID_OLDPASSWORD;
            errMsg = "رمزعبو شما نادرست است." ;
            
        }
        else if (self.newPasswordTextField.text != self.reNewPasswordTextField.text){
            
            err = GlobalConstants.PROFILE_NEWPASSWORD_NOMATCH;
            errMsg = "رمز عبور جدید و تکرار آن مطابقت ندارند" ;

        }
        else {
            self.delegate?.updatePassword(self.newPasswordTextField.text!);
            self.navigationController?.popViewControllerAnimated(true);
        }
        
        if (err>0){
            let alert = UIAlertView(title: "خطا", message: errMsg, delegate: nil, cancelButtonTitle: "ادامه")
            alert.tag=1;
            alert.show()
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
