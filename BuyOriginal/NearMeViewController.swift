
import UIKit
class NearMeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noInternetConnectionView: UIView!
    
    var nearStoresArray = NSArray()
    var filteredStores = [StoreModel]()
    var brandId=0
    var is_searching=false   // It's flag for searching
    var selectedRow=0;
    var distance:Float=0.5;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        
        /*
        DataManager.getTopAppsDataFromFileWithSuccess ("NearStores",success: {(data) -> Void in
            let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
            let parser = ResponseParser()
            self.nearStoresArray = parser.parseStoresJson("", json: resstr)
            
            self.tableView.reloadData()
        })
        */
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        if (Utilities.isConnectedToNetwork() == false) {
            self.noInternetConnectionView.hidden = false
        }
        else {
            self.noInternetConnectionView.hidden = true
            fetchNearLocations(1);
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
            return self.filteredStores.count+1
        } else {
            return self.nearStoresArray.count+1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if (indexPath.row == 0)
        {
            let cell:BODisatnceTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellDistance") as! BODisatnceTableViewCell
            cell.distanceSlider.value=self.distance;
            return cell;
        }
        else {
            let cell:BONearmeTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellStore") as! BONearmeTableViewCell
            
            var store = self.nearStoresArray[indexPath.row-1] as! StoreModel
            
            if is_searching==true {
                store = self.filteredStores[indexPath.row-1] as StoreModel
            } else {
                store = self.nearStoresArray[indexPath.row-1] as! StoreModel
            }
            
            cell.bCategoryLabel.text = store.bCategory;
            cell.bNameLabel.text = store.bName.capitalizedString;
            cell.storeDistanceLabel.text = store.sDistance+" Km"
            
            cell.bLogoImageView.image=store.bLogoImage
            
            /*
            if (store.sDiscount==""){
                cell.bDiscountImageView.hidden = true;
            }
            */
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        self.selectedRow=indexPath.row-1;
        self.performSegueWithIdentifier("pushStoreDetails", sender: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (indexPath.row == 0){
            return 60;
        }
        else {
            return 80;
        }
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
            for var index = 0; index < self.nearStoresArray.count; index++
            {
                let store: StoreModel = self.nearStoresArray.objectAtIndex(index) as! StoreModel
                
                let currentString = store.bName as String
                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil {
                    self.filteredStores+=[store];
                }
            }
            tableView.reloadData()
        }
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let distValue = Int(sender.value)
        self.distance = sender.value;
        fetchNearLocations(distValue);
    }
    
    
    func fetchNearLocations(distance:Int){
        let fetcher = BOHttpfetcher()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var curLat="", curLon="";
        if SimulatorUtility.isRunningSimulator{
            curLat="35.793521";
            curLon="51.438165";
        }
        else {
            curLat = String(format:"%f",appDelegate.curLocationLat)
            curLon = String(format:"%f",appDelegate.curLocationLong)
        }
        
        fetcher.fetchStores ("all",distance:String(distance),lat:curLat,lon:curLon,areaCode:"",discount:false,completionHandler: {(result: NSArray) -> () in
            self.nearStoresArray = result
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
        
        
        for store in self.nearStoresArray {
            let s:StoreModel = store as! StoreModel;
            if ((dict?.valueForKey(s.bLogo)) != nil){
                // Load available logos
               // println(" Logo Found: %@ ",&s.bLogo);
                let logoName = dict?.valueForKey(s.bLogo) as! String!;
                let logo:UIImage! = UIImage(named: logoName);
                s.bLogoImage = logo!;
                counter=counter+1;
                if (counter == self.nearStoresArray.count){
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.sortStores()
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
                         //   println(" Logo Downloaded: %@ ",&s.bLogo);
                        }
                        else{
                            s.bLogoImage = UIImage(named:"brand.default")!;
                        }
                        counter=counter+1;
                        if (counter == self.nearStoresArray.count){
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
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "sDistance", ascending: true)
        let sortedResults: NSArray = nearStoresArray.sortedArrayUsingDescriptors([descriptor])
        self.nearStoresArray = sortedResults;
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "pushStoreDetails"
        {
            if let destinationVC = segue.destinationViewController as? StoreViewController{
                
                var store:StoreModel;
                
                if is_searching==true {
                    store = self.filteredStores[self.selectedRow] as StoreModel
                } else {
                    store = self.nearStoresArray[self.selectedRow] as! StoreModel
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
