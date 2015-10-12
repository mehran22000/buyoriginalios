//
//  RegisterTermsViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class RegisterTermsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var confrimBtn: UIBarButtonItem!

    var account:AccountModel!;
    override func viewDidLoad() {
        super.viewDidLoad()

        let backBtn = UIBarButtonItem(title: "تلفن >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed () {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!;
            
        switch (indexPath.row) {
            case 0:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell1");
            case 1:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell2");
            case 2:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell3");
            case 3:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell4");
            default:
                cell = nil;
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.row) {
            case 0:
                return 155;
            case 1:
                return 130;
            case 2:
                return 75;
            case 3:
                return 75;
            default:
                return 75;
        }
    }

    
    
    @IBAction func agreePressed () {
        
        let httpPost = BOHttpPost()
        self.confrimBtn.enabled = false;
        httpPost.addOrUpdateBusiness(false, account:account) { (result) -> Void in
            self.confrimBtn.enabled = true;
            print("Registeration Successful");
            if (result=="success"){
               // self.performSegueWithIdentifier("pushConfirmation", sender: nil)
                let alert = UIAlertView(title: "پایان", message: "فروشگاه شما با موفقیت ثبت گردید", delegate: self, cancelButtonTitle: "پایان")
                alert.tag=1;
                alert.show()
            }
            else {
                
                let alert = UIAlertView(title: "پایان", message: "خطادر ثبت شرکت", delegate: self, cancelButtonTitle: "پایان")
                alert.tag=1;
                alert.show()
            }
        };
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int)
    {
        if alertView.tag==1
        {
            if buttonIndex==0
            {
                print("پایان");
                self.navigationController?.popToRootViewControllerAnimated(false);
                
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
