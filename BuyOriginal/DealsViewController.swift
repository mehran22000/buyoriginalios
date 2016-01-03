
import UIKit
import CoreLocation

class DealsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noInternetConnectionView: UIView!
    
    var dealsStoresArray = NSArray()
    var filteredStores = [StoreModel]()
    var brandId=0
    var is_searching=false   // It's flag for searching
    var selectedRow=0;
    @IBOutlet var activityIndicatior: UIActivityIndicatorView?;
    @IBOutlet var noResultImageView: UIImageView!
    @IBOutlet var noResultLabel: UILabel!
    
    
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
        
        self.noResultImageView.hidden = true
        self.noResultLabel.hidden = true
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.activityIndicatior?.startAnimating()
        self.activityIndicatior?.hidesWhenStopped=true
        self.noResultImageView.hidden = true
        self.noResultLabel.hidden = true
        
        self.dealsStoresArray = NSArray()
        self.filteredStores = [StoreModel]()
        
        if (Utilities.isConnectedToNetwork() == false) {
            self.noInternetConnectionView.hidden = false
            self.activityIndicatior?.stopAnimating();
            self.noResultImageView.hidden = false
            self.noResultLabel.hidden = false
        }
        else {
            self.noInternetConnectionView.hidden = true
            fetchDeals(100);
        }
    
        
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
        
        let cell:BODealsTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellDeal") as! BODealsTableViewCell
        
        var store = self.dealsStoresArray[indexPath.row] as! StoreModel
        
        if is_searching==true {
            store = self.filteredStores[indexPath.row] as StoreModel
        } else {
            store = self.dealsStoresArray[indexPath.row] as! StoreModel
        }
        
        cell.storeDistanceLabel.text = store.sDistance+" Km"
       // cell.brandCategoryLabel.text = store.bCategory
       // cell.brandNameLabel.text = store.bName
        
        var image : UIImage = UIImage(named:store.bLogo)!
        cell.brandImageView.image=image;
       
        if (store.sDiscountPercentage>0){
            let imageName:NSString? = discountImageName(store.sDiscountPercentage);
            if (imageName != nil){
                image = UIImage(named:imageName! as String)!;
                cell.dealImageView.image = image;
            }
        }
        
        if ((store.sDiscountStartDateFa != nil) && (store.sDiscountEndDateFa != nil)) {
            cell.dateLabel.text = store.sDiscountStartDateFa + "-" + store.sDiscountEndDateFa;
        }
        else {
         //   let today = NSDate();
            cell.dateLabel.text="امروز";
        }
        
        /*
        let cat=CategoryModel();
        let iconName = cat.getIconName(store.bCategory);
        println(iconName);
        if (iconName != nil){
            cell.categoryImageView.image = UIImage(named:"Clothes");
        }
        */
        
        if ((store.sDiscountNote != nil) && (store.sDiscountNote != "")){
            cell.noteLabel.numberOfLines=0;
            cell.noteLabel.text = store.sDiscountNote;
      //      cell.noteLabel.textAlignment = .Left;
      //      cell.noteLabel.sizeToFit()
        }
        else {
            cell.noteLabel.text="";
            cell.announcementImageView.hidden = true;
        }

        
        return cell
        
    }
    
    func discountImageName(discount:Int)->NSString {
        
        var dis = discount;
        if (discount % 5 != 0){
            dis=(discount / 5 ) * 5;
        }
        
        return "discount_"+String(dis);
    
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        self.selectedRow=indexPath.row;
        self.performSegueWithIdentifier("pushStoreDetails", sender: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var store:StoreModel?;
        
        if is_searching==true {
            store = self.filteredStores[indexPath.row] as StoreModel
        } else {
            store = self.dealsStoresArray[indexPath.row] as? StoreModel
        }
        
        if ((store!.sDiscountNote == nil) && (store!.sDiscountEndDateFa != nil)){
            return 80;
        }
        else {
            return 115;
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
            for var index = 0; index < self.dealsStoresArray.count; index++
            {
                let store: StoreModel = self.dealsStoresArray.objectAtIndex(index) as! StoreModel
                
                let currentString = store.bName as String
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
        
        /*
        var curLat="", curLon="";
        if SimulatorUtility.isRunningSimulator{
            curLat="35.793521";
            curLon="51.438165";
        }
        else {
            curLat = String(format:"%f",appDelegate.curLocationLat)
            curLon = String(format:"%f",appDelegate.curLocationLong)
        }
        */
        
        var loc:CLLocationCoordinate2D = CLLocationCoordinate2D.init();
        loc = appDelegate.getUserLocation();
        let curLat = String(format:"%f",loc.latitude)
        let curLon = String(format:"%f",loc.longitude)
        
        
        // Test Data
        // ToDo: Remove
        // var curLat="43.667855";
        // var curLon="-79.395564";
        
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
            self.noResultImageView.hidden = false
            self.noResultLabel.hidden = false
            return;
        }
        
        for store in self.dealsStoresArray {
            let s:StoreModel = store as! StoreModel;
            if ((dict?.valueForKey(s.bLogo)) != nil){
                // Load available logos
                // println(" Logo Found: %@ ",&s.bLogo);
                let logo:UIImage! = UIImage(named: s.bLogo);
                s.bLogoImage = logo!;
                counter=counter+1;
                if (counter == self.dealsStoresArray.count){
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.sortStores()
                        self.activityIndicatior?.hidden=true;
                        self.activityIndicatior?.stopAnimating()
                        self.noResultImageView.hidden = true
                        self.noResultLabel.hidden = true
                        self.tableView.reloadData()
                    })
                }
            }
            else {
                // Download missing logos
                print("missing:"+s.bLogo);
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
                                self.activityIndicatior?.hidden=true;
                                self.activityIndicatior?.stopAnimating()
                                self.noResultImageView.hidden = false
                                self.noResultLabel.hidden = false
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
        let sortedResults: NSArray = dealsStoresArray.sortedArrayUsingDescriptors([descriptor])
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
                destinationVC.screenMode = GlobalConstants.STORES_SCREEN_MODE_DISCOUNT;
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
