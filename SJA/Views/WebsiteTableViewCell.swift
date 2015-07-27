//
//  WebsiteTableViewCell.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/27/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import UIKit

class WebsiteTableViewCell: UITableViewCell {

    @IBOutlet weak var websiteLabel: UILabel!
    
    var website = ""
    var websiteDictionary: NSDictionary?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
