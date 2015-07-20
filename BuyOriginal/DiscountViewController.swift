//
//  BusDisViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-07-08.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class DiscountViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        let backBtn = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;
        
        if let font = UIFont(name: "system", size: 74) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!;
        
        switch (indexPath.row) {
            case 0:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cellBrand") as! BOBrandTableViewCell;
            case 1:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cellStartDate") as! BOBusDisDateTableViewCell;
            case 2:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cellEndDate") as! BOBusDisDateTableViewCell;
            case 3:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cellPrecentage") as! BOBusDisPercentageTableViewCell;
            case 4:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cellAction") as! BOBusDisActionTableViewCell;
            default:
                cell = nil;
        }
        
        
        /*
        var cell:BOStoresTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellStore") as! BOStoresTableViewCell
        
        var store = self.storesArray[indexPath.row] as! StoreModel
        
        if is_searching==true {
            store = self.filteredStores[indexPath.row] as StoreModel
        } else {
            store = self.storesArray[indexPath.row] as! StoreModel
        }
        
        cell.storeNameLabel.text = store.sName;
        cell.storeLocationLabel.text = store.sAddress
        cell.storePhoneNumberLabel.text = store.sTel1;
        cell.storeHoursLabel.text = store.sHours;
        
        if ((store.sVerified=="Yes") && (store.sDiscount>0)){
            cell.storeImageView.image = UIImage(named: "discount+verified");
        }
        else if (store.sDiscount>0){
            cell.storeImageView.image = UIImage(named: "discount+verified");
        }
        else if (store.sVerified=="Yes"){
            cell.storeImageView.image = UIImage(named: "verified");
        }
        
        // cell.textLabel?.text = self.items[indexPath.row]
        */
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.row) {
        case 0:
            return 60;
        case 1:
            return 85;
        case 2:
            return 85;
        case 3:
            return 85;
        case 4:
            return 60;
        default:
            return 0;
        }
    }
    
    @IBAction func backPressed () {
        self.dismissViewControllerAnimated(false, completion: nil);
    }

}
