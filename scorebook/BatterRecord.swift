//
//  BatterRecords.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2016. 12. 20..
//  Copyright © 2016년 Ha Hyunseon. All rights reserved.
//

import UIKit

class BatterRecord {

    var Games:(String, String, String){
        return ("G", "Games", "경기에 나온 수")
    }

    var AtBats:(String, String, String){
        return ("AB", "At Bats", "타수(타석의 수)")
    }
    
    var Hits:(String, String, String, String){
        return ("H", "Hits", "안타", "dddd.jpg")
    }
    
    var Doubles:(String, String, String, String){
        return ("2B", "Doubles", "2루타", "")
    }
    
    var Triples:(String, String, String){
        return ("3B", "Triples", "3루타")
    }
    
    var HomeRuns:(String, String, String){
        return ("HR", "Home Runs", "홈런")
    }
    
    var TotalBases:(String, String, String){
        return ("TB", "Total Bases", "총 루타")
    }
    
    var RunsScored:(String, String, String){
        return ("R", "Runs Scored", "득점")
    }
    
    var RunsBattedIn:(String, String, String){
        return ("RBI", "Runs Batted In", "타점")
    }
    
    var BasesOnBalls:(String, String, String){
        return ("BB", "Bases on Balls", "볼넷(4구)")
    }
    var IntentionalBaseOnBalls:(String, String, String){
        return ("IBB", "Intentional Base on Balls", "고의 4구")
    }
    
    var HitByPitch:(String, String, String){
        return ("HBP", "Hit By Pitch", "사구(몸에 맞는 볼)")
    }
    
    var StrikeOuts:(String, String, String){
        return ("K", "Strike Outs", "삼진(K)")
    }
    
    var StolenBases:(String, String, String){
        return ("SB", "Stolen Bases", "도루 성공")
    }
    
    var CaughtStealing:(String, String, String){
        return ("CS", "Caught Stealing", "도루 실패")
    }
    
    var StolenBasesPercentage:(String, String, String){
        return ("SB%", "Stolen Bases Percentage", "도루 성공율(%)")
    }
    
    var SacrificeFly:(String, String, String){
        return ("SF", "Sacrifice Fly", "희생 플라이")
    }
    
    var SacrificeHit:(String, String, String){
        return ("SH", "Sacrifice Hit", "희생 번트")
    }
    
    var BattingAverage:(String, String, String){
        return ("AVG", "Batting Average", "타율(%)")
    }
    
    var OnBasePercentage:(String, String, String){
        return ("OBP", "On Base Percentage", "출루율(%)")
    }
    
    var SluggingPercentage:(String, String, String){
        return ("SLG", "Slugging Percentage", "장타율(%)")
    }
    
    var OBPSLG:(String, String, String){
        return ("OPS", "OBP + SLG", "OPS(출루율 + 장타율)%")
    }
    
    var GroundOuts:(String, String, String){
        return ("GO", "Ground Outs", "땅볼 아웃")
    }
    
    var AirOuts:(String, String, String){
        return ("AO", "Air Outs", "플라이(뜬공) 아웃")
    }
    
    var GroundOutAirOuts:(String, String, String){
        return ("GO/AO", "Ground Outs/Air Outs", "땅볼/뜬공 비율(%)")
    }
    
    var GroundedIntoDoublePlay:(String, String, String){
        return ("GIDP", "Grounded Into Double Play", "땅볼에 의한 병살타")
    }
    
    var PinchAtBats:(String, String, String){
        return ("PAB", "Pinch At Bats", "대타자로 타석에 선 수")
    }
    
    var PinchHits:(String, String, String){
        return ("PH", "Pinch Hits", "대타자로 나와서 친 안타 수")
    }
    
    var PinchBattingAverage:(String, String, String){
        return ("PBA", "Pinch Batting Average", "대타 타율(%)")
    }
    
    var TotalPlateAppearances:(String, String, String){
        return ("TPA", "Total Plate Appearances", "총 타석")
    }
    
    var GrossProductionAverage:(String, String, String){
        return ("GPA", "Gross Production Average", "타자의 공격력(%)")
    }
    
    var RunsCreated:(String, String, String){
        return ("RC", "Runs Created", "득점 생산률(%)")
    }
    
    var RunsCreatedPer27Outs:(String, String, String){
        return ("RC/27", "Runs created per 27 outs", "9이닝동안 득점 생산률(%)")
    }
    
    var EquivalencyAverage:(String, String, String){
        return ("EQA", "Equivalency", "타자의 공격 성향(%)")
    }
    
}
