//
//  RegisterTermsViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class RegisterTermsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    var account:AccountModel!;
    override func viewDidLoad() {
        super.viewDidLoad()

        let backBtn = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
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
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell1") as! UITableViewCell;
            case 1:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell2") as! UITableViewCell;
            case 2:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell3") as! UITableViewCell;
            case 3:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell4") as! UITableViewCell;
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
        
        let okAction = UIAlertAction(title: "پایان", style:UIAlertActionStyle.Default) { (action) in
            self.navigationController?.popToRootViewControllerAnimated(false);
        }
        
        let httpPost = BOHttpPost()
        
        httpPost.addBusiness(account) { (result) -> Void in
            println("Registeration Successful");
            if (result=="success"){
                self.performSegueWithIdentifier("pushConfirmation", sender: nil)
            }
            else {
                
                let alertController = UIAlertController(title: "", message:
                    "خطادر ثبت شرکت", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(okAction);
                self.presentViewController(alertController, animated: true, completion: nil);
                
                
            }
            
            
        };
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
