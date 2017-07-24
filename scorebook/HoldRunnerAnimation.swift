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
                self.runnerState = .RunnerState5
                
                self.oneRunnerOneMove()
                
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecord = self.recordState
                //                self.twoRunnerHRecord.oneRecordImage = self.recordState.rawValue
                self.twoRunnerHRecord.oneRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
            case .RunnerState2:
                //1,2루만 있을 경우 - Completed
                self.runnerState = .RunnerState19
                
                self.oneRunnerOneMove()
                self.twoRunnerInit()
                self.twoRunnerHalfMove()
                
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecord = self.recordState
                //                self.twoRunnerHRecord.oneRecordImage = self.recordState.rawValue
                self.twoRunnerHRecord.oneRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                
                self.twoHalfRunnerHRecord = self.tempTwoRunnerHRecord
            case .RunnerState3:
                //1,2,3 - Completed
                self.runnerState = .RunnerState26   // 2, 2H, 3H
                
                self.oneRunnerOneMove()
                self.twoRunnerInit()
                self.twoRunnerHalfMove()
                self.threeRunnerInit()
                self.threeRunnerHalfMove()
                
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecord = self.recordState
                //                self.twoRunnerHRecord.oneRecordImage = self.recordState.rawValue
                self.twoRunnerHRecord.oneRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                self.twoRunnerHRecord.oneRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
                self.twoHalfRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeHalfRunnerHRecord = self.tempThreeRunnerHRecord
            case .RunnerState4:
                //1,3루만 있을 경우 - Completed
                self.runnerState = .RunnerState20
                
                self.oneRunnerOneMove()
                self.threeRunnerInit()
                self.threeRunnerHalfMove()
                
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecord = self.recordState
                self.twoRunnerHRecord.oneRecordImage = self.recordState.rawValue
                
                self.threeHalfRunnerHRecord = self.tempThreeRunnerHRecord
            case .RunnerState13:
                //1H, 3 - Completed
                self.runnerState = .RunnerState6    // 2, 3
                
                self.oneRunnerHalfMove()
                
                self.twoRunnerHRecord = self.oneHalfRunnerHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecord = self.recordState
                self.twoRunnerHRecord.oneRecordImage = self.recordState.rawValue
                
                self.threeRunnerHRecord = self.tempThreeRunnerHRecord
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
                self.runnerState = .RunnerState13 // 1H, 3
                
                oneRunnerInit()
                oneRunnerHalfMove()
                twoRunnerOneMove()
                
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord.twoRecord = self.recordState
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue
                self.threeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
                self.oneHalfRunnerHRecord = self.tempOneRunnerHRecord
            case .RunnerState3:
                //1,2,3
                self.runnerState = .RunnerState16
                oneRunnerInit()
                threeRunnerInit()
                oneRunnerHalfMove()
                threeRunnerHalfMove()
                twoRunnerOneMove()
                self.oneHalfRunnerHRecord = self.tempOneRunnerHRecord
                self.threeHalfRunnerHRecord = self.tempThreeRunnerHRecord
                
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue
                self.threeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
            case .RunnerState5:
                //2 - Completed
                self.runnerState = .RunnerState7
                twoRunnerOneMove()
                
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord.twoRecord = self.recordState
                self.threeRunnerHRecord.runnerLocation = "3루"
                //                self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue
                self.threeRunnerHRecord.twoRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
            case .RunnerState6:
                //2,3 - Completed
                self.runnerState = .RunnerState29   // 3, 3H
                
                twoRunnerOneMove()
                threeRunnerInit()
                threeRunnerHalfMove()
                
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord.twoRecord = self.recordState
                self.threeRunnerHRecord.runnerLocation = "3루"
                //self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue
                self.threeRunnerHRecord.twoRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
                self.threeHalfRunnerHRecord = self.tempThreeRunnerHRecord
                
            case .RunnerState11:
                //1-2 중간, 2-3 중간 (1H, 2H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState12//(1H,2)
                    
                    self.twoRunnerBackOneMove()
                    
                    self.twoRunnerHRecord = self.twoHalfRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState13//(1H,3)
                    
                    self.twoRunnerOneMove()
                    
                    self.twoHalfRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                }
            case .RunnerState13:
                //1H, 3
                print("aa")
            case .RunnerState14:
                //1, 2-3 중간(1, 2H)
                if self.recordState == .NotAdvance {
                    //진루없음
                    self.runnerState = .RunnerState2//(1,2)
                    
                    self.twoRunnerBackOneMove()
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord = self.twoHalfRunnerHRecord
                }
                else{
                    //진루ok
                    self.runnerState = .RunnerState4//(1,3)
                    
                    self.twoRunnerOneMove()
                    
                    self.twoHalfRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                }
                
            case .RunnerState16:
                //1, 2-3 중간, 3-홈 중간 (1, 2H, 3H)
                self.runnerState = .RunnerState17   // 1, 2, 3H
                
                self.twoRunnerOneMove()
                
                self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.twoRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
                self.oneRunnerHRecord = self.tempOneRunnerHRecord
                //                self.threeHalfRunnerHRecord = self.threeHalfRunnerHRecord
                
                /*
                 if self.recordState == .NotAdvance {
                 //진루 없음
                 self.runnerState = .RunnerState17//(1,2,3H)
                 self.twoRunnerBackOneMove()
                 self.oneRunnerHRecord = self.tempOneRunnerHRecord
                 self.twoRunnerHRecord = self.twoHalfRunnerHRecord
                 } else {
                 //진루
                 self.runnerState = .RunnerState28//(1,3,3H)
                 self.twoRunnerOneMove()
                 self.oneRunnerHRecord = self.tempOneRunnerHRecord
                 self.twoHalfRunnerHRecord.runnerLocation = "3루"
                 self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                 self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                 }
                 */
            case .RunnerState18:
                //2 중간(2H) - Completed
                self.runnerState = .RunnerState7    //3
                
                self.twoRunnerOneMove()
                
                self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                //                self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue
                self.threeRunnerHRecord.twoRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                /*
                 if self.recordState == .NotAdvance {
                 //진루 없음
                 self.runnerState = .RunnerState5//(2)
                 self.twoRunnerBackOneMove()
                 self.twoRunnerHRecord = self.twoHalfRunnerHRecord
                 } else {
                 //진루
                 self.runnerState = .RunnerState7//(3)
                 self.twoRunnerOneMove()
                 self.twoHalfRunnerHRecord.runnerLocation = "3루"
                 self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                 self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                 }
                 */
            case .RunnerState19:
                //2, 2-3 중간         진루한 2루 = tempTwo 기존 2루 = tempThree
                //진루없음 불가능
                
                if self.recordState == .TagOut {
                    //진루 없음(태그아웃?)
                    self.runnerState = .RunnerState5//(2)
                    self.runner2_3.isHidden = true
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    //기록지 아웃표시 생성?
                    
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState6//(2,3)
                    self.twoRunnerOneMove()
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue
                    self.threeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                }
                
                
            case .RunnerState21:
                //2-3 중간, 3(2H, 3) - twoRunner
                if self.recordState == .NotAdvance {
                    //진루없음
                    self.runnerState = .RunnerState6//(2,3)
                    self.twoRunnerBackOneMove()
                    self.twoRunnerHRecord = self.twoHalfRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                }
                else{
                    //진루 (2H, 3)
                    //진루 하지 못함
                }
            case .RunnerState22:
                //2-3 중간, 3-홈 중간(2H, 3H)
                if self.recordState == .NotAdvance {
                    //진루없음
                    self.runnerState = .RunnerState20//(2,3H)
                    self.twoRunnerBackOneMove()
                    self.twoRunnerHRecord = self.twoHalfRunnerHRecord
                }
                else{
                    //진루 (3, 3H)
                    self.runnerState = .RunnerState29
                    self.twoRunnerOneMove()
                    self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                }
                
                
            case .RunnerState24:
                self.addActionState = .Default
                //1-2 중간, 2-3 중간, 3-홈 중간
                
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState30//(1H,2,3H)
                    self.twoRunnerBackOneMove()
                    self.twoRunnerHRecord = self.twoHalfRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState31//(1H,3,3H)
                    self.twoRunnerOneMove()
                    self.twoHalfRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                }
                
                
            case .RunnerState26:
                //2,2-3중간,3-홈 중간 (2, 2H, 3H) - Completed
                self.runnerState = .RunnerState27   //2, 3, 3H
                
                self.twoRunnerOneMove()
                
                self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                //                self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue
                self.threeRunnerHRecord.twoRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
                self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                //                self.threeHalfRunnerHRecord = self.threeHalfRunnerHRecord
                /*
                 if self.recordState == .NotAdvance {
                 //진루 없음 안됨
                 
                 } else {
                 //진루
                 self.runnerState = .RunnerState27//(2,3,3H)
                 self.twoRunnerOneMove()
                 self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                 self.twoHalfRunnerHRecord.runnerLocation = "3루"
                 self.threeRunnerHRecord = self.twoHalfRunnerHRecord
                 self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                 }
                 */
            case .RunnerState32:
                //1,2H,3
                
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState3
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord = self.twoHalfRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    
                } else {
                    //진루 안됨
                    
                }
                
            case .RunnerState33:
                //1H,2H,3
                
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState34//1H,2,3
                    self.twoRunnerHRecord = self.twoHalfRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    
                } else {
                    //진루 안됨
                    
                }
                
                
            case .RunnerState35:
                //2,2H,3
                
                if self.recordState == .NotAdvance {
                    //진루 없음 안됨
                    
                } else if self.recordState == .TagOut {
                    //태그 아웃
                    self.runnerState = .RunnerState6
                    
                } else {
                    //진루 안됨
                    
                }
                
            default:
                return
            }
            
        }
            //3루 주자
        else if runnerPosition == .ThreeRunner {
            threeRunnerInit()
            switch runnerState {
            case .Default:
                self.runnerState = .RunnerState1
                self.oneRunnerHRecord = self.currentHRecord
            case .RunnerState3:
                //1,2,3
                self.runnerState = .RunnerState11
                oneRunnerInit()
                twoRunnerInit()
                oneRunnerHalfMove()
                twoRunnerHalfMove()
                self.oneHalfRunnerHRecord = self.tempOneRunnerHRecord
                self.twoHalfRunnerHRecord = self.tempTwoRunnerHRecord
                
                self.threeRunnerOneMove()
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.twoRecordImage = self.recordState.rawValue
                self.tempThreeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
            case .RunnerState4:
                //1,3
                self.runnerState = .RunnerState10
                oneRunnerInit()
                oneRunnerHalfMove()
                self.oneHalfRunnerHRecord = self.tempOneRunnerHRecord
                
                self.threeRunnerOneMove()
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.twoRecordImage = self.recordState.rawValue
                self.tempThreeRunnerHRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
            case .RunnerState6:
                //2,3 - Completed
                self.runnerState = .RunnerState18
                
                twoRunnerInit()
                twoRunnerHalfMove()
                self.threeRunnerOneMove()
                
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                self.tempThreeRunnerHRecord.runnerLocation = ""
                //                self.tempThreeRunnerHRecord.threeRecordImage = self.recordState.rawValue
                self.tempThreeRunnerHRecord.threeRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                self.tempThreeRunnerHRecord.threeRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
                self.twoHalfRunnerHRecord = self.tempTwoRunnerHRecord
            case .RunnerState7:
                //3 - Completed
                self.runnerState = .Default
                
                self.threeRunnerOneMove()
                
                self.tempThreeRunnerHRecord.threeRecord = self.recordState
                self.tempThreeRunnerHRecord.runnerLocation = ""
                //                self.tempThreeRunnerHRecord.threeRecordImage = self.recordState.rawValue
                self.tempThreeRunnerHRecord.threeRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                self.tempThreeRunnerHRecord.threeRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
            case .RunnerState15:
                //1, 3H
                if self.recordState == .NotAdvance {
                    //진루없음
                    self.runnerState = .RunnerState4//(1,3)
                    self.threeRunnerBackOneMove()
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerHRecord = self.threeHalfRunnerHRecord
                }
                else{
                    //진루
                    self.runnerState = .RunnerState1//(1)
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerOneMove()
                    self.threeHalfRunnerHRecord.runnerLocation = ""
                    self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                }
            case .RunnerState16:
                //1,2-3,3-홈
                
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState32//(1,2H,3)
                    self.threeRunnerBackOneMove()
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerHRecord = self.threeHalfRunnerHRecord
                } else {
                    //진루 불가ok
                    self.runnerState = .RunnerState26
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerOneMove()
                    self.threeHalfRunnerHRecord.runnerLocation = ""
                    self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                }
            case .RunnerState17:
                //1,2,3-홈 (1, 2, 3H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState3//(1,2,3)
                    self.threeRunnerBackOneMove()
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord = self.threeHalfRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState2//(1,2)
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerOneMove()
                    self.threeHalfRunnerHRecord.runnerLocation = ""
                    self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                }
            case .RunnerState20:
                //2, 3-홈 중간(2, 3H) - Completed
                self.runnerState = .RunnerState5    //2
                
                self.threeRunnerOneMove()
                
                self.threeHalfRunnerHRecord.threeRecord = self.recordState
                self.threeHalfRunnerHRecord.runnerLocation = ""
                self.threeHalfRunnerHRecord.threeRecordImage = self.recordState.rawValue
                self.threeHalfRunnerHRecord.threeRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                
                self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                self.twoRunnerHRecord.oneRecordImage = self.recordState.rawValue
                /*
                 if self.recordState == .NotAdvance {
                 //진루 없음
                 self.runnerState = .RunnerState6//(2,3)
                 self.threeRunnerBackOneMove()
                 self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                 self.threeRunnerHRecord = self.threeHalfRunnerHRecord
                 }
                 else{
                 //진루
                 self.runnerState = .RunnerState5//(2)
                 self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                 self.threeRunnerOneMove()
                 self.threeHalfRunnerHRecord.runnerLocation = ""
                 self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                 self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                 }
                 */
            case .RunnerState22:
                //2H, 3H
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState21//2H,3
                    self.threeRunnerBackOneMove()
                    self.threeRunnerHRecord = self.threeHalfRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState18//2H
                    self.threeRunnerOneMove()
                    self.threeHalfRunnerHRecord.runnerLocation = ""
                    self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                }
                
            case .RunnerState23:
                //3-홈 중간
                
                if self.recordState == .NotAdvance {
                    //진루 없음ok
                    self.runnerState = .RunnerState7//3
                    self.threeRunnerBackOneMove()
                    self.threeRunnerHRecord = self.threeHalfRunnerHRecord
                } else {
                    //진루ok
                    self.runnerState = .Default
                    self.threeRunnerOneMove()
                    self.threeHalfRunnerHRecord.runnerLocation = ""
                    self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                }
                
                
            case .RunnerState24:
                //1-2중간,2-3중간,3-홈 중간
                
                if self.recordState == .NotAdvance {
                    //진루 없음ok
                    self.runnerState = .RunnerState33//1H,2H,3
                    self.threeRunnerBackOneMove()
                    self.threeRunnerHRecord = self.threeHalfRunnerHRecord
                } else {
                    //진루ok
                    self.runnerState = .RunnerState11//1H,2H
                    self.threeRunnerOneMove()
                    self.threeHalfRunnerHRecord.runnerLocation = ""
                    self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                }
                
                
                
                
                
                
            case .RunnerState25:
                //1-2중간,3-홈 중간
                
                if self.recordState == .NotAdvance {
                    //진루 없음ok
                    self.runnerState = .RunnerState13//1H,3
                    self.threeRunnerBackOneMove()
                    self.threeRunnerHRecord = self.threeHalfRunnerHRecord
                } else {
                    //진루ok
                    self.runnerState = .RunnerState10//1H
                    self.threeRunnerOneMove()
                    self.threeHalfRunnerHRecord.runnerLocation = ""
                    self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                }
                
            case .RunnerState26:
                //2,2H,3H
                
                if self.recordState == .NotAdvance {
                    //진루 없음ok
                    self.runnerState = .RunnerState35//2,2H,3
                    self.threeRunnerBackOneMove()
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord = self.threeHalfRunnerHRecord
                } else {
                    //진루불가
                    
                }
                
            case .RunnerState27:
                //2,3,3-홈 중간 (2, 3, 3H)
                self.runnerState = .RunnerState6    // 2, 3
                
                self.threeRunnerOneMove()
                
                self.threeHalfRunnerHRecord.runnerLocation = ""
                self.threeHalfRunnerHRecord.threeRecord = self.recordState
                self.threeHalfRunnerHRecord.threeRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                self.threeHalfRunnerHRecord.threeRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
                self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                
                self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                /*
                 if self.recordState == .NotAdvance {
                 //진루 없음 안됨
                 } else {
                 //진루
                 self.runnerState = .RunnerState6//2,3
                 self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                 self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                 self.threeRunnerOneMove()
                 self.threeHalfRunnerHRecord.runnerLocation = ""
                 self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                 self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                 }
                 */
            case .RunnerState28:
                //1,3,3-홈 중간
                
                if self.recordState == .NotAdvance {
                    //진루 없음 안됨
                } else {
                    //진루
                    self.runnerState = .RunnerState4//1,3
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.threeRunnerOneMove()
                    self.threeHalfRunnerHRecord.runnerLocation = ""
                    self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                }
            case .RunnerState29:
                //3,3-홈 중간(3, 3H) - Completed
                self.runnerState = .RunnerState7    //3
                
                self.threeRunnerOneMove()
                
                self.threeHalfRunnerHRecord.threeRecord = self.recordState
                self.threeHalfRunnerHRecord.runnerLocation = ""
                self.threeHalfRunnerHRecord.threeRecordImage = UtilsImage(currentHRecord: self.currentHRecord, recordState : self.recordState, runnerPosition : self.runnerPosition).getRecordStateImageStringByBatterNumber()
                self.threeHalfRunnerHRecord.threeRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
                
                self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                
                self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                /*
                 if self.recordState == .NotAdvance {
                 //진루 없음 안됨
                 } else {
                 //진루
                 self.runnerState = .RunnerState7//3
                 self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                 self.threeRunnerOneMove()
                 self.threeHalfRunnerHRecord.runnerLocation = ""
                 self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                 self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                 }
                 */
            case .RunnerState30:
                //1H,2,3H
                
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState34//1H,2,3
                    self.threeRunnerBackOneMove()
                    self.twoRunnerHRecord = self.twoHalfRunnerHRecord
                    self.threeRunnerHRecord = self.threeHalfRunnerHRecord
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState12//1H,2
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerOneMove()
                    self.threeHalfRunnerHRecord.runnerLocation = ""
                    self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
                }
                
                
            case .RunnerState31:
                //1H,3,3H
                
                if self.recordState == .NotAdvance {
                    //진루 없음 불가
                    
                } else {
                    //진루
                    self.runnerState = .RunnerState13//1H,3
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.threeRunnerOneMove()
                    self.threeHalfRunnerHRecord.runnerLocation = ""
                    self.threeHalfRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeHalfRunnerHRecord)
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
        
        if self.addActionState == .Default {
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
    func threeRunnerInit() {
        self.threeLocation(runner: self.runner3_H, imageName: runnerImageName)
        self.runner3_H.isHidden = false
        self.runner3.isHidden = true
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
    
}














