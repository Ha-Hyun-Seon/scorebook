//
//  RecordImageInfo.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 11..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

class RecordImageInfo {
    
    /*
     * Record View
     */
    //1루타
    var OneHit:String {
        get {
            return "RS_hit1base.png"
        }
    }
    
    //2루타
    var TwoHit:String {
        get {
            return "RS_hit2base.png"
        }
    }
    
    //3루타
    var ThreeHit:String {
        get {
            return "RS_hit3base.png"
        }
    }
    
    //홈런
    var HomeRun:String {
        get {
            return "RS_hit4base.png"
        }
    }
    
    //타자 간섭
    var BatterInterfere:String {
        get {
            return "RS_batterinterfere.png"
        }
    }
    
    //내야 번트
    var InfieldBunt:String {
        get {
            return "RS_infield_bunt.png"
        }
    }
    
    //번트 아웃
    var BuntOut:String {
        get {
            return "RS_buntout.png"
        }
    }
    
    //야수 선택
    var FielderIsChoice:String {
        get {
            return "RS_fielderIsChoice.png"
        }
    }
    
    //라인 드라이브
    var LineDrive:String {
        get {
            return "RS_LineDrive.png"
        }
    }
    
    //플라이 아웃
    var FlyOut:String {
        get {
            return "RS_flyout.png"
        }
    }
    
    //파울 플라이 아웃 ?
    var FoulFlyOut:String {
        get {
            return "RS_foulflyout.png"
        }
    }
    
    //4구
    var FourBall:String {
        get {
            return "RS_fourball.png"
        }
    }
    
    //내야 안타
    var InfieldHit:String {
        get {
            return "RS_infield_Hit1base.png"
        }
    }
    
    //타자가 투구에 맞다 ?  사구
    var HitByPitch:String {
        get {
            return "RS_hitbypitch.png"
        }
    }
    
    //고의 4구
    var IntentionalBall:String {
        get {
            return "RS_intentionalball.png"
        }
    }
    
    //낫아웃 (2스트라이크 이후에 추가로 스트라이크 판정을 받았으나 포수가 이 공을 놓칠 경우(잡기 전에 그라운드에 닿은 경우도 포함)를 가리키며, 이때 타자는 아직 아웃 당하지 않은 상태가 되어 1루로 뛸 수 있다.)
    var NotOut:String {
        get {
            return "RS_notout.png"
        }
    }
    
    //자책점
    var EarnedRun:String {
        get {
            return "RS_earnedRun.png"
        }
    }
    
    //반자책점
    var HalfEarnedRun:String {
        get {
            return "RS_half_earnedRun.png"
        }
    }
    
    //비자책점
    var NotEarnedRun:String {
        get {
            return "RS_not_earnedRun.png"
        }
    }
    
    //이닝끝남
    var InningEnd:String {
        get {
            return "RV_inningEnd.png"
        }
    }
    
    //잔루
    var LeftOnBase:String {
        get {
            return "RV_leftOnBase.png"
        }
    }
    
    //원아웃
    var OutCountOne:String {
        get {
            return "RS_outcount1.png"
        }
    }
    
    //투아웃
    var OutCountTwo:String {
        get {
            return "RS_outcount2.png"
        }
    }
    
    //쓰리아웃
    var OutCountThree:String {
        get {
            return "RS_outcount3.png"
        }
    }
    
    //스트라이크 아웃
    var StrikeOut:String {
        get {
            return "RS_strikeout.png"
        }
    }
    
    //1루주자의 견제
    var PitchingOneBCheckOut:String {
        get {
            return "RV_pitching_1BcheckOut.png"
        }
    }
    
    //2루주자의 견제
    var PitchingTwoBCheckOut:String {
        get {
            return "RV_pitching_2BcheckOut.png"
        }
    }
    
    //3루주자의 견제
    var PitchingThreeBCheckOut:String {
        get {
            return "RV_pitching_3BcheckOut.png"
        }
    }
    
    //볼
    var PitchingBall:String {
        get {
            return "RV_pitching_ball.png"
        }
    }
    
    //번트 파울
    var PitchingBuntFoul:String {
        get {
            return "RV_pitching_bfoul.png"
        }
    }
    
    //타격 완료
    var PitchingEnd:String {
        get {
            return "RV_pitching_end.png"
        }
    }
    
