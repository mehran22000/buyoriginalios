//
//  VerificationsViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2016-02-23.
//  Copyright © 2016 MandM. All rights reserved.
//

import UIKit

class VerificationsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var storesArray = NSArray()
    var verificationArray = NSArray()
    var selectedVerificationIndex = -1;
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatior: UIActivityIndicatorView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.activityIndicatior?.hidesWhenStopped = true;
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.loadVerificationImages();
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return verificationArray.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("tableView.cellForRowAtIndexPath");
        let verification = self.verificationArray[indexPath.row] as! VerificationModel
            
        let cell:BOVerificationCell = self.tableView.dequeueReusableCellWithIdentifier("verificationCell") as! BOVerificationCell
        
        cell.spinner.hidesWhenStopped = true;
        cell.descriptionLabel.text = verification.shortDesc;
        cell.title.text = verification.title;
        
        if ((verification.smallImage) != nil){
            cell.descriptionImageView.image=verification.smallImage;
            cell.spinner.stopAnimating();
        }
        else {
            cell.spinner.startAnimating();
        }
        
        
        
        /*
        if ((verification.largeImage != "") || (verification.largeImage != nil)){
            cell.continueLable.hidden = false;
        }
        else {
            cell.continueLable.hidden = true;
        }
        */
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        let verification = self.verificationArray[indexPath.row] as! VerificationModel
        self.selectedVerificationIndex = indexPath.row;
        if ((verification.largeImage != "") || (verification.largeImage != nil)){
            self.performSegueWithIdentifier("segueVerificationDetail", sender: nil)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }
    
    
    func loadVerificationImages() {
        
        var counter = 0;
        let fetcher = BOHttpfetcher()
        
        for verification in self.verificationArray {
            let v:VerificationModel = verification as! VerificationModel;
            if ((v.smallImage) == nil){
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    // do some task
                    fetcher.fetchVerificationImage(v.smallImageName, completionHandler: { (imgData) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            print("loadVerificationImage");
                            if ((imgData) != nil){
                                v.smallImage = UIImage(data: imgData)!;
                                 self.tableView.reloadData()
                            }
                            
                            counter=counter+1;
                            if (counter == self.verificationArray.count){
                                self.activityIndicatior?.stopAnimating()
                                
                        }
                    })
                })
            }}
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueVerificationDetail"
        {
            if let destinationVC = segue.destinationViewController as? VerificationsDetailsViewController {
                destinationVC.verification = self.verificationArray[self.selectedVerificationIndex] as! VerificationModel;
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
