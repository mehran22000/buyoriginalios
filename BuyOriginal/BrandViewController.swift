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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let fetcher = BOHttpfetcher()
        fetcher.fetchBrands { (result: NSArray) -> () in
            self.brandsArray = result
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
        
        /*
        DataManager.getTopAppsDataFromFileWithSuccess ("Brands",success: {(data) -> Void in
            let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
            let parser = ResponseParser()
            self.brandsArray = parser.parseBrandJson(resstr)

            self.tableView.reloadData()
        })
        */

        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // GA
        var tracker:GAITracker = GAI.sharedInstance().defaultTracker as GAITracker
        tracker.set(kGAIScreenName, value:"Home Screen")
        var build = GAIDictionaryBuilder.createScreenView().build() as [NSObject : AnyObject]
        tracker.send(build)
        
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
        
        
        cell.brandNameLabel.text = brand.bName;
        cell.brandCategoryLabel.text = brand.bCategory;
        
        // Load Logo Image
        let fetcher = BOHttpfetcher()
        fetcher.fetchBrandLogo(brand.bLogo, completionHandler: { (imgData) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.brandImageView.image = UIImage(data: imgData);
                cell.brandImageView.layer.cornerRadius = 8.0
                cell.brandImageView.clipsToBounds = true
                
                })
            })
        
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
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
        var selectedBrand = self.brandsArray[indexPath.row] as! BrandModel
        
        self.brandId=selectedBrand.bId;
        
        performSegueWithIdentifier("ShowStoresSegue", sender: nil)
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
            }
        }
    }

    
    
    
    
}

