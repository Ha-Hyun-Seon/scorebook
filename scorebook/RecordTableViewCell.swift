//
//  RecordTableViewCell.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 24..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit


class RecordTableViewCell: UITableViewCell {
    
    //기록지 표시 이미지
    @IBOutlet weak var ivRecord1: UIImageView!
    @IBOutlet weak var ivRecord2: UIImageView!
    @IBOutlet weak var ivRecord3: UIImageView!
    @IBOutlet weak var ivRecord4: UIImageView!
    @IBOutlet weak var ivRecord5: UIImageView!
    
    //기록지 표시 텍스트
    @IBOutlet weak var lblRecord1Text: UILabel!
    @IBOutlet weak var lblRecord2Text: UILabel!
    @IBOutlet weak var lblRecord3Text: UILabel!
    @IBOutlet weak var lblRecord4Text: UILabel!

    //기록지 선수 교체 텍스트
    @IBOutlet weak var lblRecordRunnerChange1: UILabel!
    @IBOutlet weak var lblRecordRunnerChange2: UILabel!
    @IBOutlet weak var lblRecordRunnerChange3: UILabel!
    
    //선수 등번호
    @IBOutlet weak var lblMemberNumber: UILabel!
    
    //루(1루, 2루, 3루)
    @IBOutlet weak var lblLocationNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


