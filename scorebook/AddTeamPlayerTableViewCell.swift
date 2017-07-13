//
//  AddTeamPlayerTableViewCell.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 24..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit

class AddTeamPlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var cellPlayerNumberLabel: UILabel!
    @IBOutlet weak var cellPlayerNameLabel: UILabel!
    @IBOutlet weak var cellPositionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
