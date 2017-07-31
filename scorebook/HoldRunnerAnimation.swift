//
//  RuunerAnimation.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 23..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation
import UIKit


class HoldRunnerAnimation {
    
    //주자 정의
    //고정된 주자
    var runner1 : UIButton = UIButton()
    var runner2 : UIButton = UIButton()
    var runner3 : UIButton = UIButton()
    
    //달리는 주자
    var runnerH_1 : UIButton = UIButton()
    var runner1_2 : UIButton = UIButton()
    var runner2_3 : UIButton = UIButton()
    var runner3_H : UIButton = UIButton()
    
    var runnerState : RunnerState = RunnerState.Default
    
    //중간 입력 상태
    var addActionState : AddActionState
    
    //루상 주자 체크
    var isOneRunner : Bool = false
    var isTwoRunner : Bool = false
    var isThreeRunner : Bool = false
    
    //주자별 기록지(타자, 1루, 2루, 3루, 홈)
    var currentHRecord : HRecordInfo = HRecordInfo()
    var oneRunnerHRecord : HRecordInfo = HRecordInfo()
    var twoRunnerHRecord : HRecordInfo = HRecordInfo()
    var threeRunnerHRecord : HRecordInfo = HRecordInfo()
    var homeRunnerHRecordList : [HRecordInfo] = [HRecordInfo]()
    
    //주자별 임시 기록지
    var oneHalfRunnerHRecord : HRecordInfo = HRecordInfo()
    var twoHalfRunnerHRecord : HRecordInfo = HRecordInfo()
    var threeHalfRunnerHRecord : HRecordInfo = HRecordInfo()
    
    
    var tempOneRunnerHRecord : HRecordInfo = HRecordInfo()
    var tempTwoRunnerHRecord : HRecordInfo = HRecordInfo()
    var tempThreeRunnerHRecord : HRecordInfo = HRecordInfo()
    var tempHomeRunnerHRecordList : [HRecordInfo] = [HRecordInfo]()
    var tempRunnerHRecord : HRecordInfo = HRecordInfo()
    
    //주자 포지션
    var runnerPosition : RunnerPosition = RunnerPosition.Default
    
    //기록 상태
    var recordState : RecordState = RecordState.Default
    
    //득점 상황
    var isHomein : Bool = false
    var homeinLocation : String = ""
    
    var isBatter : Bool = false
    
    //달리는 주자 이미지
    let runnerImageName = "RV_runner_btn.png"
    let runnerGrayImageName = "RV_runner_gray_btn.png"
    
    var completeDelegate : RunnerAnimationComplete?
    
    init(runner1 : UIButton, runner2 : UIButton, runner3 : UIButton, runnerH_1 : UIButton, runner1_2 : UIButton, runner2_3 : UIButton, runner3_H : UIButton, currentHRecord : HRecordInfo, oneRunnerHRecord : HRecordInfo, twoRunnerHRecord : HRecordInfo, threeRunnerHRecord : HRecordInfo, homeRunnerHRecordList: [HRecordInfo], tempRunnerHRecord : HRecordInfo, oneHalfRunnerHRecord : HRecordInfo, twoHalfRunnerHRecord : HRecordInfo, threeHalfRunnerHRecord : HRecordInfo, runnerState : RunnerState, runnerPosition : RunnerPosition, recordState : RecordState, addActionState : AddActionState) {
        
        self.runner1 = runner1
        self.runner2 = runner2
        self.runner3 = runner3
        self.runnerH_1 = runnerH_1
        self.runner1_2 = runner1_2
        self.runner2_3 = runner2_3
        self.runner3_H = runner3_H
        self.currentHRecord = currentHRecord
        self.tempOneRunnerHRecord = oneRunnerHRecord
        self.tempTwoRunnerHRecord = twoRunnerHRecord
        self.tempThreeRunnerHRecord = threeRunnerHRecord
        self.tempHomeRunnerHRecordList = homeRunnerHRecordList
        self.tempRunnerHRecord = tempRunnerHRecord
        self.oneHalfRunnerHRecord = oneHalfRunnerHRecord
        self.twoHalfRunnerHRecord = twoHalfRunnerHRecord
        self.threeHalfRunnerHRecord = threeHalfRunnerHRecord
        self.runnerState = runnerState
        self.recordState = recordState
        self.runnerPosition = runnerPosition
        self.addActionState = addActionState
        
    }
    
