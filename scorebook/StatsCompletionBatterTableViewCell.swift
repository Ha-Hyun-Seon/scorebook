//
//  StatsCompletionTableViewCell.swift
//  scorebook
//
//  Created by L2H on 2017. 7. 20..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit

class StatsCompletionBatterTableViewCell: UITableViewCell {

    
    //타자정보
    @IBOutlet weak var batterUserName: UILabel!
    @IBOutlet weak var battersBox: UILabel!
    @IBOutlet weak var atBat: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var hits: UILabel!
    @IBOutlet weak var twoBaseHit: UILabel!
    @IBOutlet weak var threeBaseHit: UILabel!
    @IBOutlet weak var homeRun: UILabel!
    @IBOutlet weak var numberOfBase: UILabel!
    @IBOutlet weak var runBattedIn: UILabel!
    @IBOutlet weak var stolenBase: UILabel!
    @IBOutlet weak var caughtSteal: UILabel!
    @IBOutlet weak var sacrificeHit: UILabel!
    @IBOutlet weak var sacrificeFly: UILabel!
    @IBOutlet weak var fourBalls: UILabel!
    @IBOutlet weak var intentionalWalk: UILabel!
    @IBOutlet weak var hitByPitch: UILabel!
    @IBOutlet weak var strikeOut: UILabel!
    @IBOutlet weak var doublePlay: UILabel!
    @IBOutlet weak var leftOnBases: UILabel!
    
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
