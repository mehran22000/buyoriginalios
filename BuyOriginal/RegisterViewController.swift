
import UIKit
class RegisterViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var screenMode=0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.screenMode==0){
            return 7;
        }
        else{
            return 2;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell;
        
        if (self.screenMode==0) {
            switch (indexPath.row){
            case 0:
                cell = self.tableView.dequeueReusableCellWithIdentifier("instructionCell") as! UITableViewCell
            case 1:
                cell = self.tableView.dequeueReusableCellWithIdentifier("nameCell") as! UITableViewCell
            case 2:
                cell = self.tableView.dequeueReusableCellWithIdentifier("brandCell") as! UITableViewCell
            case 3:
                cell = self.tableView.dequeueReusableCellWithIdentifier("addressCell") as! UITableViewCell
            case 4:
                cell = self.tableView.dequeueReusableCellWithIdentifier("phoneCell") as! UITableViewCell
            case 5:
                cell = self.tableView.dequeueReusableCellWithIdentifier("emailCell") as! UITableViewCell
            case 6:
                cell = self.tableView.dequeueReusableCellWithIdentifier("registerCell") as! UITableViewCell
            default:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
            }
        }
        else {
            switch (indexPath.row){
            case 0:
                cell = self.tableView.dequeueReusableCellWithIdentifier("confirmCell") as! UITableViewCell
            case 1:
                cell = self.tableView.dequeueReusableCellWithIdentifier("continueCell") as! UITableViewCell
            default:
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
            }
            
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }

    @IBAction func registerPressed(sender: UIButton) {
        self.screenMode = 1
        self.tableView.reloadData()
    }
    
    @IBAction func continuePressed(sender: UIButton) {
        self.screenMode = 0
        self.tableView.reloadData()
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
