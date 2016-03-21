//
//  VerificationsDetailsViewController.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2016-02-23.
//  Copyright © 2016 MandM. All rights reserved.
//

import UIKit

class VerificationsDetailsViewController: UIViewController {

    @IBOutlet var descriptionImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var activityIndicatior: UIActivityIndicatorView?;

    var verification = VerificationModel();

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadImage()
        
        self.descriptionLabel.text = self.verification.longDesc;
        self.descriptionLabel.sizeToFit();
        self.descriptionLabel.numberOfLines = 0;
        
        self.activityIndicatior?.hidden = false;
        self.activityIndicatior?.startAnimating()
        self.activityIndicatior?.hidesWhenStopped=true
        
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadImage() {
        let fetcher = BOHttpfetcher();
        fetcher.fetchVerificationImage(verification.largeImageName, completionHandler: { (imgData) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if ((imgData) != nil){
                    self.verification.largeImage = UIImage(data: imgData)!;
                    self.descriptionImageView.image = self.verification.largeImage;
                }
                self.activityIndicatior?.stopAnimating()
            })
        })
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
