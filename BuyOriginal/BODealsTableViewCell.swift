//
//  BODealsTableViewCell.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-05-22.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BODealsTableViewCell: UITableViewCell {

    @IBOutlet var storeImageView: UIImageView!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var brandNameLabel: UILabel!
    @IBOutlet var storeLocationLabel: UILabel!
    @IBOutlet var storeDistanceLabel: UILabel!
    @IBOutlet var brandCategoryLabel: UILabel!
    @IBOutlet var dealImageView: UIImageView!
    @IBOutlet var brandImageView: UIImageView!
    @IBOutlet var categoryImageView: UIImageView!
    
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
