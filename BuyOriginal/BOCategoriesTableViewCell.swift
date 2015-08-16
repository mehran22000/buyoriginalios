//
//  BOCategoriesTableViewCell.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2015-08-13.
//  Copyright (c) 2015 MandM. All rights reserved.
//

import UIKit

class BOCategoriesTableViewCell: UITableViewCell {

    @IBOutlet var logo1ImageView: UIImageView!
    @IBOutlet var logo2ImageView: UIImageView!
    @IBOutlet var logo3ImageView: UIImageView!
    @IBOutlet var logo4ImageView: UIImageView!
    @IBOutlet var logo5ImageView: UIImageView!
    @IBOutlet var logo6ImageView: UIImageView!
    @IBOutlet var logo7ImageView: UIImageView!
    @IBOutlet var logo8ImageView: UIImageView!
    @IBOutlet var logo9ImageView: UIImageView!
    @IBOutlet var brandCountLabel: UILabel!
    @IBOutlet var categoryNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
