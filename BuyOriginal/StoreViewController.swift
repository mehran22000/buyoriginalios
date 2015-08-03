//
//  StoreViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-06.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet var tableView: UITableView!
    var storesArray = NSArray()
    var filteredStores = [StoreModel]()
    var brandId="0"
    var areaCode = ""
    var is_searching=false   // It's flag for searching
    @IBOutlet var activityIndicatior: UIActivityIndicatorView?;
    
    let kDemoStores:String="[{\"brandId\":\"1\",\"name\":\"آریاپخش نقش جهان\",\"phoneNumber\":\"۳۶۳۰۴۹۲۷\",\"address\":\"اصفهان خیابان چهارباغ بالا\"}]"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let backButton = UIBarButtonItem(title: "قبل > ", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 20)!], forState: UIControlState.Normal)
        //self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationItem.backBarButtonItem=backButton;
        
        let fetcher = BOHttpfetcher()
        self.activityIndicatior?.hidden = true;
        if (storesArray.count==0){
            self.activityIndicatior?.hidden = false;
            self.activityIndicatior?.startAnimating()
            self.activityIndicatior?.hidesWhenStopped=true
            fetcher.fetchStores (self.brandId,distance: nil,lat: nil,lon: nil,areaCode:self.areaCode, discount:false, completionHandler: {(result: NSArray) -> () in
                self.storesArray = result
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.activityIndicatior?.stopAnimating()
                    self.tableView.reloadData()
                })
            });
        }
        
        /*
        
        DataManager.getTopAppsDataFromFileWithSuccess ("Stores",success: {(data) -> Void in
            let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
            let parser = ResponseParser()
            self.storesArray = parser.parseStoresJson(String(self.brandId),json:resstr)
            print(self.storesArray.count)
            self.tableView.reloadData()
        })
        */
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Do any additional setup after loading the view.
        
    
        
    }

    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if is_searching==true {
            return self.filteredStores.count
        } else {
            return self.storesArray.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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
            cell.storeImageView.image = UIImage(named: "discount");
        }
        else if (store.sVerified=="Yes"){
            cell.storeImageView.image = UIImage(named: "verified");
        }
        
        // cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
// Search Bar Delegates
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text.isEmpty{
            is_searching = false
            tableView.reloadData()
        } else {
            println(" search text %@ ",searchBar.text as NSString)
            is_searching = true
            self.filteredStores.removeAll(keepCapacity: false)
            for var index = 0; index < self.storesArray.count; index++
            {
                var store: StoreModel = self.storesArray.objectAtIndex(index) as! StoreModel
                
                var currentString = store.sName as String
                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil {
                    self.filteredStores+=[store];
                }
            }
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueShowMap"
        {
            var selectedStore = getSelectedStore(sender);
            if let destinationVC = segue.destinationViewController as? LocationViewController{
                    destinationVC.lat = (selectedStore.sLat as NSString).doubleValue
                    destinationVC.long = (selectedStore.sLong as NSString).doubleValue
                    destinationVC.storeName = selectedStore.sName
            }
        }
    }
    
    
    func getSelectedStore (sender: AnyObject?) -> StoreModel! {
        let pointInTable: CGPoint = sender!.convertPoint(sender!.bounds.origin, toView: self.tableView)
        let cellIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
        
        if (cellIndexPath != nil) {
            var row = cellIndexPath?.row
            return self.storesArray[row!] as! StoreModel;
        }
        return nil
    }
    
    @IBAction func getDirectionPressed (sender:AnyObject?) {
        self.performSegueWithIdentifier("segueShowMap", sender: sender)
    }
    
    @IBAction func callPressed (sender:AnyObject?) {
        
        var selectedStore = getSelectedStore(sender);
        
        let phone = "tel://"+selectedStore.sAreaCode+selectedStore.sTel1;
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);
        
    }
    
    func getDayOfWeek(today:String)->() {
        
        let df  = NSDateFormatter()
        df.calendar = NSCalendar(calendarIdentifier: NSPersianCalendar)!
        df.dateStyle = NSDateFormatterStyle.MediumStyle;
        df.dateFormat = "yyyy/MM/dd"
        let stringDate = "1391/04/07"
        let date = df.dateFromString(stringDate);
        print(date);
        
        /*
        
        let todayDate = formatter.dateFromString(today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSPersianCalendar)!
        formatter.calendar = myCalendar;
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle;
        formatter.calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar);
        
        let myComponents = myCalendar.components(.CalendarUnitWeekday, fromDate: todayDate)
        let weekDay = myComponents.weekday
        return weekDay
        */
        
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
