//
//  RecordPaperBodyTableViewCell.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 3. 15..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit


class RecordPaperBodyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblRunnerName: UILabel!
    @IBOutlet weak var lblAlternativeRunnerFirst: UILabel!
    @IBOutlet weak var lblAlternativeRunnerSecond: UILabel!
    // 1이닝
    @IBOutlet weak var ivPitcherRecord1: UIImageView!
    @IBOutlet weak var ivPitcherRecord2: UIImageView!
    @IBOutlet weak var ivPitcherRecord3: UIImageView!
    @IBOutlet weak var ivPitcherRecord4: UIImageView!
    @IBOutlet weak var ivPitcherRecord5: UIImageView!
    @IBOutlet weak var ivPitcherRecord6: UIImageView!
    @IBOutlet weak var ivPitcherRecord7: UIImageView!
    @IBOutlet weak var ivPitcherRecord8: UIImageView!
    
    @IBOutlet weak var ivBatterRecord1: UIImageView!
    @IBOutlet weak var ivBatterRecord2: UIImageView!
    @IBOutlet weak var ivBatterRecord3: UIImageView!
    @IBOutlet weak var ivBatterRecord4: UIImageView!
    @IBOutlet weak var ivBatterRecord5: UIImageView!
    
    @IBOutlet weak var lblBatterRecord1: UILabel!
    @IBOutlet weak var lblBatterRecord2: UILabel!
    @IBOutlet weak var lblBatterRecord3: UILabel!
    @IBOutlet weak var lblBatterRecord4: UILabel!
    // 2이닝
    @IBOutlet weak var ivPitcherRecord21: UIImageView!
    @IBOutlet weak var ivPitcherRecord22: UIImageView!
    @IBOutlet weak var ivPitcherRecord23: UIImageView!
    @IBOutlet weak var ivPitcherRecord24: UIImageView!
    @IBOutlet weak var ivPitcherRecord25: UIImageView!
    @IBOutlet weak var ivPitcherRecord26: UIImageView!
    @IBOutlet weak var ivPitcherRecord27: UIImageView!
    @IBOutlet weak var ivPitcherRecord28: UIImageView!
    
    @IBOutlet weak var ivBatterRecord21: UIImageView!
    @IBOutlet weak var ivBatterRecord22: UIImageView!
    @IBOutlet weak var ivBatterRecord23: UIImageView!
    @IBOutlet weak var ivBatterRecord24: UIImageView!
    @IBOutlet weak var ivBatterRecord25: UIImageView!
    
    @IBOutlet weak var lblBatterRecord21: UILabel!
    @IBOutlet weak var lblBatterRecord22: UILabel!
    @IBOutlet weak var lblBatterRecord23: UILabel!
    @IBOutlet weak var lblBatterRecord24: UILabel!
    // 3이닝
    @IBOutlet weak var ivPitcherRecord31: UIImageView!
    @IBOutlet weak var ivPitcherRecord32: UIImageView!
    @IBOutlet weak var ivPitcherRecord33: UIImageView!
    @IBOutlet weak var ivPitcherRecord34: UIImageView!
    @IBOutlet weak var ivPitcherRecord35: UIImageView!
    @IBOutlet weak var ivPitcherRecord36: UIImageView!
    @IBOutlet weak var ivPitcherRecord37: UIImageView!
    @IBOutlet weak var ivPitcherRecord38: UIImageView!
    
    @IBOutlet weak var ivBatterRecord31: UIImageView!
    @IBOutlet weak var ivBatterRecord32: UIImageView!
    @IBOutlet weak var ivBatterRecord33: UIImageView!
    @IBOutlet weak var ivBatterRecord34: UIImageView!
    @IBOutlet weak var ivBatterRecord35: UIImageView!
    
    @IBOutlet weak var lblBatterRecord31: UILabel!
    @IBOutlet weak var lblBatterRecord32: UILabel!
    @IBOutlet weak var lblBatterRecord33: UILabel!
    @IBOutlet weak var lblBatterRecord34: UILabel!
    // 4이닝
    @IBOutlet weak var ivPitcherRecord41: UIImageView!
    @IBOutlet weak var ivPitcherRecord42: UIImageView!
    @IBOutlet weak var ivPitcherRecord43: UIImageView!
    @IBOutlet weak var ivPitcherRecord44: UIImageView!
    @IBOutlet weak var ivPitcherRecord45: UIImageView!
    @IBOutlet weak var ivPitcherRecord46: UIImageView!
    @IBOutlet weak var ivPitcherRecord47: UIImageView!
    @IBOutlet weak var ivPitcherRecord48: UIImageView!
    
    @IBOutlet weak var ivBatterRecord41: UIImageView!
    @IBOutlet weak var ivBatterRecord42: UIImageView!
    @IBOutlet weak var ivBatterRecord43: UIImageView!
    @IBOutlet weak var ivBatterRecord44: UIImageView!
    @IBOutlet weak var ivBatterRecord45: UIImageView!
    
    @IBOutlet weak var lblBatterRecord41: UILabel!
    @IBOutlet weak var lblBatterRecord42: UILabel!
    @IBOutlet weak var lblBatterRecord43: UILabel!
    @IBOutlet weak var lblBatterRecord44: UILabel!
    // 5이닝
    @IBOutlet weak var ivPitcherRecord51: UIImageView!
    @IBOutlet weak var ivPitcherRecord52: UIImageView!
    @IBOutlet weak var ivPitcherRecord53: UIImageView!
    @IBOutlet weak var ivPitcherRecord54: UIImageView!
    @IBOutlet weak var ivPitcherRecord55: UIImageView!
    @IBOutlet weak var ivPitcherRecord56: UIImageView!
    @IBOutlet weak var ivPitcherRecord57: UIImageView!
    @IBOutlet weak var ivPitcherRecord58: UIImageView!
    
    @IBOutlet weak var ivBatterRecord51: UIImageView!
    @IBOutlet weak var ivBatterRecord52: UIImageView!
    @IBOutlet weak var ivBatterRecord53: UIImageView!
    @IBOutlet weak var ivBatterRecord54: UIImageView!
    @IBOutlet weak var ivBatterRecord55: UIImageView!
    
    @IBOutlet weak var lblBatterRecord51: UILabel!
    @IBOutlet weak var lblBatterRecord52: UILabel!
    @IBOutlet weak var lblBatterRecord53: UILabel!
    @IBOutlet weak var lblBatterRecord54: UILabel!
    // 6이닝
    @IBOutlet weak var ivPitcherRecord61: UIImageView!
    @IBOutlet weak var ivPitcherRecord62: UIImageView!
    @IBOutlet weak var ivPitcherRecord63: UIImageView!
    @IBOutlet weak var ivPitcherRecord64: UIImageView!
    @IBOutlet weak var ivPitcherRecord65: UIImageView!
    @IBOutlet weak var ivPitcherRecord66: UIImageView!
    @IBOutlet weak var ivPitcherRecord67: UIImageView!
    @IBOutlet weak var ivPitcherRecord68: UIImageView!
    
    @IBOutlet weak var ivBatterRecord61: UIImageView!
    @IBOutlet weak var ivBatterRecord62: UIImageView!
    @IBOutlet weak var ivBatterRecord63: UIImageView!
    @IBOutlet weak var ivBatterRecord64: UIImageView!
    @IBOutlet weak var ivBatterRecord65: UIImageView!
    
    @IBOutlet weak var lblBatterRecord61: UILabel!
    @IBOutlet weak var lblBatterRecord62: UILabel!
    @IBOutlet weak var lblBatterRecord63: UILabel!
    @IBOutlet weak var lblBatterRecord64: UILabel!
    // 7이닝
    @IBOutlet weak var ivPitcherRecord71: UIImageView!
    @IBOutlet weak var ivPitcherRecord72: UIImageView!
    @IBOutlet weak var ivPitcherRecord73: UIImageView!
    @IBOutlet weak var ivPitcherRecord74: UIImageView!
    @IBOutlet weak var ivPitcherRecord75: UIImageView!
    @IBOutlet weak var ivPitcherRecord76: UIImageView!
    @IBOutlet weak var ivPitcherRecord77: UIImageView!
    @IBOutlet weak var ivPitcherRecord78: UIImageView!
    
    @IBOutlet weak var ivBatterRecord71: UIImageView!
    @IBOutlet weak var ivBatterRecord72: UIImageView!
    @IBOutlet weak var ivBatterRecord73: UIImageView!
    @IBOutlet weak var ivBatterRecord74: UIImageView!
    @IBOutlet weak var ivBatterRecord75: UIImageView!
    
    @IBOutlet weak var lblBatterRecord71: UILabel!
    @IBOutlet weak var lblBatterRecord72: UILabel!
    @IBOutlet weak var lblBatterRecord73: UILabel!
    @IBOutlet weak var lblBatterRecord74: UILabel!
    // 8이닝
    @IBOutlet weak var ivPitcherRecord81: UIImageView!
    @IBOutlet weak var ivPitcherRecord82: UIImageView!
    @IBOutlet weak var ivPitcherRecord83: UIImageView!
    @IBOutlet weak var ivPitcherRecord84: UIImageView!
    @IBOutlet weak var ivPitcherRecord85: UIImageView!
    @IBOutlet weak var ivPitcherRecord86: UIImageView!
    @IBOutlet weak var ivPitcherRecord87: UIImageView!
    @IBOutlet weak var ivPitcherRecord88: UIImageView!
    
    @IBOutlet weak var ivBatterRecord81: UIImageView!
    @IBOutlet weak var ivBatterRecord82: UIImageView!
    @IBOutlet weak var ivBatterRecord83: UIImageView!
    @IBOutlet weak var ivBatterRecord84: UIImageView!
    @IBOutlet weak var ivBatterRecord85: UIImageView!
    
    @IBOutlet weak var lblBatterRecord81: UILabel!
    @IBOutlet weak var lblBatterRecord82: UILabel!
    @IBOutlet weak var lblBatterRecord83: UILabel!
    @IBOutlet weak var lblBatterRecord84: UILabel!
    // 9이닝
    @IBOutlet weak var ivPitcherRecord91: UIImageView!
    @IBOutlet weak var ivPitcherRecord92: UIImageView!
    @IBOutlet weak var ivPitcherRecord93: UIImageView!
    @IBOutlet weak var ivPitcherRecord94: UIImageView!
    @IBOutlet weak var ivPitcherRecord95: UIImageView!
    @IBOutlet weak var ivPitcherRecord96: UIImageView!
    @IBOutlet weak var ivPitcherRecord97: UIImageView!
    @IBOutlet weak var ivPitcherRecord98: UIImageView!
    
    @IBOutlet weak var ivBatterRecord91: UIImageView!
    @IBOutlet weak var ivBatterRecord92: UIImageView!
    @IBOutlet weak var ivBatterRecord93: UIImageView!
    @IBOutlet weak var ivBatterRecord94: UIImageView!
    @IBOutlet weak var ivBatterRecord95: UIImageView!
    
    @IBOutlet weak var lblBatterRecord91: UILabel!
    @IBOutlet weak var lblBatterRecord92: UILabel!
    @IBOutlet weak var lblBatterRecord93: UILabel!
    @IBOutlet weak var lblBatterRecord94: UILabel!
    // 10이닝
    @IBOutlet weak var ivPitcherRecord101: UIImageView!
    @IBOutlet weak var ivPitcherRecord102: UIImageView!
    @IBOutlet weak var ivPitcherRecord103: UIImageView!
    @IBOutlet weak var ivPitcherRecord104: UIImageView!
    @IBOutlet weak var ivPitcherRecord105: UIImageView!
    @IBOutlet weak var ivPitcherRecord106: UIImageView!
    @IBOutlet weak var ivPitcherRecord107: UIImageView!
    @IBOutlet weak var ivPitcherRecord108: UIImageView!
    
    @IBOutlet weak var ivBatterRecord101: UIImageView!
    @IBOutlet weak var ivBatterRecord102: UIImageView!
    @IBOutlet weak var ivBatterRecord103: UIImageView!
    @IBOutlet weak var ivBatterRecord104: UIImageView!
    @IBOutlet weak var ivBatterRecord105: UIImageView!
    
    @IBOutlet weak var lblBatterRecord101: UILabel!
    @IBOutlet weak var lblBatterRecord102: UILabel!
    @IBOutlet weak var lblBatterRecord103: UILabel!
    @IBOutlet weak var lblBatterRecord104: UILabel!
    // 11이닝
    @IBOutlet weak var ivPitcherRecord111: UIImageView!
    @IBOutlet weak var ivPitcherRecord112: UIImageView!
    @IBOutlet weak var ivPitcherRecord113: UIImageView!
    @IBOutlet weak var ivPitcherRecord114: UIImageView!
    @IBOutlet weak var ivPitcherRecord115: UIImageView!
    @IBOutlet weak var ivPitcherRecord116: UIImageView!
    @IBOutlet weak var ivPitcherRecord117: UIImageView!
    @IBOutlet weak var ivPitcherRecord118: UIImageView!
    
    @IBOutlet weak var ivBatterRecord111: UIImageView!
    @IBOutlet weak var ivBatterRecord112: UIImageView!
    @IBOutlet weak var ivBatterRecord113: UIImageView!
    @IBOutlet weak var ivBatterRecord114: UIImageView!
    @IBOutlet weak var ivBatterRecord115: UIImageView!
    
    @IBOutlet weak var lblBatterRecord111: UILabel!
    @IBOutlet weak var lblBatterRecord112: UILabel!
    @IBOutlet weak var lblBatterRecord113: UILabel!
    @IBOutlet weak var lblBatterRecord114: UILabel!
    // 12이닝
    @IBOutlet weak var ivPitcherRecord121: UIImageView!
    @IBOutlet weak var ivPitcherRecord122: UIImageView!
    @IBOutlet weak var ivPitcherRecord123: UIImageView!
    @IBOutlet weak var ivPitcherRecord124: UIImageView!
    @IBOutlet weak var ivPitcherRecord125: UIImageView!
    @IBOutlet weak var ivPitcherRecord126: UIImageView!
    @IBOutlet weak var ivPitcherRecord127: UIImageView!
    @IBOutlet weak var ivPitcherRecord128: UIImageView!
    
    @IBOutlet weak var ivBatterRecord121: UIImageView!
    @IBOutlet weak var ivBatterRecord122: UIImageView!
    @IBOutlet weak var ivBatterRecord123: UIImageView!
    @IBOutlet weak var ivBatterRecord124: UIImageView!
    @IBOutlet weak var ivBatterRecord125: UIImageView!
    
    @IBOutlet weak var lblBatterRecord121: UILabel!
    @IBOutlet weak var lblBatterRecord122: UILabel!
    @IBOutlet weak var lblBatterRecord123: UILabel!
    @IBOutlet weak var lblBatterRecord124: UILabel!
    // 13이닝
    @IBOutlet weak var ivPitcherRecord131: UIImageView!
    @IBOutlet weak var ivPitcherRecord132: UIImageView!
    @IBOutlet weak var ivPitcherRecord133: UIImageView!
    @IBOutlet weak var ivPitcherRecord134: UIImageView!
    @IBOutlet weak var ivPitcherRecord135: UIImageView!
    @IBOutlet weak var ivPitcherRecord136: UIImageView!
    @IBOutlet weak var ivPitcherRecord137: UIImageView!
    @IBOutlet weak var ivPitcherRecord138: UIImageView!
    
    @IBOutlet weak var ivBatterRecord131: UIImageView!
    @IBOutlet weak var ivBatterRecord132: UIImageView!
    @IBOutlet weak var ivBatterRecord133: UIImageView!
    @IBOutlet weak var ivBatterRecord134: UIImageView!
    @IBOutlet weak var ivBatterRecord135: UIImageView!
    
    @IBOutlet weak var lblBatterRecord131: UILabel!
    @IBOutlet weak var lblBatterRecord132: UILabel!
    @IBOutlet weak var lblBatterRecord133: UILabel!
    @IBOutlet weak var lblBatterRecord134: UILabel!
    // 14이닝
    @IBOutlet weak var ivPitcherRecord141: UIImageView!
    @IBOutlet weak var ivPitcherRecord142: UIImageView!
    @IBOutlet weak var ivPitcherRecord143: UIImageView!
    @IBOutlet weak var ivPitcherRecord144: UIImageView!
    @IBOutlet weak var ivPitcherRecord145: UIImageView!
    @IBOutlet weak var ivPitcherRecord146: UIImageView!
    @IBOutlet weak var ivPitcherRecord147: UIImageView!
    @IBOutlet weak var ivPitcherRecord148: UIImageView!
    
    @IBOutlet weak var ivBatterRecord141: UIImageView!
    @IBOutlet weak var ivBatterRecord142: UIImageView!
    @IBOutlet weak var ivBatterRecord143: UIImageView!
    @IBOutlet weak var ivBatterRecord144: UIImageView!
    @IBOutlet weak var ivBatterRecord145: UIImageView!
    
    @IBOutlet weak var lblBatterRecord141: UILabel!
    @IBOutlet weak var lblBatterRecord142: UILabel!
    @IBOutlet weak var lblBatterRecord143: UILabel!
    @IBOutlet weak var lblBatterRecord144: UILabel!
    // 15이닝
    @IBOutlet weak var ivPitcherRecord151: UIImageView!
    @IBOutlet weak var ivPitcherRecord152: UIImageView!
    @IBOutlet weak var ivPitcherRecord153: UIImageView!
    @IBOutlet weak var ivPitcherRecord154: UIImageView!
    @IBOutlet weak var ivPitcherRecord155: UIImageView!
    @IBOutlet weak var ivPitcherRecord156: UIImageView!
    @IBOutlet weak var ivPitcherRecord157: UIImageView!
    @IBOutlet weak var ivPitcherRecord158: UIImageView!
    
    @IBOutlet weak var ivBatterRecord151: UIImageView!
    @IBOutlet weak var ivBatterRecord152: UIImageView!
    @IBOutlet weak var ivBatterRecord153: UIImageView!
    @IBOutlet weak var ivBatterRecord154: UIImageView!
    @IBOutlet weak var ivBatterRecord155: UIImageView!
    
    @IBOutlet weak var lblBatterRecord151: UILabel!
    @IBOutlet weak var lblBatterRecord152: UILabel!
    @IBOutlet weak var lblBatterRecord153: UILabel!
    @IBOutlet weak var lblBatterRecord154: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
