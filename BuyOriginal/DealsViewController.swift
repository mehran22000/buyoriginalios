
import UIKit
class DealsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    var dealsStoresArray = NSArray()
    var filteredStores = [StoreModel]()
    var brandId=0
    var is_searching=false   // It's flag for searching
    var selectedRow=0;
    @IBOutlet var activityIndicatior: UIActivityIndicatorView?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        /*
        DataManager.getTopAppsDataFromFileWithSuccess ("Deals",success: {(data) -> Void in
            let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
            let parser = ResponseParser()
            /*
            self.dealsStoresArray = parser.parseStoresJson("", json: resstr)
            */
            self.tableView.reloadData()
        })
        */
        
        self.activityIndicatior?.startAnimating()
        self.activityIndicatior?.hidesWhenStopped=true
        fetchDeals(2);
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if is_searching==true {
            return self.filteredStores.count
        } else {
            return self.dealsStoresArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:BODealsTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellDeal") as! BODealsTableViewCell
        
        var store = self.dealsStoresArray[indexPath.row] as! StoreModel
        
        if is_searching==true {
            store = self.filteredStores[indexPath.row] as StoreModel
        } else {
            store = self.dealsStoresArray[indexPath.row] as! StoreModel
        }
        
        cell.storeDistanceLabel.text = store.sDistance+" Km"
        cell.brandCategoryLabel.text = store.bCategory
        cell.brandNameLabel.text = store.bName
        
        var image : UIImage = UIImage(named:store.bLogo)!
        cell.brandImageView.image=image;
        
        var imageName:NSString = discountImageName(store.sDiscount);
        image = UIImage(named:imageName as String)!;
        cell.dealImageView.image = image;
        
        return cell
        
    }
    
    func discountImageName(discount:Int)->NSString {
        return "discount_"+String(discount);

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        self.selectedRow=indexPath.row;
        self.performSegueWithIdentifier("pushStoreDetails", sender: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    // Search Bar Delegates
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text!.isEmpty{
            is_searching = false
            tableView.reloadData()
        } else {
            print(" search text %@ ",searchBar.text! as NSString)
            is_searching = true
            self.filteredStores.removeAll(keepCapacity: false)
            for var index = 0; index < self.dealsStoresArray.count; index++
            {
                var store: StoreModel = self.dealsStoresArray.objectAtIndex(index) as! StoreModel
                
                var currentString = store.bName as String
                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil {
                    self.filteredStores+=[store];
                }
            }
            tableView.reloadData()
        }
    }
    
    func fetchDeals(distance:Int){
        let fetcher = BOHttpfetcher()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var curLat = String(format:"%f",appDelegate.curLocationLat)
        var curLon = String(format:"%f",appDelegate.curLocationLong)
        
        // Test Data
        // ToDo: Remove
        // var curLat="32.637817";
        // var curLon="51.658522";
        
        fetcher.fetchStores ("all",distance:String(distance),lat:curLat,lon:curLon,areaCode:"",discount:true,completionHandler: {(result: NSArray) -> () in
            self.dealsStoresArray = result
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.loadBrandsLogo()
            })
        });
    }
    
    
    func loadBrandsLogo() {
        
        let path = NSBundle.mainBundle().pathForResource("logos", ofType:"plist")
        let dict = NSDictionary(contentsOfFile:path!)
        var counter = 0;
        let fetcher = BOHttpfetcher()
        
        if (self.dealsStoresArray.count==0){
            self.activityIndicatior?.hidden=true;
            self.activityIndicatior?.stopAnimating()
            return;
        }
        
        for store in self.dealsStoresArray {
            var s:StoreModel = store as! StoreModel;
            if ((dict?.valueForKey(s.bLogo)) != nil){
                // Load available logos
                // println(" Logo Found: %@ ",&s.bLogo);
                var logo:UIImage! = UIImage(named: s.bLogo);
                s.bLogoImage = logo!;
                counter=counter+1;
                if (counter == self.dealsStoresArray.count){
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.sortStores()
                        self.activityIndicatior?.hidden=true;
                        self.activityIndicatior?.stopAnimating()
                        self.tableView.reloadData()
                    })
                }
            }
            else {
                // Download missing logos
                
                fetcher.fetchBrandLogo(s.bLogo, completionHandler: { (imgData) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if ((imgData) != nil){
                            s.bLogoImage = UIImage(data: imgData)!;
                           // println(" Logo Downloaded: %@ ",&s.bLogo);
                        }
                        else{
                            s.bLogoImage = UIImage(named:"brand.default")!;
                        }
                        counter=counter+1;
                        if (counter == self.dealsStoresArray.count){
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.sortStores()
                                self.tableView.reloadData()
                            })
                        }
                    })
                })
            }
        }
    }
    
    func sortStores() {
        var descriptor: NSSortDescriptor = NSSortDescriptor(key: "sDistance", ascending: true)
        var sortedResults: NSArray = dealsStoresArray.sortedArrayUsingDescriptors([descriptor])
        self.dealsStoresArray = sortedResults;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "pushStoreDetails"
        {
            if let destinationVC = segue.destinationViewController as? StoreViewController{
                
                var store:StoreModel;
                
                if is_searching==true {
                    store = self.filteredStores[self.selectedRow] as StoreModel
                } else {
                    store = self.dealsStoresArray[self.selectedRow] as! StoreModel
                }
                destinationVC.storesArray=[store];
            }
        }
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
