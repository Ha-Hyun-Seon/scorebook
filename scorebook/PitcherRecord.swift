//
//  PitcherRecord.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2016. 12. 22..
//  Copyright © 2016년 Ha Hyunseon. All rights reserved.
//

import Foundation


class PicherRecord {
    
    var Games:(String, String, String){
        return ("G", "Games", "경기에 나온 수")
    }
    
    var Wins:(String, String, String){
        return ("W", "Wins", "승(경기 승리)")
    }
    
    var Losses:(String, String, String){
        return ("L", "Losses", "패(경기 패배)")
    }
}
