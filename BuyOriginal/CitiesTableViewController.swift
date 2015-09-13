//
//  CitiesTableViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-06-20.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController,UISearchBarDelegate {
    
    var selectedAreaCode:String="";
    var cities = [CityModel]();
    var filteredCities=[CityModel]();
    var is_searching=false   // It's flag for searching
    var screenMode=1;
    var account:AccountModel!;
    var delegate: BuCityDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.initCities();
        
        let backBtn = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed");
        
        
        switch (self.screenMode){
            case GlobalConstants.CITIES_SCREEN_MODE_SEARCH:
                self.navigationItem.title="شهر";
            case GlobalConstants.CITIES_SCREEN_MODE_SIGNUP:
                self.navigationItem.title="۲-شهر";
                navigationItem.leftBarButtonItem = backBtn;
            case GlobalConstants.CITIES_SCREEN_MODE_CHANGE:
                self.navigationItem.title="تغییر شهر";
                navigationItem.leftBarButtonItem = backBtn;
            default:
                self.navigationItem.title="";
        }
        
        
       // self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
      //  self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "welcome.pink")!);
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func initCities() {
        var c = CityModel(cityName: "Tehran", areaCode: "021", cityNameFa: "تهران", imageName: "tehran");
        self.cities+=[c];
        c = CityModel(cityName: "Isfahan", areaCode: "031", cityNameFa: "اصفهان", imageName: "isfahan");
        self.cities+=[c];
        c = CityModel(cityName: "Kish", areaCode: "076", cityNameFa: "کیش", imageName: "kish");
        self.cities+=[c];
       // c = CityModel(cityName: "Urmia", areaCode: "0443", cityNameFa: "ارومیه", imageName: "urmia");
       // self.cities+=[c];
        c = CityModel(cityName: "Shiraz", areaCode: "071", cityNameFa: "شیراز", imageName: "shiraz");
        self.cities+=[c];
        c = CityModel(cityName: "Mashhad", areaCode: "051", cityNameFa: "مشهد", imageName: "mashhad");
        self.cities+=[c];
        c = CityModel(cityName: "Tabriz", areaCode: "051", cityNameFa: "تبریز", imageName: "tabriz");
        self.cities+=[c];
        c = CityModel(cityName: "Karaj", areaCode: "041", cityNameFa: "کرج", imageName: "karaj");
        self.cities+=[c];
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if is_searching==true {
            return self.filteredCities.count;
        }
        else {
            return self.cities.count;
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> BOCityTableViewCell {
        
        var cell:BOCityTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellCity") as! BOCityTableViewCell
        
        
        var cityImgName:String;
        if is_searching==true {
            var c:CityModel = self.filteredCities[indexPath.row] as CityModel;
            cityImgName = c.imageName;
        } else {
            var c:CityModel = self.cities[indexPath.row] as CityModel;
            cityImgName = c.imageName;
        }
        
        cell.cityImageView.image = UIImage(named: cityImgName);

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    
        var c:CityModel!
        if is_searching==true {
            c = self.filteredCities[indexPath.row] as CityModel;
            self.selectedAreaCode = c.areaCode;
        } else {
            c = self.cities[indexPath.row] as CityModel;
            self.selectedAreaCode = c.areaCode;
        }
        
        if (self.screenMode == GlobalConstants.CITIES_SCREEN_MODE_SIGNUP){
            self.account.sCity=c;
            self.performSegueWithIdentifier("pushAllBrands", sender: nil)
        }
        else if (self.screenMode == GlobalConstants.CITIES_SCREEN_MODE_CHANGE ){
            self.delegate?.updateCity(c);
            self.navigationController?.popViewControllerAnimated(true);
        }
        else {
            performSegueWithIdentifier("pushCategories", sender: nil)
        }
    }
    
    
    // Search Bar Delegates
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text.isEmpty{
            is_searching = false
            tableView.reloadData()
        } else {
            println(" search text %@ ",searchBar.text as NSString)
            is_searching = true
            self.filteredCities.removeAll(keepCapacity: false)
            for var index = 0; index < self.cities.count; index++
            {
                var cityEn:String = cities[index].cityName as String;
                var cityFa:String = cities[index].cityNameFa as String;
               
                if ((cityEn.lowercaseString.rangeOfString(searchText.lowercaseString) != nil) ||
                   (cityFa.lowercaseString.rangeOfString(searchText.lowercaseString) != nil))
                {
                    self.filteredCities+=[cities[index]];
                }
            }
            tableView.reloadData()
        }
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
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
        
        if segue.identifier == "pushCategories"
        {
            if let destinationVC = segue.destinationViewController as? CategoriesViewController{
                destinationVC.areaCode = self.selectedAreaCode
                destinationVC.screenMode=self.screenMode
                self.navigationItem.leftBarButtonItem?.title="";
                destinationVC.account = self.account
            }
        }
        
        if segue.identifier == "pushAllBrands"
        {
            if let destinationVC = segue.destinationViewController as? BrandViewController{
                destinationVC.account = self.account;
                destinationVC.screenMode=self.screenMode;
            }
        }
        
    }
    
    @IBAction func backPressed () {
        self.navigationController?.popViewControllerAnimated(true);
    }

}
