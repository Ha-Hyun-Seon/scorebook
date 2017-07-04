//
//  PitchingState.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 22..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

enum RecordState : String {
    
    
    func String()->String {
        return self.rawValue
    }
    
    init(defaultValue:Any) {
        self = .Default
    }
    
//    case Strike = "RV_pitching_strike.png"
//    case Ball = "RV_pitching_Ball.png"
    
    case Default = ""
    
    //1루타
    case OneHit = "RS_hit1base.png"
    
    //2루타
    case TwoHit = "RS_hit2base.png"
    
    //3루타
    case ThreeHit = "RS_hit3base.png"
    
    //홈런
    case HomeRun = "RS_hit4base.png"
    
    //타자 간섭
    case BatterInterfere = "RS_batterinterfere.png"
    
    //내야 번트
    case InfieldBunt = "RS_infield_bunt.png"
    
    //번트 아웃
    case BuntOut = "RS_buntout.png"
    
    //야수 선택
    case FielderIsChoice = "RS_fielderIsChoice.png"
    
    //라인 드라이브
    case LineDrive = "RS_LineDrive.png"
    
    //플라이 아웃
    case FlyOut = "RS_flyout.png"
    
    //파울 플라이 아웃 ?
    case FoulFlyOut = "RS_foulflyout.png"
    
    //4구
    case FourBall = "RS_fourball.png"
    
    //내야 안타
    case InfieldHit = "RS_infield_Hit1base.png"
    
    //타자가 투구에 맞다 ?   사구
    case HitByPitch = "RS_hitbypitch.png"
    
    //고의 4구
    case IntentionalBall = "RS_intentionalball.png"
    
    //낫아웃 (2스트라이크 이후에 추가로 스트라이크 판정을 받았으나 포수가 이 공을 놓칠 경우(잡기 전에 그라운드에 닿은 경우도 포함)를 가리키며, 이때 타자는 아직 아웃 당하지 않은 상태가 되어 1루로 뛸 수 있다.)
    case NotOut = "RS_notout.png"
    
    //자책점
    case EarnedRun = "RS_earnedRun.png"
    
    //반자책점
    case HalfEarnedRun = "RS_half_earnedRun.png"
    
    //비자책점
    case NotEarnedRun = "RS_not_earnedRun.png"
    
    //이닝끝남
    case InningEnd = "RV_inningEnd.png"
    
    //잔루
    case LeftOnBase = "RV_leftOnBase.png"
    
    //원아웃
    case OutCountOne = "RS_outcount1.png"
    
    //투아웃
    case OutCountTwo = "RS_outcount2.png"
    
    //쓰리아웃
    case OutCountThree = "RS_outcount3.png"
    
    //스트라이크 아웃
    case StrikeOut = "RS_strikeout.png"
    
    //1루주자의 견제
    case PitchingOneBCheckOut = "RV_pitching_1BcheckOut.png"
    
    //2루주자의 견제
    case PitchingTwoBCheckOut = "RV_pitching_2BcheckOut.png"
    
    //3루주자의 견제
    case PitchingThreeBCheckOut = "RV_pitching_3BcheckOut.png"
    
    //볼
    case PitchingBall = "RV_pitching_ball.png"
    
    //번트 파울
    case PitchingBuntFoul = "RV_pitching_bfoul.png"
    
    //타격 완료
    case PitchingEnd = "RV_pitching_end.png"
    
    //타격 파울
    case PitchingFoul = "RV_pitching_foul.png"
    
    //그대로 보낸 스트라이크
    case PitchingStrike = "RV_pitching_strike.png"
    
    //헛스윙/파울팁
    case PitchingSwing = "RV_pitching_swing.png"
    
    //번트 헛스윙
    case PitchingBuntSwing = "RV_pitching_BnoSwing.png"
    
    /*
     * PlayerRecordNumber
     */
    //2루 진루
    case TwoAdvanceArrows = "PY_2AdvanceArrows.png"
    
    //3루 진루
    case ThreeAdvanceArrows = "PY_3AdvanceArrows.png"
    
    //홈으로 진루
    case HomeAdvanceArrows = "PY_4AdvanceArrows.png"
    
    //1번 타자 타점 이미지
    case ScoreRunOne = "PY_scoreRun1.png"
    
    //2번 타자 타점 이미지
    case ScoreRunTwo = "PY_scoreRun2.png"
    
    //3번 타자 타점 이미지
    case ScoreRunThree = "PY_scoreRun3.png"
    
    //4번 타자 타점 이미지
    case ScoreRunFour = "PY_scoreRun4.png"
    
    //5번 타자 타점 이미지
    case ScoreRunFive = "PY_scoreRun5.png"
    
    //6번 타자 타점 이미지
    case ScoreRunSix = "PY_scoreRun6.png"
    
    //7번 타자 타점 이미지
    case ScoreRunSeven = "PY_scoreRun7.png"
    
    //8번 타자 타점 이미지
    case ScoreRunEight = "PY_scoreRun8.png"
    
    //9번 타자 타점 이미지
    case ScoreRunNine = "PY_scoreRun9.png"
    
    //1번 타자 이미지
    case NumberOne = "PY_number1.png"
    
    //2번 타자 이미지
    case NumberTwo = "PY_number2.png"
    
    //3번 타자 이미지
    case NumberThree = "PY_number3.png"
    
    //4번 타자 이미지
    case NumberFour = "PY_number4.png"
    
    //5번 타자 이미지
    case NumberFive = "PY_number5.png"
    
    //6번 타자 이미지
    case NumberSix = "PY_number6.png"
    
    //7번 타자 이미지
    case NumberSeven = "PY_number7.png"
    
    //8번 타자 이미지
    case NumberEight = "PY_number8.png"
    
    //9번 타자 이미지
    case NumberNine = "PY_number9.png"
    
    /*
     * RunnerPlayerImage
     */
    //도루
    case StealImage = "RP_stealimage.png"
    
    //더블스틸(이중도루)
    case DoubleStealImage = "RP_doubleStealimage.png"
    
    //트리플스틸(삼중도루)
    case TripleStealImage = "RP_tripleStealimage.png"
    
    //와일드피치(폭투)
    case WildPitch = "RP_WildPitch.png"
    
    //패스트볼(포일) : 투수가 던진 공을 포수가 명백히 받을 수 있는 코스임에도 불구하고 빠뜨리는 경우를 말한다.
    case PassedBall = "RP_PassedBall.png"
    
    //도루실패
    case StealError = "RP_StealError.png"
    
    //보크 이미지 없음
    //에러 이미지 없음
    
    
    //연속진루
    case AdvanceArrow = "연속진루"
    
}
