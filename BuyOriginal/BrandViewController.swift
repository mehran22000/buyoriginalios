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


class BrandViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var brandsArray = NSArray()
    var brands = kDemoBrands
    var brandId=0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        DataManager.getTopAppsDataFromFileWithSuccess ("Brands",success: {(data) -> Void in
            let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
            let parser = ResponseParser()
            self.brandsArray = parser.parseBrandJson(resstr)
            self.tableView.reloadData()
        })
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.brandsArray.count ;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:BOBrandTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellBrand") as! BOBrandTableViewCell
        var b:BrandModel = self.brandsArray[indexPath.row] as! BrandModel;
        cell.brandNameLabel.text = b.name;
        cell.brandCategoryLabel.text = b.category;
        cell.brandNoStoreLabel.text = b.storesNo;
    //    cell.brandNearLocationLabel.text = b.nearestLocation;
        var image : UIImage = UIImage(named:b.logo)!
        cell.brandImageView.image=image;
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        self.brandId=indexPath.row + 1
        
        performSegueWithIdentifier("ShowStoresSegue", sender: nil)
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
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

