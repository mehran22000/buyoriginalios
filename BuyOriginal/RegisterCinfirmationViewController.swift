//
//  RegisterTermsViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-11.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class RegisterConfirmationViewController: UITableViewController {
    
    var account:AccountModel!;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBtn = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.Plain, target: self, action: nil);
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
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.row) {
        case 0:
            return 55;
        case 1:
            return 55;
        case 2:
            return 150;
        case 3:
            return 55;
        default:
            return 44;
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
        switch (indexPath.row) {
        case 3:
            self.finishPressed();
        default:
            return;
        }
        
        
    }
    
    
    @IBAction func finishPressed () {
        self.navigationController?.popToRootViewControllerAnimated(false);
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
