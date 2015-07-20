//
//  ForgetPasswordViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-15.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

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
        let alertController = UIAlertController(title: "", message:
            "رمز عبور شما با موفقیت ارسال شد", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "ادامه", style:UIAlertActionStyle.Default) { (action) in
            self.navigationController?.popViewControllerAnimated(true);
        }
        
        alertController.addAction(okAction);
        
        self.presentViewController(alertController, animated: true, completion: nil)
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
