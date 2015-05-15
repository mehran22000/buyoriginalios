//
//  BOStoresTableViewCell.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-06.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BOStoresTableViewCell: UITableViewCell {

    @IBOutlet var storeImageView: UIImageView!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var storeLocationLabel: UILabel!
    @IBOutlet var storeDistanceLabel: UILabel!
    @IBOutlet var storePhoneNumberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
