//
//  BONearmeTableViewCell.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-22.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BONearmeTableViewCell: UITableViewCell {

    @IBOutlet var bNameLabel: UILabel!
    @IBOutlet var bLogoImageView: UIImageView!
    @IBOutlet var storeDistanceLabel: UILabel!
    @IBOutlet var bCategoryLabel: UILabel!
    @IBOutlet var bDiscountImageView: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}