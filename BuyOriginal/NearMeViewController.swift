
import UIKit
class NearMeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    var nearStoresArray = NSArray()
    var filteredStores = [StoreModel]()
    var brandId=0
    var is_searching=false   // It's flag for searching
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        DataManager.getTopAppsDataFromFileWithSuccess ("NearStores",success: {(data) -> Void in
            let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
            let parser = ResponseParser()
            self.nearStoresArray = parser.parseStoresJson("", json: resstr)
            
            self.tableView.reloadData()
        })
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Do any additional setup after loading the view.
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
            return self.filteredStores.count
        } else {
            return self.nearStoresArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:BONearmeTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellNearMeBrand") as! BONearmeTableViewCell
        
        var store = self.nearStoresArray[indexPath.row] as! StoreModel
        
        if is_searching==true {
            store = self.filteredStores[indexPath.row] as StoreModel
        } else {
            store = self.nearStoresArray[indexPath.row] as! StoreModel
        }
        
        cell.storeNameLabel.text = store.sName;
        cell.storeLocationLabel.text = store.sAddress
        cell.storeDistanceLabel.text = store.sDistance
        cell.brandCategoryLabel.text = store.bCategory
        cell.brandNameLabel.text = store.bName
        
        var image : UIImage = UIImage(named:store.bLogo)!
        cell.brandImageView.image=image;
        
        if (store.sDiscount==""){
            cell.dealImageView.hidden = true;
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    // Search Bar Delegates
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text.isEmpty{
            is_searching = false
            tableView.reloadData()
        } else {
            println(" search text %@ ",searchBar.text as NSString)
            is_searching = true
            self.filteredStores.removeAll(keepCapacity: false)
            for var index = 0; index < self.nearStoresArray.count; index++
            {
                var store: StoreModel = self.nearStoresArray.objectAtIndex(index) as! StoreModel
                
                var currentString = store.bName as String
                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil {
                    self.filteredStores+=[store];
                }
            }
            tableView.reloadData()
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
