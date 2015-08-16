//
//  CitiesTableViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-06-20.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    var selectedCategory:String="";
    var brandsArray = NSArray()
    var categories = [CategoryModel]();
    var filteredCategories=[CategoryModel]();
    var is_searching=false   // It's flag for searching
    var screenMode=1;
    var account:AccountModel!;
    var areaCode:String="";

    @IBOutlet var activityIndicatior: UIActivityIndicatorView?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        
        switch (self.screenMode){
            case GlobalConstants.CATEGORIES_SCREEN_MODE_SEARCH:
                self.navigationItem.title="طبقه بندی برند";
            case GlobalConstants.CATEGORIES_SCREEN_MODE_SIGNUP:
                self.navigationItem.title="۲- طبقه بندی برند ";
            default:
                self.navigationItem.title="";
        }
        
        let backBtn = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;
        
        
        let fetcher = BOHttpfetcher()
        
        fetcher.fetchCityBrands (self.areaCode, completionHandler:{ (result: NSArray) -> () in
            self.brandsArray = result
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.loadBrandsLogo()
            })
        })
        
        
       // self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
      //  self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "welcome.pink")!);
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if is_searching==true {
            return self.filteredCategories.count;
        }
        else {
            return self.categories.count;
        }
    }
    
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
                        self.activityIndicatior?.stopAnimating()
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
                                self.activityIndicatior?.stopAnimating()
                                self.tableView.reloadData()
                            })
                        }
                    })
                })
            }
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:BOCategoriesTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellCategory") as! BOCategoriesTableViewCell
        
        // retrieve brands available in stores for each category
        /*
        var cityImgName:String;
        if is_searching==true {
            var c:CityModel = self.filteredCities[indexPath.row] as CityModel;
            cityImgName = c.imageName;
        } else {
            var c:CityModel = self.cities[indexPath.row] as CityModel;
            cityImgName = c.imageName;
        }
        
        cell.cityImageView.image = UIImage(named: cityImgName);
        */
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    
        var c:CategoryModel!
        if is_searching==true {
            c = self.filteredCategories[indexPath.row] as CategoryModel;
            self.selectedCategory = c.cNameFa;
        } else {
            c = self.categories[indexPath.row] as CategoryModel;
            self.selectedCategory = c.cNameFa;
        }
        
        /*
        if ((self.account) != nil){
            self.account.sCity=c;
        }
        */
        
        performSegueWithIdentifier("pushBrands", sender: nil)
    }
    
    
    // Search Bar Delegates
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text.isEmpty{
            is_searching = false
            tableView.reloadData()
        } else {
            println(" search text %@ ",searchBar.text as NSString)
            is_searching = true
            self.filteredCategories.removeAll(keepCapacity: false)
            for var index = 0; index < self.categories.count; index++
            {
                var cNameFa:String = categories[index].cNameFa as String;
               
                if (cNameFa.lowercaseString.rangeOfString(searchText.lowercaseString) != nil)
                {
                    self.filteredCategories+=[categories[index]];
                }
            }
            tableView.reloadData()
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print (segue.identifier)
        
        if segue.identifier == "pushBrands"
        {
            if let destinationVC = segue.destinationViewController as? BrandViewController{
                destinationVC.areaCode = self.areaCode
                destinationVC.screenMode=self.screenMode
                self.navigationItem.leftBarButtonItem?.title="";
                destinationVC.account = self.account
                destinationVC.selectedCategoryNameFa = self.selectedCategory;
            }
        }
        
    }
    
    @IBAction func backPressed () {
        self.navigationController?.popViewControllerAnimated(true);
    }

}
