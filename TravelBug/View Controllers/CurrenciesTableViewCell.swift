//
//  CurrenciesTableViewCell.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 3/21/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class CurrenciesTableViewCell: UITableViewCell {

    @IBOutlet var countryFlagImageView: UIImageView!
    @IBOutlet var currencySymbolLabel: UILabel!
    @IBOutlet var currencyNameLabel: UILabel!
    @IBOutlet var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
