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
    @IBOutlet var noInternetConnectionView: UIView!
    
    var selectedCategory:String="";
    var brandsArray = NSArray()
    var categoryBrands = [String:[BrandModel]]();
    var categoriesArray = [String]();
    var filteredCategorisArray = [String]();
    var brandStores = [String:[StoreModel]]();
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
                self.navigationItem.title="گروه ها";
            case GlobalConstants.CATEGORIES_SCREEN_MODE_SIGNUP:
                self.navigationItem.title="۳- گروه برند ";
            default:
                self.navigationItem.title="";
        }
        
        let backBtn = UIBarButtonItem(title: "شهر >", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        navigationItem.leftBarButtonItem = backBtn;
        
        
       // self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
      //  self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "welcome.pink")!);
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    
    override func viewWillAppear(animated: Bool) {
        let fetcher = BOHttpfetcher()
        
        self.activityIndicatior?.hidden=false;
        self.activityIndicatior?.hidesWhenStopped=true;
        self.activityIndicatior?.startAnimating();
        
        fetcher.fetchCityCategories (self.areaCode, completionHandler:{ (result: NSDictionary) -> () in
            
            if (result.count>0){
                self.brandsArray = result.objectForKey("brands") as! NSArray;
                self.categoryBrands = result.objectForKey("catBrands") as! Dictionary;
                self.brandStores = result.objectForKey("brandStores") as! Dictionary;
                self.categoriesArray = Array(self.categoryBrands.keys);
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.loadBrandsLogo()
                })
            }
            else {
                self.activityIndicatior?.stopAnimating();
            }
        })
        
        
        if (Utilities.isConnectedToNetwork() == false) {
            self.noInternetConnectionView.hidden = false
        }
        else {
            self.noInternetConnectionView.hidden = true
        }
        
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
            return self.filteredCategorisArray.count;
        }
        else {
            return self.categoriesArray.count;
        }
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
                print(" Logo Found: %@ ",b.bLogo);
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
    
    
    func loadCategoriesLogo(cell: BOCategoriesTableViewCell, cat: String ) {
        
       // var categoryBrands = [String:[BrandModel]]();
        var catbrandsArray = self.categoryBrands[cat];
        let brandNo = catbrandsArray!.count;
        
        let brand = catbrandsArray![0] as BrandModel;
        cell.logo1ImageView.image = brand.bLogoImage;
        cell.logo1ImageView.layer.borderColor = UIColor.blackColor().CGColor
        cell.logo1ImageView.layer.borderWidth = 0.5
        
        
        if (brandNo>2){
            let brand = catbrandsArray![1] as BrandModel;
            cell.logo2ImageView.image = brand.bLogoImage;
            cell.logo2ImageView.layer.borderColor = UIColor.blackColor().CGColor
            cell.logo2ImageView.layer.borderWidth = 0.5
        }
        
        if (brandNo>3){
            let brand = catbrandsArray![2] as BrandModel;
            cell.logo3ImageView.image = brand.bLogoImage;
            cell.logo3ImageView.layer.borderColor = UIColor.blackColor().CGColor
            cell.logo3ImageView.layer.borderWidth = 0.5
        }
        
        if (brandNo>4){
            let brand = catbrandsArray![3] as BrandModel;
            cell.logo4ImageView.image = brand.bLogoImage;
            cell.logo4ImageView.layer.borderColor = UIColor.blackColor().CGColor
            cell.logo4ImageView.layer.borderWidth = 0.5
        }
        
        if (brandNo>5){
            let brand = catbrandsArray![4] as BrandModel;
            cell.logo5ImageView.image = brand.bLogoImage;
            cell.logo5ImageView.layer.borderColor = UIColor.blackColor().CGColor
            cell.logo5ImageView.layer.borderWidth = 0.5
        }
        
        if (brandNo>6){
            let brand = catbrandsArray![5] as BrandModel;
            cell.logo6ImageView.image = brand.bLogoImage;
            cell.logo6ImageView.layer.borderColor = UIColor.blackColor().CGColor
            cell.logo6ImageView.layer.borderWidth = 0.5
        }
        
        if (brandNo>7){
            let brand = catbrandsArray![6] as BrandModel;
            cell.logo7ImageView.image = brand.bLogoImage;
            cell.logo7ImageView.layer.borderColor = UIColor.blackColor().CGColor
            cell.logo7ImageView.layer.borderWidth = 0.5
        }
        
        if (brandNo>8){
            let brand = catbrandsArray![7] as BrandModel;
            cell.logo8ImageView.image = brand.bLogoImage;
            cell.logo8ImageView.layer.borderColor = UIColor.blackColor().CGColor
            cell.logo8ImageView.layer.borderWidth = 0.5
            
        }
        

        if (brandNo>9){
            cell.brandCountLabel.text = "+" + String(brandNo - 9);
        }
        else {
            cell.brandCountLabel.hidden = true;
        }
    
        
    
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BOCategoriesTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellCategory") as! BOCategoriesTableViewCell
        
        var category="";
        
        
        if is_searching==true {
            category = self.filteredCategorisArray[indexPath.row] as String;
        } else {
            category = self.categoriesArray[indexPath.row] as String;
        }
        
        cell.categoryNameLabel.text = category;
        
        
        let cat=CategoryModel();
        let iconName = cat.getIconName(category);
        if (iconName != nil){
      //      cell.categoryImageView.image = UIImage(named:iconName! as String);
        }
        
        loadCategoriesLogo(cell,cat: category);
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    
        var c="";
        if is_searching==true {
            c = self.filteredCategorisArray[indexPath.row] as String;
            self.selectedCategory = c;
        } else {
            c = self.categoriesArray[indexPath.row] as String;
            self.selectedCategory = c;
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
        if searchBar.text!.isEmpty{
            is_searching = false
            tableView.reloadData()
        } else {
            print(" search text %@ ",searchBar.text! as NSString)
            is_searching = true
            self.filteredCategorisArray.removeAll(keepCapacity: false)
            for var index = 0; index < self.categoriesArray.count; index++
            {
                let cNameFa:String = categoriesArray[index] as String;
               
                if (cNameFa.lowercaseString.rangeOfString(searchText.lowercaseString) != nil)
                {
                    self.filteredCategorisArray+=[categoriesArray[index]];
                }
            }
            tableView.reloadData()
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
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
                destinationVC.brandsArray =  self.categoryBrands[self.selectedCategory]!;
            }
        }
        
    }
    
    @IBAction func backPressed () {
        self.navigationController?.popViewControllerAnimated(true);
    }

}
