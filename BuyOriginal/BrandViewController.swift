//
//  ViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-04.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit


let string = "[ {\"name\": \"John\", \"age\": 21}, {\"name\": \"Bob\", \"age\": 35}, {\"name\": \"Bob\", \"age\": 35} ]"
let kDemoBrands:String="[{\"id\":\"1\",\"name\":\"L'Oreal\",\"category\":\"آرایش و زیبایی\",\"storesNo\":\"۱۰\",\"nearestLocation\":\"اصفهان خیابان چهارباغ بالا\",\"logo\":\"loreal\"}]"

class BrandViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet var tableView: UITableView!
    var brandsArray = NSArray()
    var filteredBrands = [BrandModel]()
    var brands = kDemoBrands
    var brandId="0"
    var is_searching=false   // It's flag for searching
    var areaCode:String="";
    var screenMode=2;
    var account:AccountModel!;
    var selectedCategoryNameFa:String="";

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        /*
        DataManager.getTopAppsDataFromFileWithSuccess ("Brands",success: {(data) -> Void in
            let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
            let parser = ResponseParser()
            self.brandsArray = parser.parseBrandJson(resstr)

            self.tableView.reloadData()
        })
        */
        
        switch (self.screenMode){
            case GlobalConstants.BRANDS_SCREEN_MODE_SEARCH:
                self.navigationItem.title="انتخاب برند";
            case GlobalConstants.BRANDS_SCREEN_MODE_SIGNUP:
                self.navigationItem.title="۳-انتخاب برند";
            default:
                self.navigationItem.title="";
        }

        let backBtn = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // GA
        var tracker:GAITracker = GAI.sharedInstance().defaultTracker as GAITracker
        tracker.set(kGAIScreenName, value:"Home Screen")
        var build = GAIDictionaryBuilder.createScreenView().build() as [NSObject : AnyObject]
        tracker.send(build)
        
        
        
    }

    override func viewWillAppear(animated: Bool) {
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
            return self.filteredBrands.count
        } else {
            return self.brandsArray.count
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:BOBrandTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellBrand") as! BOBrandTableViewCell
        
        var brand:BrandModel
        
        if is_searching==true {
            brand = self.filteredBrands[indexPath.row] as BrandModel
        } else {
            brand = self.brandsArray[indexPath.row] as! BrandModel
        }
        
        
        cell.brandNameLabel.text = brand.bName.capitalizedString;
        cell.brandCategoryLabel.text = brand.bCategory;
        
        cell.brandImageView.image = brand.bLogoImage;
        cell.brandImageView.layer.cornerRadius = 8.0
        cell.brandImageView.clipsToBounds = true
        
        /*
        // Load Logo Image
        let fetcher = BOHttpfetcher()
        fetcher.fetchBrandLogo(brand.bLogo, completionHandler: { (imgData) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.brandImageView.image = UIImage(data: imgData);
                cell.brandImageView.layer.cornerRadius = 8.0
                cell.brandImageView.clipsToBounds = true
                
                })
            })
        */
        return cell
    }
    
    
    // Search Bar Delegates
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text.isEmpty{
            is_searching = false
            tableView.reloadData()
        } else {
            println(" search text %@ ",searchBar.text as NSString)
            is_searching = true
            self.filteredBrands.removeAll(keepCapacity: false)
            for var index = 0; index < self.brandsArray.count; index++
            {
                var brand: BrandModel = self.brandsArray.objectAtIndex(index) as! BrandModel
                
                var currentString = brand.bName as String
                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil {
                    self.filteredBrands+=[brand];
                }
            }
            tableView.reloadData()
        }
    }
    
    
    /*
    func loadBrandsLogo() {
        
        let path = NSBundle.mainBundle().pathForResource("logos", ofType:"plist")
        let dict = NSDictionary(contentsOfFile:path!)
        var counter = 0;
        let fetcher = BOHttpfetcher()

        
        for brand in self.brandsArray {
            var b:BrandModel = brand as! BrandModel;
            if ((dict?.valueForKey(b.bLogo)) != nil){
                // Load available logos
            //    println(" Logo Found: %@ ",&b.bLogo);
                var logo:UIImage! = UIImage(named: b.bLogo);
                b.bLogoImage = logo!;
                counter=counter+1;
                if (counter == self.brandsArray.count){
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }
                
            }
            else {
                // Download missing logos
                
                fetcher.fetchBrandLogo(b.bLogo, completionHandler: { (imgData) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if ((imgData) != nil){
                            b.bLogoImage = UIImage(data: imgData)!;
                   //         println(" Logo Downloaded: %@ ",&b.bLogo);
                        }
                        else{
                            b.bLogoImage = UIImage(named:"brand.default")!;
                        }
                        counter=counter+1;
                        if (counter == self.brandsArray.count){
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.tableView.reloadData()
                            })
                        }
                    })
                })
            }
        }
    }
    */
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
        var selectedBrand = self.brandsArray[indexPath.row] as! BrandModel
        
        self.brandId=selectedBrand.bId;
        
        if ((self.account) != nil){
            self.account.brand=selectedBrand;
        }
        
        if (self.screenMode==GlobalConstants.BRANDS_SCREEN_MODE_SEARCH){
            performSegueWithIdentifier("ShowStoresSegue", sender: nil);
        }
        else if (self.screenMode==GlobalConstants.BRANDS_SCREEN_MODE_SIGNUP){
            performSegueWithIdentifier("segueShowStoreEntryForm", sender: nil);
        }
        

    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print (segue.identifier)
        
        if segue.identifier == "ShowStoresSegue"
        {
            if let destinationVC = segue.destinationViewController as? StoreViewController{
                destinationVC.brandId = self.brandId
                destinationVC.areaCode = self.areaCode
            }
        }
        
        if segue.identifier == "segueShowStoreEntryForm"
        {
            if let destinationVC = segue.destinationViewController as? RegisterStoreViewController{
                destinationVC.account=self.account;
            }
            
        }
    }
    
    @IBAction func backPressed () {
        self.navigationController?.popViewControllerAnimated(true);
    }

    
    
    
    
}

