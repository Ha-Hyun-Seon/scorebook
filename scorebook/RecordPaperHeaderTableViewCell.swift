//
//  RecordPaperHeaderTableViewCell.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 3. 16..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit


class RecordPaperHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var btnFirstInning: UIButton!
    @IBOutlet weak var btnSecondInning: UIButton!
    @IBOutlet weak var btnThirdInning: UIButton!
    @IBOutlet weak var btnFourthInning: UIButton!
    @IBOutlet weak var btnFifthInning: UIButton!
    @IBOutlet weak var btnSixthInning: UIButton!
    @IBOutlet weak var btnSeventhInning: UIButton!
    @IBOutlet weak var btnEighthInning: UIButton!
    @IBOutlet weak var btnNinthInning: UIButton!
    @IBOutlet weak var btnTenthInning: UIButton!
    @IBOutlet weak var btnEleventhInning: UIButton!
    @IBOutlet weak var btnTwelfthInning: UIButton!
    @IBOutlet weak var btnThirteenthInning: UIButton!
    @IBOutlet weak var btnFourteenthInning: UIButton!
    @IBOutlet weak var btnFifteenthInning: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
