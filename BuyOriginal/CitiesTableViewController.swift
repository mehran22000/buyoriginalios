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
    var citiesEn = ["esfahan","tehran","shiraz","Kish","Urmia"];
    var citiesFa = ["ارومیه" ,"کیش" ,"شیراز", "تهران","اصفهان"];
    var filteredCities:NSMutableArray = []
    var is_searching=false   // It's flag for searching

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView(frame: CGRectZero)
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> BOCityTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cityCell", forIndexPath: indexPath) as! BOCityTableViewCell
        
        
    
        switch (indexPath.row){
            case 0:
                cell.cityImageView.image = UIImage(named: "isfahan");
            case 1:
                cell.cityImageView.image = UIImage(named: "tehran");
            case 2:
                cell.cityImageView.image = UIImage(named: "kish");
            case 3:
                cell.cityImageView.image = UIImage(named: "shiraz");
            case 4:
                cell.cityImageView.image = UIImage(named: "urumiye");


            default:
                cell.cityImageView.image=nil
        }
        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
        switch (indexPath.row){
            case 0:
                self.selectedAreaCode="031"
            case 1:
                self.selectedAreaCode="021"
            case 2:
                self.selectedAreaCode="0711"
            case 3:
                self.selectedAreaCode="0811"
            case 4:
                self.selectedAreaCode="0811"
            default:
                self.selectedAreaCode=""
        }
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
            self.filteredCities=[];
            for var index = 0; index < self.filteredCities.count; index++
            {
                var currentString = citiesEn[index];
                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil {
                    self.filteredCities.addObject(currentString);
                }
                else if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil {
                    
                }
            }
            tableView.reloadData()
        }
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
                destinationVC.areaCode = self.selectedAreaCode
            }
        }
        
    }

}