    func RunnerAnimation() {
        
        //루 이동은 무조건 한루
        if runnerPosition == .OneRunner {
            
            oneRunnerInit()
            
            switch runnerState {
            case .Default:
                self.runnerState = .RunnerState1
                self.oneRunnerHRecord = self.currentHRecord
            case .RunnerState1:
                //1루만 있을 경우 - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .Default     //없음
                    oneSTO1()
                } else {
                    self.runnerState = .RunnerState5
                    oneRunner()
                }
            case .RunnerState2:
                //1,2루만 있을 경우 - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState18     //2H
                    twoHalfRun()
                    oneSTO1()
                    
                    //                    self.oneRunnerHRecord.oneRecordText +=
                } else {
                self.runnerState = .RunnerState19
                oneRunner()
                twoHalfRun()
                }
                
            case .RunnerState3:
                //1,2,3 - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState22     //2H,3H
                    twoHalfRun()
                    threeHalfRun()
                    oneSTO1()
                } else {
                self.runnerState = .RunnerState26   // 2, 2H, 3H
                oneRunner()
                self.twoRunnerInit()
                self.twoRunnerHalfMove()
                self.threeRunnerInit()
                self.threeRunnerHalfMove()
                self.twoHalfRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeHalfRunnerHRecord = self.tempThreeRunnerHRecord
                }
            case .RunnerState4:
                //1,3루만 있을 경우 - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState23     //3H
                    threeHalfRun()
                    oneSTO1()
                } else {
                self.runnerState = .RunnerState20
                oneRunner()
                self.threeRunnerInit()
                self.threeRunnerHalfMove()
                self.threeHalfRunnerHRecord = self.tempThreeRunnerHRecord
                }
                
            case .RunnerState10:
                //1H만 있을 경우 - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState1    //1
                    oneHalfBack()
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .Default     //없음
                    oneSTO2()
                } else {
                    //진루
                self.runnerState = .RunnerState5    //2
                oneHalfRunner()
                }
            case .RunnerState11:
                //1H,2H
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState14   //1,2H
                    oneHalfBack()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState18   //2H
                    oneSTO2()
                } else {
                    //진루
                self.runnerState = .RunnerState19   //2,2H
                oneHalfRunner()
                }
                
            case .RunnerState12:
                //1H,2(진루안됨)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState2    //1,2
                    oneHalfBack()
                    twoRunnerNoMove2()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState5    //2
                    oneSTO2()
                    
                } else {
                    //진루 안됨
                }
                
            case .RunnerState13:
                //1H, 3 - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState4    //1,3
                    oneHalfBack()
                    threeRunnerNoMove2()
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState7    //3
                    oneSTO2()
                } else {
                    //진루
                    self.runnerState = .RunnerState6    // 2, 3
                    oneHalfRunner()
                    threeRunnerNoMove2()
                }
                
            case .RunnerState24:
                //1H,2H,3H
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState16   //1,2H,3H
                    oneHalfBack()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState22   //2H,3H
                    oneSTO2()
                } else {
                    //진루
                    self.runnerState = .RunnerState26   //2,2H,3H
                    oneHalfRunner()
                }
                
            case .RunnerState25:
                //1H,3H
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState15   //1,3H
                    oneHalfBack()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState23   //3H
                    oneSTO2()
                } else {
                    //진루
                    self.runnerState = .RunnerState20   //2,3H
                    oneHalfRunner()
                }
                
            case .RunnerState30:
                //1H,2,3H(진루안됨)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState17 //1,2,3H
                    oneHalfBack()
                    twoRunnerNoMove2()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState20 //2,3H
                    oneSTO2()
                    twoRunnerNoMove1()
                } else {
                    //진루안됨
                }
                
            case .RunnerState31:
                //1H,3,3H
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState28   //1,3,3H
                    oneHalfBack()
                    threeRunnerNoMove2()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState29   //3,3H
                    oneSTO2()
                    threeRunnerNoMove1()
                } else {
                    //진루
                    self.runnerState = .RunnerState27   //2,3,3H
                    oneHalfRunner()
                    threeRunnerNoMove2()
                }
                
            case .RunnerState33:
                //1H,2H,3
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState32   //1,2H,3
                    oneHalfBack()
                    threeRunnerNoMove2()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState21   //2H,3
                    oneSTO2()
                    threeRunnerNoMove1()
                } else {
                    //진루
                self.runnerState = .RunnerState35   //2,2H,3
                oneHalfRunner()
                threeRunnerNoMove2()
                }
                
            case .RunnerState34:
                //1H,2,3(진루안됨)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState3    //1,2,3
                    oneHalfBack()
                    twoRunnerNoMove2()
                    threeRunnerNoMove2()
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState6    //2,3
                    oneSTO2()
                    twoRunnerNoMove1()
                    threeRunnerNoMove1()
                    
                } else {
                    //진루안됨
                }
                

                
                
                
                
                
                
            default:
                return
            }
        }
            //2루 주자
        else if runnerPosition == .TwoRunner {
            
            twoRunnerInit()
            
            switch runnerState {
            case .Default:
                self.runnerState = .RunnerState1
                self.oneRunnerHRecord = self.currentHRecord
                
            case .RunnerState2:
                //1,2루만 있을 경우
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState10     //1H
                    twoSTO1()
                    oneHalfRun()
                } else {
                self.runnerState = .RunnerState13 // 1H, 3
                twoRunner()
                oneRunnerInit()
                oneRunnerHalfMove()
                self.oneHalfRunnerHRecord = self.tempOneRunnerHRecord
                }
                
            case .RunnerState3:
                //1,2,3
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState25     //1H,3H
                    twoSTO1()
                    oneHalfRun()
                    threeHalfRun()
                } else {
                self.runnerState = .RunnerState31   //1H,3,3H
                twoRunner()
                oneRunnerInit()
                threeRunnerInit()
                oneRunnerHalfMove()
                threeRunnerHalfMove()
                
                self.oneHalfRunnerHRecord = self.tempOneRunnerHRecord
                self.threeHalfRunnerHRecord = self.tempThreeRunnerHRecord
                }
                
                
            case .RunnerState5:
                //2 - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .Default     //없음
                    twoSTO1()
                    
                } else {
                self.runnerState = .RunnerState7    //3
                twoRunner()
                }
                
            case .RunnerState6:
                //2,3 - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState23     //3H
                    twoSTO1()
                    threeHalfRun()
                } else {
                self.runnerState = .RunnerState29   // 3, 3H
                twoRunner()
                threeRunnerInit()
                threeRunnerHalfMove()
                self.threeHalfRunnerHRecord = self.tempThreeRunnerHRecord
                }
                
            case .RunnerState11:
                //1-2 중간, 2-3 중간 (1H, 2H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState12   //1H,2
                    twoHalfBack()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState10   //1H
                    twoSTO2()
                } else {
                    //진루
                    self.runnerState = .RunnerState13//(1H,3)
                    twoHalfRunner()
                }
                
                
                
                
                
            case .RunnerState14:
                //1, 2-3 중간(1, 2H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState2    //1,2
                    twoHalfBack()
                    oneRunnerNoMove1()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState1    //1
                    twoSTO2()
                    oneRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState4//(1,3)
                    twoHalfRunner()
                    oneRunnerNoMove1()
                }
                
            case .RunnerState16:
                //1, 2-3 중간, 3-홈 중간 (1, 2H, 3H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState17   //1,2,3H
                    twoHalfBack()
                    oneRunnerNoMove1()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState15   //1,3H
                    twoSTO2()
                    oneRunnerNoMove1()
                    
                } else {
                    //진루
                self.runnerState = .RunnerState31   // 1, 3, 3H
                twoHalfRunner()
                oneRunnerNoMove1()
                }
                
            case .RunnerState18:
                //2 중간(2H) - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState5    //2
                    twoHalfBack()
                    
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .Default     //없음
                    twoSTO2()
                    
                } else {
                    //진루
                self.runnerState = .RunnerState7    //3
                twoHalfRunner()
                }
                
            case .RunnerState19:
                //2, 2-3 중간
                //진루없음 불가능
                
                if self.recordState == .TagOut {
                    //태그아웃
                    self.runnerState = .RunnerState5//(2)
                    twoSTO2()
                    twoRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState6//(2,3)
                    twoHalfRunner()
                }
                
                
            case .RunnerState21:
                //2-3 중간, 3(2H, 3) - twoRunner
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState6    //2,3
                    twoHalfBack()
                    threeRunnerNoMove2()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState7    //3
                    twoSTO2()
                    threeRunnerNoMove1()
                    
                } else {
                    //진루 하지 못함
                }
            case .RunnerState22:
                //2-3 중간, 3-홈 중간(2H, 3H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState20   //2,3H
                    twoHalfBack()
                    
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState23   //3H
                    twoSTO2()
                    
                } else {
                    //진루 (3, 3H)
                    self.runnerState = .RunnerState29
                    twoRunner()
                }
                
                
            case .RunnerState24:
                //1-2 중간, 2-3 중간, 3-홈 중간
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState30   //1H,2,3H
                    twoHalfBack()
                    
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState25   //1H,3H
                    twoSTO2()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState31//(1H,3,3H)
                    twoRunner()
                }
                
                
            case .RunnerState26:
                //2,2-3중간,3-홈 중간 (2, 2H, 3H) - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음 안됨
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState20   //2,3H
                    twoSTO2()
                    twoRunnerNoMove1()
                    
                } else {
                    //진루
                self.runnerState = .RunnerState27   //2, 3, 3H
                twoRunner()
                twoRunnerNoMove2()
                }
                
            case .RunnerState32:
                //1,2H,3
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState3    //1,2,3
                    twoHalfBack()
                    oneRunnerNoMove1()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState4    //1,3
                    twoSTO2()
                    oneRunnerNoMove1()
                    threeRunnerNoMove1()
                    
                } else {
                    //진루 안됨
                }
                
            case .RunnerState33:
                //1H,2H,3
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState34   //1H,2,3
                    twoHalfBack()
                    threeRunnerNoMove2()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState13   //1H,3
                    twoSTO2()
                    threeRunnerNoMove1()
                    
                } else {
                    //진루 안됨
                }
                
                
            case .RunnerState35:
                //2,2H,3
                
                if self.recordState == .NotAdvance {
                    //진루 없음 안됨
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState6    //2,3
                    twoSTO2()
                    twoRunnerNoMove1()
                    threeRunnerNoMove1()
                } else {
                    //진루 안됨
                    
                }
                
            default:
                return
            }
            
        }
            //3루 주자
        else if runnerPosition == .ThreeRunner {
            threeRunnerInit()//초기화
            switch runnerState {
            case .Default:
                self.runnerState = .RunnerState1    //1
                self.oneRunnerHRecord = self.currentHRecord
            case .RunnerState3:
                //1,2,3
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState11     //1H,2H
                    threeSTO1()
                    oneHalfRun()
                    twoHalfRun()
                    
                    
                } else {
                self.runnerState = .RunnerState11   //1H,2H
                oneRunnerInit()
                twoRunnerInit()
                oneRunnerHalfMove()
                twoRunnerHalfMove()
                self.oneHalfRunnerHRecord = self.tempOneRunnerHRecord
                self.twoHalfRunnerHRecord = self.tempTwoRunnerHRecord
                
                self.threeRunner()
                }
            case .RunnerState4:
                //1,3
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState10     //1H
                    threeSTO1()
                    oneHalfRun()
                } else {
                self.runnerState = .RunnerState10   //1H
                oneRunnerInit()
                oneRunnerHalfMove()
                self.oneHalfRunnerHRecord = self.tempOneRunnerHRecord
                self.threeRunner()
                }
                
            case .RunnerState6:
                //2,3 - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState18     //2H
                    threeSTO1()
                    twoHalfRun()
                } else {
                self.runnerState = .RunnerState18   //2H
                
                twoRunnerInit()
                twoRunnerHalfMove()
                self.twoHalfRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunner()
                }
                
            case .RunnerState7:
                //3 - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .Default     //없음
                    threeSTO1()
                } else {
                self.runnerState = .Default //없음
                self.threeRunner()
                }
                
            case .RunnerState15:
                //1, 3H
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState4    //1,3
                    threeHalfBack()
                    oneRunnerNoMove1()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState1    //1
                    threeSTO2()
                    oneRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState1//(1)
                    oneRunnerNoMove1()
                    self.threeHalfRunner()
                }
                
            case .RunnerState16:
                //1,2-3,3-홈
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState32   //1,2H,3
                    threeHalfBack()
                    oneRunnerNoMove1()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState14   //1,2H
                    threeSTO2()
                    oneRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState14//1,2H
                    self.threeHalfRunner()
                    oneRunnerNoMove1()
                }
            case .RunnerState17:
                //1,2,3-홈 (1, 2, 3H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState3    //1,2,3
                    threeHalfBack()
                    oneRunnerNoMove1()
                    twoRunnerNoMove2()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState2    //1,2
                    threeSTO2()
                    oneRunnerNoMove1()
                    twoRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState2//(1,2)
                    self.threeHalfRunner()
                    oneRunnerNoMove1()
                    twoRunnerNoMove2()
                }
            case .RunnerState20:
                //2, 3-홈 중간(2, 3H) - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState6    //2,3
                    threeHalfBack()
                    twoRunnerNoMove2()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState5    //2
                    threeSTO2()
                    twoRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState5    //2
                    self.threeHalfRunner()
                    twoRunnerNoMove2()
                }
                
            case .RunnerState22:
                //2H, 3H
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState21   //2H,3
                    threeHalfBack()
                    
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState18   //2H
                    threeSTO2()
                    
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState18//2H
                    self.threeHalfRunner()
                }
                
            case .RunnerState23:
                //3-홈 중간
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState7    //3
                    threeHalfBack()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .Default //없음
                    threeSTO2()
                    
                } else {
                    //진루
                    self.runnerState = .Default //없음
                    self.threeHalfRunner()
                }
                
                
            case .RunnerState24:
                //1-2중간,2-3중간,3-홈 중간
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState33   //1H,2H,3
                    threeHalfBack()
                    
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState11   //1H,2H
                    threeSTO2()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState11//1H,2H
                    self.threeHalfRunner()
                }
                
            case .RunnerState25:
                //1-2중간,3-홈 중간
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState13   //1H,3
                    threeHalfBack()
                    
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState10   //1H
                    threeSTO2()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState10//1H
                    self.threeHalfRunner()
                }
                
            case .RunnerState26:
                //2,2H,3H
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState35   //2,2H,3
                    threeHalfBack()
                    twoRunnerNoMove2()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState19   //2,2H
                    threeSTO2()
                    twoRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState19//2,2H
                    self.threeHalfRunner()
                    twoRunnerNoMove2()
                }
                
            case .RunnerState27:
                //2,3,3-홈 중간 (2, 3, 3H)
                if self.recordState == .NotAdvance {
                    //진루 없음 안됨
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState6    //2,3
                    threeSTO2()
                    twoRunnerNoMove1()
                    threeRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState6    // 2, 3
                    self.threeHalfRunner()
                    twoRunnerNoMove2()
                    threeRunnerNoMove2()
                }
                
            case .RunnerState28:
                //1,3,3-홈 중간
                if self.recordState == .NotAdvance {
                    //진루 없음 안됨
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState4    //1,3
                    threeSTO2()
                    oneRunnerNoMove1()
                    threeRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState4//1,3
                    self.threeHalfRunner()
                    oneRunnerNoMove1()
                    threeRunnerNoMove2()
                }
            case .RunnerState29:
                //3,3-홈 중간(3, 3H) - Completed
                if self.recordState == .NotAdvance {
                    //진루 없음 안됨
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState7    //3
                    threeSTO2()
                    threeRunnerNoMove1()
                } else {
                    //진루
                self.runnerState = .RunnerState7    //3
                self.threeHalfRunner()
                threeRunnerNoMove2()
                }
                
            case .RunnerState30:
                //1H,2,3H
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState34   //1H,2,3
                    threeHalfBack()
                    twoRunnerNoMove2()
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState12   //1H,2
                    threeSTO2()
                    twoRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState12//1H,2
                    twoRunnerNoMove2()
                    self.threeHalfRunner()
                    
                }
                
                
            case .RunnerState31:
                //1H,3,3H
                if self.recordState == .NotAdvance {
                    //진루 없음 안됨
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState13   //1H,3
                    threeSTO2()
                    threeRunnerNoMove1()
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState13//1H,3
                    threeRunnerNoMove2()
                    threeHalfRunner()
                }
            default:
                return
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.complete()
        }
    }
    
    //타자 주자 초기화
    func  batterRunnerInit() {
        self.homeLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
        self.runnerH_1.isHidden = false
    }
    
    //타자 이동 - 1
    func batterOneMove() {
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.oneLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
        }, completion: {finished in})
        
    }
    
    //타자 이동 - 2
    func batterTwoMove() {
        
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                self.oneLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                self.twoLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    
    //타자 이동 - 3
    func batterThreeMove() {
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                self.oneLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                self.twoLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                self.threeLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    
    //타자 이동 - 4
    func batterFourMove() {
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/4, animations: {
                self.oneLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/4, relativeDuration: 1/4, animations: {
                self.twoLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/4, relativeDuration: 1/4, animations: {
                self.threeLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4, animations: {
                self.homeLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    
    //1루주자 초기화
    func oneRunnerInit() {
        self.oneLocation(runner: self.runner1_2, imageName: runnerImageName)
        self.runner1_2.isHidden = false
        self.runner1.isHidden = true
    }
    
    //1루주자 이동 - 1
    func oneRunnerOneMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.twoLocation(runner: self.runner1_2, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
        
    }
    
    //1루주자 이동 - 2
    func oneRunnerTwoMove() {
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                self.twoLocation(runner: self.runner1_2, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                self.threeLocation(runner: self.runner1_2, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    
    //1루주자 이동 - 3
    func oneRunnerThreeMove() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                self.twoLocation(runner: self.runner1_2, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                self.threeLocation(runner: self.runner1_2, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                self.homeLocation(runner: self.runner1_2, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    // MARK: - 주자 뒤로 이동(진루없음)
    
    //1루주자 뒤로 이동 - 1
    func oneRunnerBackOneMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.oneLocation(runner: self.runner1_2, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
        
    }
    
    //2루주자 초기화
    func twoRunnerInit() {
        
        if self.runnerState.rawValue.contains("H") == false {
            self.twoLocation(runner: self.runner2_3, imageName: runnerImageName)
        }
        else {
            self.twoLocation(runner: self.runner2_3, imageName: self.runnerGrayImageName)
        }
        
        self.runner2_3.isHidden = false
        self.runner2.isHidden = true
    }
    
    //2루주자 이동 - 1
    func twoRunnerOneMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.threeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    
    //2루주자 이동 - 2
    func twoRunnerTwoMove() {
        UIView.animateKeyframes(withDuration: 1.1, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                self.threeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                self.homeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    // MARK: - 주자 뒤로 이동(진루없음)
    //2루주자 뒤로 이동 - 1
    func twoRunnerBackOneMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.twoLocation(runner: self.runner2_3, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    //3루주자 초기화
//    func threeRunnerInit() {
//        self.threeLocation(runner: self.runner3_H, imageName: runnerImageName)
//        self.runner3_H.isHidden = false
//        self.runner3.isHidden = true
//    }
    
    func threeRunnerInit() {
        
        if self.runnerState.rawValue.contains("H") == false {
            self.threeLocation(runner: self.runner3_H, imageName: runnerImageName)
        }
        else {
            self.threeLocation(runner: self.runner3_H, imageName: self.runnerGrayImageName)
        }
        
        self.runner3_H.isHidden = false
    }
    
    //3루주자 이동 - 1
    func threeRunnerOneMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.homeLocation(runner: self.runner3_H, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
        
    }
    // MARK: - 주자 뒤로 이동(진루없음)
    //3루주자 뒤로 이동 - 1
    func threeRunnerBackOneMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.threeLocation(runner: self.runner3_H, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
        
    }
    
    //타자 반 이동(추가 입력 요구)
    func batterRunnerHalfMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.betweenHomeAndOneLoacation(runner: self.runnerH_1)
            })
            
        }, completion: {finished in})
    }
    
    //1루주자 반 이동(추가 입력 요구)
    func oneRunnerHalfMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.betweenOneAndTwoLocation(runner: self.runner1_2)
            })
            
        }, completion: {finished in})
    }
    
    //2루주자 반 이동(추가 입력 요구)
    func twoRunnerHalfMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.betweenTwoAndThreeLocation(runner: self.runner2_3)
            })
            
        }, completion: {finished in})
    }
    
    //2루주자 반에서 3루 이동(추가 입력 완료)
    func twoRunnerHalfCompleteMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.betweenTwoAndThreeLocation(runner: self.runner2_3)
            })
            
        }, completion: {finished in})
    }
    
    //3루주자 반 이동(추가 입력 요구)
    func threeRunnerHalfMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.betweenThreeAndHomeLoacation(runner: self.runner3_H)
            })
            
        }, completion: {finished in})
    }
    
    //3루주자 반에서 홈 이동(추가 입력 완료)
    func threeRunnerHalfCompleteMove() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                self.betweenThreeAndHomeLoacation(runner: self.runner3_H)
            })
            
        }, completion: {finished in})
    }
    
    
    //홈 좌표 : 613, 579
    func homeLocation(runner : UIButton, imageName : String) {
        runner.setBackgroundImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        runner.frame.origin.x = 613
        runner.frame.origin.y = 579
    }
    
    //1루 좌표 : 743, 387
    func oneLocation(runner : UIButton, imageName : String) {
        runner.setBackgroundImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        runner.frame.origin.x = 743
        runner.frame.origin.y = 387
    }
    
    //2루 좌표 : 613, 272
    func twoLocation(runner : UIButton, imageName : String) {
        runner.setBackgroundImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        runner.frame.origin.x = 613
        runner.frame.origin.y = 272
    }
    
    //3루 좌표 : 483, 387
    func threeLocation(runner : UIButton, imageName : String) {
        runner.setBackgroundImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        runner.frame.origin.x = 483
        runner.frame.origin.y = 387
    }
    
    //홈-1루 중간 좌표 : 687, 496
    func betweenHomeAndOneLoacation(runner : UIButton) {
        runner.frame.origin.x = 687
        runner.frame.origin.y = 496
    }
    
    //1루-2루 중간 좌표 : 687, 320
    func betweenOneAndTwoLocation(runner : UIButton){
        runner.frame.origin.x = 687
        runner.frame.origin.y = 320
    }
    
    //2루-3루 중간 좌표 : 536, 320
    func betweenTwoAndThreeLocation(runner : UIButton) {
        runner.frame.origin.x = 536
        runner.frame.origin.y = 320
    }
    
    //3루-홈 중간 좌표 : 536, 496
    func betweenThreeAndHomeLoacation(runner : UIButton) {
        runner.frame.origin.x = 536
        runner.frame.origin.y = 496
    }
    
    func setRunnerViewByRunnerState() {
        switch runnerState {
        case .RunnerState1:
            //1루만 있을 경우
            self.runner1.isHidden = false
            self.runner2.isHidden = true
            self.runner3.isHidden = true
        case .RunnerState2:
            //1,2루만 있을 경우
            self.runner1.isHidden = false
            self.runner2.isHidden = false
            self.runner3.isHidden = true
        case .RunnerState3:
            //1,2,3루만 있을 경우
            self.runner1.isHidden = false
            self.runner2.isHidden = false
            self.runner3.isHidden = false
        case .RunnerState4:
            //1,3루만 있을 경우
            self.runner1.isHidden = false
            self.runner2.isHidden = true
            self.runner3.isHidden = false
        case .RunnerState5:
            //2루만 있을 경우
            self.runner1.isHidden = true
            self.runner2.isHidden = false
            self.runner3.isHidden = true
        case .RunnerState6:
            //2,3루만 있을 경우
            self.runner1.isHidden = true
            self.runner2.isHidden = false
            self.runner3.isHidden = false
        case .RunnerState7:
            //3루만 있을 경우
            self.runner1.isHidden = true
            self.runner2.isHidden = true
            self.runner3.isHidden = false
       
        default:
            self.runner1.isHidden = true
            self.runner2.isHidden = true
            self.runner3.isHidden = true
        }
        
        //달리는 주자는 다 뛰고 나서 안보이게한다.
        self.runnerH_1.isHidden = true
        self.runner1_2.isHidden = true
        self.runner2_3.isHidden = true
        self.runner3_H.isHidden = true
        
        //달리는 주자들 위치 초기화
        self.runnerH_1.frame.origin.x = 613
        self.runnerH_1.frame.origin.y = 579
        
        self.runner1_2.frame.origin.x = 743
        self.runner1_2.frame.origin.y = 387
        
        self.runner2_3.frame.origin.x = 613
        self.runner2_3.frame.origin.y = 272
        
        self.runner3_H.frame.origin.x = 483
        self.runner3_H.frame.origin.y = 387
    }
    
    
    func complete() {
        if((self.completeDelegate) != nil)
        {
            if self.runnerState.rawValue.contains("H") == false {
                //주자들 초기화
                self.setRunnerViewByRunnerState()
                completeDelegate?.AnimationComplete(oneRunnerHRecord: self.oneRunnerHRecord, twoRunnerHRecord: self.twoRunnerHRecord, threeRunnerHRecord : self.threeRunnerHRecord, homeRunnerHRecordList : self.homeRunnerHRecordList, runnerState : self.runnerState, addActionState : self.addActionState, runnerPosition: self.runnerPosition)
            }
            else {
                completeDelegate?.AddActionAnimationComplete(oneRunnerHRecord: self.oneRunnerHRecord, twoRunnerHRecord: self.twoRunnerHRecord, threeRunnerHRecord : self.threeRunnerHRecord, homeRunnerHRecordList : self.homeRunnerHRecordList, tempRunnerHRecord : self.tempRunnerHRecord, oneHalfRunnerHRecord : self.oneHalfRunnerHRecord, twoHalfRunnerHRecord : self.twoHalfRunnerHRecord, threeHalfRunnerHRecord : self.threeHalfRunnerHRecord, runnerState : self.runnerState, addActionState : self.addActionState, runnerPosition: self.runnerPosition)
            }
        }
    }
    func oneRunner(){
        //1루(1H 제외)(2루로 도루할때)
        self.oneRunnerOneMove()
        self.twoRunnerHRecord = self.tempOneRunnerHRecord
        self.twoRunnerHRecord.runnerLocation = "2루"
        self.twoRunnerHRecord.oneRecord = self.recordState
        self.twoRunnerHRecord.oneRecordImage = self.recordState.rawValue		//1-2루 사이 이미지
        self.twoRunnerHRecord.oneRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")	//몇번타자가 있을때 도루했는지
    }
    
    func oneHalfRunner(){
        self.oneRunnerOneMove()
        self.twoRunnerHRecord = self.oneHalfRunnerHRecord
        self.twoRunnerHRecord.runnerLocation = "2루"
        self.twoRunnerHRecord.oneRecord = self.recordState
        self.twoRunnerHRecord.oneRecordImage = self.recordState.rawValue		//1-2루 사이 이미지
        self.twoRunnerHRecord.oneRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")	//몇번타자가 있을때 도루했는지
    }
    func oneHalfRun(){
        oneRunnerInit()
        oneRunnerHalfMove()
        self.oneHalfRunnerHRecord = self.tempOneRunnerHRecord
    }
    func oneSTO1(){
        self.oneRunnerHRecord = self.tempOneRunnerHRecord
        self.oneRunnerHRecord.runnerLocation = ""
        self.oneRunnerHRecord.oneRecord = self.recordState
        self.oneRunnerHRecord.oneRecordText += "T" 		//1-2루 사이 이미지
//        self.runner1.isEnabled = false
        
    }
    func oneSTO2(){
        self.oneHalfRunnerHRecord.runnerLocation = ""
        self.oneHalfRunnerHRecord.oneRecord = self.recordState
        self.oneHalfRunnerHRecord.oneRecordText += "T" 		//1-2루 사이 이미지
        self.runner1.isHidden = true
    }
    func oneHalfBack(){
        //1H->1 이동
        oneRunnerBackOneMove()
        self.oneRunnerHRecord = self.oneHalfRunnerHRecord
    }
    
    func oneRunnerNoMove1(){
        //1고정
        self.oneRunnerHRecord = self.tempOneRunnerHRecord
    }
    
    func twoRunner(){
        //2루(2H 제외)(3루로 도루할때)
        self.twoRunnerOneMove()
        self.threeRunnerHRecord = self.tempTwoRunnerHRecord
        self.threeRunnerHRecord.runnerLocation = "3루"
        self.threeRunnerHRecord.twoRecord = self.recordState
        self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue		//2-3루 사이 이미지
        self.threeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")	//몇번타자가 있을때 도루했는지
    }
    
    func twoHalfRunner(){
        //2루(2H 제외)(3루로 도루할때)
        self.twoRunnerOneMove()
        self.threeRunnerHRecord = self.twoHalfRunnerHRecord
        self.threeRunnerHRecord.runnerLocation = "3루"
        self.threeRunnerHRecord.twoRecord = self.recordState
        self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue		//2-3루 사이 이미지
        self.threeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")	//몇번타자가 있을때 도루했는지
    }
    func twoHalfRun(){
        twoRunnerInit()
        twoRunnerHalfMove()
        self.twoHalfRunnerHRecord = self.tempTwoRunnerHRecord
    }
    func twoSTO1(){
        self.twoRunnerHRecord = self.tempTwoRunnerHRecord
        self.twoRunnerHRecord.runnerLocation = ""
        self.twoRunnerHRecord.twoRecord = self.recordState
        self.twoRunnerHRecord.twoRecordText += "T" 		//1-2루 사이 이미지
        self.runner2.isHidden = true
    }
    func twoSTO2(){
        self.twoHalfRunnerHRecord.runnerLocation = ""
        self.twoRunnerHRecord.twoRecord = self.recordState
        self.twoRunnerHRecord.twoRecordText += "T" 		//1-2루 사이 이미지
        self.runner2.isHidden = true
    }
    func twoHalfBack(){
        twoRunnerBackOneMove()
        self.twoRunnerHRecord = self.twoHalfRunnerHRecord
    }
    func twoRunnerNoMove1(){
        self.twoRunnerHRecord = self.tempTwoRunnerHRecord
    }
    func twoRunnerNoMove2(){
        self.twoRunnerHRecord = self.tempTwoRunnerHRecord
        if self.twoRunnerHRecord.oneRecord != .Default{
            self.twoRunnerHRecord.oneRecordImage = self.recordState.rawValue		//1-2루 사이 이미지
        }
    }
    
    func threeRunner(){
        //3루(3H제외)(홈으로 도루할때)
        self.threeRunnerOneMove()
        self.tempThreeRunnerHRecord.runnerLocation = ""
        self.tempThreeRunnerHRecord.threeRecord = self.recordState
        self.tempThreeRunnerHRecord.threeRecordImage = self.recordState.rawValue		//3-홈 사이 이미지
        self.tempThreeRunnerHRecord.threeRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
        self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
    }
    
    func threeHalfRunner(){
        //3H 필수(홈으로 도루할때)
        self.threeRunnerOneMove()
        self.threeHalfRunnerHRecord.runnerLocation = ""
        self.threeHalfRunnerHRecord.threeRecord = self.recordState
        self.threeHalfRunnerHRecord.threeRecordImage = self.recordState.rawValue		//3-홈 사이 이미지
        self.threeHalfRunnerHRecord.threeRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
        self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
    }
    func threeHalfRun(){
        threeRunnerInit()
        threeRunnerHalfMove()
        self.threeHalfRunnerHRecord = tempThreeRunnerHRecord
    }
    func threeSTO1(){
        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
        self.threeRunnerHRecord.runnerLocation = ""
        self.threeRunnerHRecord.threeRecord = self.recordState
        self.threeRunnerHRecord.threeRecordText += "T" 		//1-2루 사이 이미지
        self.runner3.isHidden = true
    }
    func threeSTO2(){
        self.threeHalfRunnerHRecord.runnerLocation = ""
        self.threeHalfRunnerHRecord.threeRecord = self.recordState
        self.threeHalfRunnerHRecord.threeRecordText += "T" 		//1-2루 사이 이미지
        self.runner3.isHidden = true
    }
    func threeHalfBack(){
        threeRunnerBackOneMove()
        self.threeRunnerHRecord = self.threeHalfRunnerHRecord
    }
    func threeRunnerNoMove1(){
        //다른주자 진루시
        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
    }
    func threeRunnerNoMove2(){//스틸성공시
        //다른주자 진루시
        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
        if threeRunnerHRecord.twoRecord != .Default{
            self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue		//2-3루 사이 이미지
        }
        
    }
    func out(){
        self.oneRunnerHRecord.centerRecord = RecordState.OutCountOne
        self.oneRunnerHRecord.centerRecordImage = RecordState.OutCountOne.rawValue
    }
}














