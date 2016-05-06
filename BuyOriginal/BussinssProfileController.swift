//
//  BusProfileViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-13.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BussinessProfileController: UITableViewController, BuPasswordDelegate, BuPhoneDelegate, BuCityDelegate, BuBrandDelegate, UIAlertViewDelegate  {

    var account: AccountModel?
    var cellBrand: BOBrandTableViewCell?
    var cellHours: BusProfileInputCell?
    var cellAddress: BusProfileInputCell?
    var cellPhone: BusProfileReadOnlyCell?
    var cellDistributor: BusProfileInputCell?
    var cellCity: BusProfileReadOnlyCell?

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
            cellBrand?.categoryOrStoreNoLabel.text = self.account?.brand.bCategory;
            cellBrand?.brandImageView.image = UIImage(named: self.account!.brand.bLogo!);
            cellBrand?.brandImageView.layer.cornerRadius = 8.0
            cellBrand?.brandImageView.clipsToBounds = true
            cellBrand?.brandNameLabel.hidden=false;
            return cellBrand!;
        
        case 1:
            let emailCell = self.tableView.dequeueReusableCellWithIdentifier("cellEmail") as! BusProfileReadOnlyCell;
            emailCell.value.text = self.account?.uEmail;
            return emailCell;
            
        case 2:
            let passwordCell = self.tableView.dequeueReusableCellWithIdentifier("cellPassword") as! BusProfileReadOnlyCell;
           // passwordCell.value.text = self.account?.uPassword;
            return passwordCell;
        case 3:
            self.cellCity = self.tableView.dequeueReusableCellWithIdentifier("cellCity") as? BusProfileReadOnlyCell;
            self.cellCity?.value.text = self.account?.sCity.cityNameFa;
            return self.cellCity!;
        case 4:
            self.cellAddress = self.tableView.dequeueReusableCellWithIdentifier("cellAddress") as? BusProfileInputCell;
            self.cellAddress?.value.text = self.account?.store.sAddress;
            return self.cellAddress!;
        case 5:
            self.cellPhone = self.tableView.dequeueReusableCellWithIdentifier("cellPhone") as? BusProfileReadOnlyCell;
            self.cellPhone?.value.text = self.account?.store.sTel1;
            return self.cellPhone!;
        case 6:
            self.cellDistributor = self.tableView.dequeueReusableCellWithIdentifier("cellDistributor") as? BusProfileInputCell;
            self.cellDistributor?.value.text = self.account?.store.bDistributor;
            return self.cellDistributor!;
            
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
        print("You selected cell #\(indexPath.row)!")
        
        switch (indexPath.row) {
        case 0:
            performSegueWithIdentifier("segueBrands", sender: nil);
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
        else if segue.identifier == "segueBrands"
        {
            if let destinationVC = segue.destinationViewController as? BrandViewController{
                destinationVC.screenMode=GlobalConstants.BRANDS_SCREEN_MODE_CHANGE;
                destinationVC.delegate = self;
            }
        }
        
    }
    
    
    @IBAction func backPressed () {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    
    @IBAction func updateAccountPressed () {
        
        self.account?.store.sHours = self.cellHours?.value.text;
        self.account?.store.sAddress = self.cellAddress?.value.text;
        self.account?.store.bDistributor = self.cellDistributor?.value.text;
        
        let httpPost = BOHttpPost()
        
        var msg = "";
        httpPost.addOrUpdateBusiness(true, account:account!) { (result) -> Void in
            print("Profile update complete");
            if (result=="success"){
                msg = "شناسه کاربری شما با موفقیت به روز رسانی شد.";
            }
            else {
                msg = "خطاذر به روز رسانی شناسه کاربری شما. دوباره تلاش کنید";
            }
            
            let alert = UIAlertView(title: "", message: msg, delegate: nil, cancelButtonTitle: "ادامه")
            alert.tag=1;
            alert.show()
        }
    };
    

    
    @IBAction func deleteAccountPressed () {
        let alert = UIAlertView(title: "", message: "پاک کردن پروفایل شما باعث پاک کردن تمامی اطلاعات شما می شود",
            delegate: self, cancelButtonTitle: "ادامه");
        alert.tag=2;
        alert.show()
    }
    

    func deleteAccount() {
    
        let httpLogin = BOHttpLogin();
        let email = self.account?.uEmail;
        let sid = self.account?.store.sId;
        
        httpLogin.deleteUserAccount(email,sid:sid) { (result) -> Void in
            print("Delete user profile completed");
            if (result == "success"){
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.dismissViewControllerAnimated(false, completion: nil);
                })
            }
            else {
                let alert = UIAlertView(title: "", message: "خطادر حذف شناسه کاربری شما. دوباره تلاش کنید",
                    delegate: self, cancelButtonTitle: "ادامه");
                alert.tag=3;
                alert.show()
            }
        };
        
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int)
    {
        if alertView.tag==2
        {
            if buttonIndex==0
            {
                print("حذف پروفایل");
                self.deleteAccount();
            }
        }
    }
    
    
    

    
    func updatePassword(newPassword:String) -> () {
        self.account?.uPassword = newPassword;
    }
    
    func updatePhone(newPhoneNumber:String, newAreaCode:String) -> () {
        self.account?.store.sTel1 = newPhoneNumber;
        self.account?.store.sAreaCode = newAreaCode;
        self.cellPhone?.value.text = newAreaCode+"-"+newPhoneNumber;
    }
    
    func updateCity(newCity: CityModel) {
        self.account?.sCity=newCity;
        self.cellCity?.value.text = newCity.cityNameFa;
    }
    
    func updateBrand(newBrand:BrandModel) -> () {
        self.account?.brand=newBrand;
        self.cellBrand?.brandNameLabel.text=newBrand.bName;
        self.cellBrand?.brandImageView.image=newBrand.bLogoImage;
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
