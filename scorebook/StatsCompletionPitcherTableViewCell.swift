//
//  StatsCompletionPitcherTableViewCell.swift
//  scorebook
//
//  Created by L2H on 2017. 7. 20..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit

class StatsCompletionPitcherTableViewCell: UITableViewCell {

    //투수정보
    @IBOutlet weak var pitcheruserName: UILabel!
    @IBOutlet weak var numberOfPitches: UILabel!
    @IBOutlet weak var hitters: UILabel!
    @IBOutlet weak var opponentAtBat: UILabel!
    @IBOutlet weak var opponentHits: UILabel!
    @IBOutlet weak var opponenthomeRun: UILabel!
    @IBOutlet weak var opponentSacrificeHit: UILabel!
    @IBOutlet weak var opponentSacrificeFly: UILabel!
    @IBOutlet weak var opponentFourBalls: UILabel!
    @IBOutlet weak var opponentIntentionalWalk: UILabel!
    @IBOutlet weak var opponentHitByPitch: UILabel!
    @IBOutlet weak var opponentStrikeOut: UILabel!
    @IBOutlet weak var wildPitch: UILabel!
    @IBOutlet weak var balk: UILabel!
    @IBOutlet weak var lostPoint: UILabel!
    @IBOutlet weak var earnedRun: UILabel!
    @IBOutlet weak var inningCount: UILabel!
    @IBOutlet weak var outCount: UILabel!
    
    var visitedTeam : TeamInfo = TeamInfo()
    var homeTeam : TeamInfo = TeamInfo()
    var vPRecord : PRecordInfo = PRecordInfo()
    var hPRecord : PRecordInfo = PRecordInfo()
    var mainLineupInfo:[Lineup] = [Lineup]()
    
   
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
