//
//  BusProfileViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-13.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BussinessProfileController: UITableViewController, BuPasswordDelegate, BuPhoneDelegate, BuCityDelegate  {

    var account: AccountModel?
    var cellBrand: BOBrandTableViewCell?
    var cellHours: BusProfileInputCell?
    var cellAddress: BusProfileInputCell?
    
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
            var emailCell = self.tableView.dequeueReusableCellWithIdentifier("cellEmail") as! BusProfileReadOnlyCell;
            emailCell.value.text = self.account?.uEmail;
            return emailCell;
            
        case 2:
            var passwordCell = self.tableView.dequeueReusableCellWithIdentifier("cellPassword") as! BusProfileReadOnlyCell;
           // passwordCell.value.text = self.account?.uPassword;
            return passwordCell;
        case 3:
            var cityCell = self.tableView.dequeueReusableCellWithIdentifier("cellCity") as! BusProfileReadOnlyCell;
            cityCell.value.text = self.account?.sCity.cityNameFa;
            return cityCell;
        case 4:
            self.cellAddress = self.tableView.dequeueReusableCellWithIdentifier("cellAddress") as? BusProfileInputCell;
            self.cellAddress?.value.text = self.account?.store.sAddress;
            return self.cellAddress!;
        case 5:
            var phoneCell = self.tableView.dequeueReusableCellWithIdentifier("cellPhone") as! BusProfileReadOnlyCell;
            phoneCell.value.text = self.account?.store.sTel1;
            return phoneCell;
        case 6:
            var distributorCell = self.tableView.dequeueReusableCellWithIdentifier("cellDistributor") as! BusProfileInputCell;
            distributorCell.value.text = self.account?.store.bDistributor;
            return distributorCell;
            
        case 7:
            self.cellHours = self.tableView.dequeueReusableCellWithIdentifier("cellHours") as? BusProfileInputCell;
            self.cellHours?.value.text = self.account?.store.sHours;
            return self.cellHours!;
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
                destinationVC.account = self.account;
                destinationVC.delegate = self;
            }
        }
        else if segue.identifier == "segueChangePhone"
        {
            if let destinationVC = segue.destinationViewController as? RegisterBusinessPhoneController{
                destinationVC.screenMode=GlobalConstants.BUSINESS_PHONE_SCREEN_MODE_CHANGE
                destinationVC.account = self.account;
                destinationVC.delegate = self;
            }
        }
        else if segue.identifier == "segueChangePassword"
        {
            if let destinationVC = segue.destinationViewController as? ChangePasswordViewController{
                destinationVC.account = self.account;
                destinationVC.delegate = self;
            }
        }
        
    }
    
    
    @IBAction func backPressed () {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    
    @IBAction func updateAccountPressed () {
        
        let okAction = UIAlertAction(title: "پایان", style:UIAlertActionStyle.Default) { (action) in
            self.navigationController?.popToRootViewControllerAnimated(false);
        }
        
        let httpPost = BOHttpPost()
        
        var msg = "";
        httpPost.addBusiness(account!) { (result) -> Void in
            println("Profile update complete");
            if (result=="success"){
                msg = "شناسه کاربری شما با موفقیت به روز رسانی شد.";
            }
            else {
                msg = "خطاذر به روز رسانی شناسه کاربری شما. دوباره تلاش کنید";
            }
                
                let alertController = UIAlertController(title: "", message:
                    msg, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(okAction);
                self.presentViewController(alertController, animated: true, completion: nil);
                
            }
            
            
        };
    
    
    @IBAction func hoursChanged () {
        self.account?.store.sHours = self.cellHours?.value.text;
    }
    
    @IBAction func addressChanged () {
        self.account?.store.sAddress = self.cellAddress?.value.text;
    }
    
    
    @IBAction func deleteAccountPressed () {
        
        let okAction = UIAlertAction(title: "", style:UIAlertActionStyle.Default) { (action) in
            self.deleteAccount();
        }
        let alertController = UIAlertController(title: "", message:
            "پاک کردن پروفایل شما باعث پال کردن تمامی اطلاعات شما می شود", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(okAction);
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func deleteAccount() {
        
        let okAction = UIAlertAction(title: "", style:UIAlertActionStyle.Default) { (action) in
            self.navigationController?.popToRootViewControllerAnimated(false);
        }
        
        let httpLogin = BOHttpLogin();
        
        let email = self.account?.uEmail;
        
        httpLogin.deleteUserAccount(email) { (result) -> Void in
            println("Delete user profile completed");
            if (result=="success"){
                let alertController = UIAlertController(title: "", message:
                    "شناسه کاربری شما با موفقیت حذف شد", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "ادامه", style:UIAlertActionStyle.Default) { (action) in
                    self.navigationController?.popViewControllerAnimated(true);
                }
                
                alertController.addAction(okAction);
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            else {
                
                let alertController = UIAlertController(title: "", message:
                    "خطادر حذف شناسه کاربری شما. دوباره تلاش کنید", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(okAction);
                self.presentViewController(alertController, animated: true, completion: nil);
            }
        };
        
    }

    
    func updatePassword(newPassword:String) -> () {
        self.account?.uPassword = newPassword;
    }
    
    func updatePhone(newPhoneNumber:String, newAreaCode:String) -> () {
        self.account?.store.sTel1 = newPhoneNumber;
        self.account?.store.sAreaCode = newAreaCode;
    }
    
    func updateCity(newCity: CityModel) {
        self.account?.sCity=newCity;
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
