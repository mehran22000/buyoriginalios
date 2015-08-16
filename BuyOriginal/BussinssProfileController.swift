//
//  BusProfileViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-13.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BussinessProfileController: UITableViewController  {

    var account: AccountModel?
    var cellBrand: BOBrandTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        let backBtn = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!;
        
        switch (indexPath.row) {
        case 0:
            self.cellBrand = self.tableView.dequeueReusableCellWithIdentifier("cellBrand") as? BOBrandTableViewCell;
            cellBrand?.brandNameLabel.text = self.account?.brand.bName;
            cellBrand?.brandCategoryLabel.text = self.account?.brand.bCategory;
            cellBrand?.brandImageView.image = UIImage(named: self.account!.brand.bLogo!);
            cellBrand?.brandImageView.layer.cornerRadius = 8.0
            cellBrand?.brandImageView.clipsToBounds = true
            return cellBrand!;
        
        case 1:
            cell = self.tableView.dequeueReusableCellWithIdentifier("cellEmail") as! BusProfileReadOnlyCell;
        case 2:
            cell = self.tableView.dequeueReusableCellWithIdentifier("cellPassword") as! BusProfileReadOnlyCell;
        case 3:
            cell = self.tableView.dequeueReusableCellWithIdentifier("cellCity") as! BusProfileReadOnlyCell;
        case 4:
            cell = self.tableView.dequeueReusableCellWithIdentifier("cellAddress") as! BusProfileInputCell;
        case 5:
            cell = self.tableView.dequeueReusableCellWithIdentifier("cellPhone") as! BusProfileReadOnlyCell;
        case 6:
            cell = self.tableView.dequeueReusableCellWithIdentifier("cellDistributor") as! BusProfileInputCell;
        case 7:
            cell = self.tableView.dequeueReusableCellWithIdentifier("cellHours") as! BusProfileReadOnlyCell;
        case 8:
            cell = self.tableView.dequeueReusableCellWithIdentifier("cellAction") as! BOBusDisActionTableViewCell;
        default:
            cell = nil;
        }
        return cell;
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
        switch (indexPath.row) {
        case 3:
            performSegueWithIdentifier("seguePushCities", sender: nil);
        case 5:
            performSegueWithIdentifier("segueChangePhone", sender: nil);
        default:
            return;
        }
        
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.row) {
        case 0:
            return 60;
        case 1:
            return 60;
        case 2:
            return 60;
        case 3:
            return 60;
        case 4:
            return 75;
        case 5:
            return 60;
        case 6:
            return 75;
        case 7:
            return 75;
        case 8:
            return 114;
            
        default:
            return 0;
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print (segue.identifier)
        
        if segue.identifier == "seguePushCities"
        {
            if let destinationVC = segue.destinationViewController as? CitiesTableViewController{
                destinationVC.screenMode=GlobalConstants.CITIES_SCREEN_MODE_CHANGE
            }
        }
        
    }
    
    
    @IBAction func backPressed () {
        self.dismissViewControllerAnimated(false, completion: nil);
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
