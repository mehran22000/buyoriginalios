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
    @IBOutlet var adImgView: UIImageView!

    var brandsArray = NSArray()
    var brandStores = [String:[StoreModel]]();
    var filteredBrands = [BrandModel]()
    var brands = kDemoBrands
    var brandId="0"
    var is_searching=false   // It's flag for searching
    var areaCode:String="";
    var screenMode=0;
    var account:AccountModel!;
    var selectedCategoryNameFa:String="";
    var delegate: BuBrandDelegate?;
    
    var selectedBrandStoresArray = NSArray()
    
    var adTimer = NSTimer();
    @IBOutlet var activityIndicatior: UIActivityIndicatorView?;
    @IBOutlet var adActivityIndicatior: UIActivityIndicatorView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.adExists();
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        switch (self.screenMode){
            case GlobalConstants.BRANDS_SCREEN_MODE_SEARCH:
                self.navigationItem.title=self.selectedCategoryNameFa;
                let backBtn = UIBarButtonItem(title: "گروه >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
                navigationItem.leftBarButtonItem = backBtn;
            
            
            case GlobalConstants.BRANDS_SCREEN_MODE_SIGNUP:
                self.navigationItem.title="۳-انتخاب برند";
                let backBtn = UIBarButtonItem(title: "گروه >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
                navigationItem.leftBarButtonItem = backBtn;
            
            
            case GlobalConstants.BRANDS_SCREEN_MODE_CHANGE:
                self.navigationItem.title="برند";
                let backBtn = UIBarButtonItem(title: "پروفایل >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
                navigationItem.leftBarButtonItem = backBtn;
            
            
            default:
                self.navigationItem.title="";
        }

        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // GA
        let tracker:GAITracker = GAI.sharedInstance().defaultTracker as GAITracker
        tracker.set(kGAIScreenName, value:"BrandViewController")
        let build = GAIDictionaryBuilder.createScreenView().build() as [NSObject : AnyObject]
        tracker.send(build)
    }

    override func viewWillAppear(animated: Bool) {
        
        self.activityIndicatior?.hidden=true;
        self.adActivityIndicatior?.hidesWhenStopped=true;

        if ((self.screenMode == GlobalConstants.BRANDS_SCREEN_MODE_CHANGE) ||
            (self.screenMode == GlobalConstants.BRANDS_SCREEN_MODE_SIGNUP)) {
                
                self.activityIndicatior?.hidden=false;
                self.activityIndicatior?.hidesWhenStopped=true;
                self.activityIndicatior?.startAnimating();
                
                /*
                DataManager.getTopAppsDataFromFileWithSuccess ("Brands",success: {(data) -> Void in
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                let parser = ResponseParser()
                self.brandsArray = parser.parseBrandJson(resstr)
                self.tableView.reloadData()
                */
                
                let fetcher = BOHttpfetcher()
                fetcher.fetchBrands({ (result) -> Void in
                    self.brandsArray = result as NSArray;
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.loadBrandsLogo()
                    })
                    
                })
        }
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
        
        let cell:BOBrandTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellBrand") as! BOBrandTableViewCell
        
        var brand:BrandModel
        
        if is_searching==true {
            brand = self.filteredBrands[indexPath.row] as BrandModel
        } else {
            brand = self.brandsArray[indexPath.row] as! BrandModel
        }
        
        
        switch (self.screenMode){
        case GlobalConstants.BRANDS_SCREEN_MODE_SEARCH:
            cell.categoryOrStoreNoLabel.hidden = true;
            cell.brandNameCentreLabel.text = brand.bName.capitalizedString;
            cell.brandNameCentreLabel.hidden = false;
        case GlobalConstants.BRANDS_SCREEN_MODE_SIGNUP:
            cell.categoryOrStoreNoLabel.text = brand.bCategory;
            cell.brandNameLabel.text = brand.bName.capitalizedString;
            cell.brandNameLabel.hidden = false;
        case GlobalConstants.BRANDS_SCREEN_MODE_CHANGE:
            cell.categoryOrStoreNoLabel.text = brand.bCategory;
            cell.brandNameLabel.text = brand.bName.capitalizedString;
            cell.brandNameLabel.hidden = false;
        default:
            self.navigationItem.title="";
        }
        
        
        

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
        if searchBar.text!.isEmpty{
            is_searching = false
            tableView.reloadData()
        } else {
            // print(" search text %@ ",searchBar.text! as NSString)
            is_searching = true
            self.filteredBrands.removeAll(keepCapacity: false)
            for var index = 0; index < self.brandsArray.count; index++
            {
                let brand: BrandModel = self.brandsArray.objectAtIndex(index) as! BrandModel
                
                let currentString = brand.bName as String
                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil {
                    self.filteredBrands+=[brand];
                }
            }
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // print("You selected cell #\(indexPath.row)!")
        
        var selectedBrand = BrandModel();
        let cat=CategoryModel();
        
        
        if is_searching==true {
            selectedBrand = self.filteredBrands[indexPath.row] as BrandModel
        } else {
            selectedBrand = self.brandsArray[indexPath.row] as! BrandModel
        }
        
        if ((self.account) != nil){
            self.account.brand=selectedBrand;
        }
        
        let catName = cat.getCatEnName(selectedBrand.bCategory);
        let arrayIndex = catName! + selectedBrand.bName;
        
        if (self.screenMode==GlobalConstants.BRANDS_SCREEN_MODE_SEARCH){
            self.selectedBrandStoresArray = self.brandStores[arrayIndex]!;
            performSegueWithIdentifier("ShowStoresSegue", sender: nil);
        }
        else if (self.screenMode==GlobalConstants.BRANDS_SCREEN_MODE_SIGNUP){
            performSegueWithIdentifier("segueShowStoreEntryForm", sender: nil);
        }
        else if (self.screenMode==GlobalConstants.BRANDS_SCREEN_MODE_CHANGE){
            self.delegate?.updateBrand(selectedBrand);
            self.navigationController?.popViewControllerAnimated(true);
        }
        

    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       // print (segue.identifier)
        
        if segue.identifier == "ShowStoresSegue"
        {
            if let destinationVC = segue.destinationViewController as? StoreViewController{
                destinationVC.brandId = self.brandId
                destinationVC.areaCode = self.areaCode
                destinationVC.storesArray = self.selectedBrandStoresArray;
                // Extrct stores for this brand from brandStores array 
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

    
    func loadBrandsLogo() {
        
        let path = NSBundle.mainBundle().pathForResource("logos", ofType:"plist")
        let dict = NSDictionary(contentsOfFile:path!)
        var counter = 0;
        let fetcher = BOHttpfetcher()
        
        
        for brand in self.brandsArray {
            let b:BrandModel = brand as! BrandModel;
            if ((dict?.valueForKey(b.bLogo)) != nil){
                // Load available logos
                //    println(" Logo Found: %@ ",&b.bLogo);
                let logoName = dict?.valueForKey(b.bLogo) as! String!;
                let logo:UIImage! = UIImage(named: logoName);
                b.bLogoImage = logo!;
                counter=counter+1;
                if (counter == self.brandsArray.count){
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.activityIndicatior?.stopAnimating()
                        self.tableView.reloadData()
                    })
                }
                
            }
            else {
                // Download missing logos
                print("missing:"+b.bLogo);
                
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
                                self.activityIndicatior?.stopAnimating()
                                self.tableView.reloadData()
                            })
                        }
                    })
                })
            }
        }
    }

    func adExists() {
        
        let cat=CategoryModel();
        let catName = cat.getCatEnName(self.selectedCategoryNameFa);
        
        if (catName != nil){
            let url = "https://buyoriginal.herokuapp.com/images/ads/ad."+areaCode+"."+catName!+".png";
            let nsurl = NSURL(string: url);
            let req = NSMutableURLRequest(URL: nsurl!)
            req.HTTPMethod = "HEAD"
            req.timeoutInterval = 0.5 // Adjust to your needs
            print (url);
            self.adActivityIndicatior?.startAnimating();
            NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
                if ((response as? NSHTTPURLResponse)?.statusCode ?? -1) == 200 {
                    print("Ad found");
                    if let data = NSData(contentsOfURL: nsurl!) {
                        self.adImgView.image = UIImage(data: data)
                        self.adImgView.hidden = false;
                        self.adTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "hideAd", userInfo: nil, repeats: true);
                    }
                }
                else {
                   print("Ad not found");
                   self.hideAd();
                }
            }
        }
        else {
            self.hideAd();
            print("catName not found");
        }
    }
    func hideAd() {
        self.adImgView.hidden = true;
        self.adActivityIndicatior?.stopAnimating();
    }
    
    
    
}

