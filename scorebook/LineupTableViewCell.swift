//
//  LineupTableViewCell.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 7..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit


class LineupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMemberNumber: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

