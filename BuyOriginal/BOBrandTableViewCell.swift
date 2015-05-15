//
//  BOBrandTableViewCell.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-06.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BOBrandTableViewCell: UITableViewCell {
    
    @IBOutlet var brandImageView: UIImageView!
    @IBOutlet var brandNameLabel: UILabel!
    @IBOutlet var brandCategoryLabel: UILabel!
    @IBOutlet var brandNoStoreLabel: UILabel!
    @IBOutlet var brandNearLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}