    //타격 파울
    var PitchingFoul:String {
        get {
            return "RV_pitching_foul.png"
        }
    }
    
    //그대로 보낸 스트라이크
    var PitchingStrike:String {
        get {
            return "RV_pitching_strike.png"
        }
    }
    
    //헛스윙/파울팁
    var PitchingSwing:String {
        get {
            return "RV_pitching_swing.png"
        }
    }
    
    //번트 헛스윙
    var PitchingBuntSwing:String {
        get {
            return "RV_pitching_BnoSwing.png"
        }
    }
    
    /*
     * PlayerRecordNumber
     */
    //2루 진루
    var TwoAdvanceArrows:String {
        get {
            return "PY_2AdvanceArrows.png"
        }
    }
    
    //3루 진루
    var ThreeAdvanceArrows:String {
        get {
            return "PY_3AdvanceArrows.png"
        }
    }
    
    //홈으로 진루
    var HomeAdvanceArrows:String {
        get {
            return "PY_4AdvanceArrows.png"
        }
    }
    
    //1번 타자 타점 이미지
    var ScoreRunOne:String {
        get {
            return "PY_scoreRun1.png"
        }
    }
    
    //2번 타자 타점 이미지
    var ScoreRunTwo:String {
        get {
            return "PY_scoreRun2.png"
        }
    }
    
    //3번 타자 타점 이미지
    var ScoreRunThree:String {
        get {
            return "PY_scoreRun3.png"
        }
    }
    
    //4번 타자 타점 이미지
    var ScoreRunFour:String {
        get {
            return "PY_scoreRun4.png"
        }
    }
    
    //5번 타자 타점 이미지
    var ScoreRunFive:String {
        get {
            return "PY_scoreRun5.png"
        }
    }
    
    //6번 타자 타점 이미지
    var ScoreRunSix:String {
        get {
            return "PY_scoreRun6.png"
        }
    }
    
    //7번 타자 타점 이미지
    var ScoreRunSeven:String {
        get {
            return "PY_scoreRun7.png"
        }
    }
    
    //8번 타자 타점 이미지
    var ScoreRunEight:String {
        get {
            return "PY_scoreRun8.png"
        }
    }
    
    //9번 타자 타점 이미지
    var ScoreRunNine:String {
        get {
            return "PY_scoreRun9.png"
        }
    }
    
    //1번 타자 이미지
    var NumberOne:String {
        get {
            return "PY_number1.png"
        }
    }
    
    //2번 타자 이미지
    var NumberTwo:String {
        get {
            return "PY_number2.png"
        }
    }
    
    //3번 타자 이미지
    var NumberThree:String {
        get {
            return "PY_number3.png"
        }
    }
    
    //4번 타자 이미지
    var NumberFour:String {
        get {
            return "PY_number4.png"
        }
    }
    
    //5번 타자 이미지
    var NumberFive:String {
        get {
            return "PY_number5.png"
        }
    }
    
    //6번 타자 이미지
    var NumberSix:String {
        get {
            return "PY_number6.png"
        }
    }
    
    //7번 타자 이미지
    var NumberSeven:String {
        get {
            return "PY_number7.png"
        }
    }
    
    //8번 타자 이미지
    var NumberEight:String {
        get {
            return "PY_number8.png"
        }
    }
    
    //9번 타자 이미지
    var NumberNine:String {
        get {
            return "PY_number9.png"
        }
    }
    
    /*
     * RunnerPlayerImage
     */
    //도루
    var StealImage:String {
        get {
            return "RP_stealimage.png"
        }
    }
    
    //더블스틸(이중도루)
    var DoubleStealImage:String {
        get {
            return "RP_doubleStealimage.png"
        }
    }
    
    //트리플스틸(삼중도루)
    var TripleStealImage:String {
        get {
            return "RP_tripleStealimage.png"
        }
    }
    
    //와일드피치(폭투)
    var WildPitch:String {
        get {
            return "RP_WildPitch.png"
        }
    }
    
    //패스트볼(포일) : 투수가 던진 공을 포수가 명백히 받을 수 있는 코스임에도 불구하고 빠뜨리는 경우를 말한다.
    var PassedBall:String {
        get {
            return "RP_PassedBall.png"
        }
    }
    
    //도루실패
    var StealError:String {
        get {
            return "RP_StealError.png"
        }
    }
    
    //보크 이미지 없음
    //에러 이미지 없음
    
}
