//
//  StoreViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-06.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var storesArray = NSArray()
    var brandId=0
    let kDemoStores:String="[{\"brandId\":\"1\",\"name\":\"آریاپخش نقش جهان\",\"phoneNumber\":\"۳۶۳۰۴۹۲۷\",\"address\":\"اصفهان خیابان چهارباغ بالا\"}]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let backButton = UIBarButtonItem(title: "قبل > ", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 20)!], forState: UIControlState.Normal)
        //self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationItem.backBarButtonItem=backButton;
        
        DataManager.getTopAppsDataFromFileWithSuccess ("Stores",success: {(data) -> Void in
            let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
            let parser = ResponseParser()
            self.storesArray = parser.parseStoresJson(String(self.brandId),json:resstr)
            print(self.storesArray.count)
            self.tableView.reloadData()
        })
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storesArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:BOStoresTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellStore") as! BOStoresTableViewCell
        
        var store = self.storesArray[indexPath.row] as! StoreModel
        
        cell.storeNameLabel.text = self.storesArray[indexPath.row].name;
        
        cell.storeLocationLabel.text = store.storeLocation
        
        
        
        cell.storePhoneNumberLabel.text = self.storesArray[indexPath.row].phoneNumber;
        
        // cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
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
