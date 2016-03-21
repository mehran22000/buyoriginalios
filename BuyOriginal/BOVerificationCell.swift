//
//  BOVerificationCell.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2016-02-24.
//  Copyright © 2016 MandM. All rights reserved.
//

import UIKit

class BOVerificationCell: UITableViewCell {
    
    
    @IBOutlet var descriptionImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var continueLable: UIButton!
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}