//
//  Positions.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2016. 12. 20..
//  Copyright © 2016년 Ha Hyunseon. All rights reserved.
//

import UIKit

class Position {

    var Pitcher:(String, String, String, String){
        get{
            return ("P", "Picher", "투수", "1")
        }
    }

    var Catcher:(String, String, String, String){
        get{
            return ("C", "Catcher", "포수", "1")
        }
    }
    
    var FirstBaseman:(String, String, String, String){
        get{
            return ("1B", "First Baseman", "1루수", "3")
        }
    }
    
    var SecondBaseman:(String, String, String, String){
        get{
            return ("2B", "Second Baseman", "2루수", "4")
        }
    }
    
    var ThirdBaseman:(String, String, String, String){
        get{
            return ("3B", "Third Baseman", "3루수", "5")
        }
    }
    
    var ShortStop:(String, String, String, String){
        get{
            return ("SS", "Short Stop", "유격수", "6")
        }
    }
    
    var LeftFielder:(String, String, String, String){
        get{
            return ("LF", "Left Fielder", "좌익수", "7")
        }
    }
    
    var CenterFielder:(String, String, String, String){
        get{
            return ("CF", "Center Fielder", "중견수", "8")
        }
    }
    
    var RightFielder:(String, String, String, String){
        get{
            return ("RF", "Right Fielder", "우익수", "9")
        }
    }
    
    var DesigmatedHitter:(String, String, String, String){
        get{
            return ("DH", "Designated Hitter", "지명타자", "")
        }
    }
    
    var PinchHitter:(String, String, String, String){
        get{
            return ("PH", "Pinch Hitter", "대타자", "")
        }
    }
    
    var PinchRunner:(String, String, String, String){
        get{
            return ("PR", "Pinch Runner", "대주자", "")
        }
    }
    
    var StartingPitcher:(String, String, String, String){
        get{
            return ("SP", "Starting Picher", "선발 투수", "")
        }
    }
    
    var ReliefPitcher:(String, String, String, String){
        get{
            return ("RP", "Relief Picher", "구원 투수", "")
        }
    }
    
    var LongReliefPitcher:(String, String, String, String){
        get{
            return ("LRP", "Long Relief Picher", "롱맨", "")
        }
    }
    
    var MiddleReliefPitcher:(String, String, String, String){
        get{
            return ("MRP", "Middle Relief Pitcher", "미들맨", "")
        }
    }
    
    var SetupMan:(String, String, String, String){
        get{
            return ("SU", "Setup Man", "셋업맨", "")
        }
    }
    
    var ClosingPitcher:(String, String, String, String){
        get{
            return ("CP", "Closing Pitcher", "마무리 투수", "")
        }
    }
}
