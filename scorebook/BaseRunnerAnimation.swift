//
//  RuunerAnimation.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 23..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation
import UIKit

class BaseRunnerAnimation {
    
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
    
    //주자별 기록지(타자, 1루, 2루, 3루)
    var currentHRecord : HRecordInfo = HRecordInfo()
    var oneRunnerHRecord : HRecordInfo = HRecordInfo()
    var twoRunnerHRecord : HRecordInfo = HRecordInfo()
    var threeRunnerHRecord : HRecordInfo = HRecordInfo()
    var homeRunnerHRecordList : [HRecordInfo] = [HRecordInfo]()
    
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
    
    init(runner1 : UIButton, runner2 : UIButton, runner3 : UIButton, runnerH_1 : UIButton, runner1_2 : UIButton, runner2_3 : UIButton, runner3_H : UIButton, currentHRecord : HRecordInfo, oneRunnerHRecord : HRecordInfo, twoRunnerHRecord : HRecordInfo, threeRunnerHRecord : HRecordInfo, homeRunnerHRecordList: [HRecordInfo], tempRunnerHRecord : HRecordInfo, runnerState : RunnerState, runnerPosition : RunnerPosition, recordState : RecordState, addActionState : AddActionState) {
        
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
        self.addActionState = addActionState
        self.runnerState = runnerState
        self.recordState = recordState
        self.runnerPosition = runnerPosition
        
    }
    
    func RunnerAnimation(hittingRecord : RecordState) {
        
        //루 이동은 무조건 한루
        if runnerPosition == .OneRunner {
            switch runnerState {
                
            case .Default:
                self.runnerState = .RunnerState1
                self.oneRunnerHRecord = self.currentHRecord
                
            case .RunnerState10:
                //1-2 중간
//                self.runnerState = .RunnerState6
                self.runnerState = .RunnerState5
                self.oneRunnerOneMove()
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.addActionState = .Default
                self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
            case .RunnerState11:
                //1-2 중간, 2-3 중간(1H, 2H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState14
                    self.oneRunnerBackOneMove()
                    self.tempOneRunnerHRecord.runnerLocation = "1루"
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState19
                    self.oneRunnerOneMove()
                    self.tempOneRunnerHRecord.runnerLocation = "2루"
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                }
            case .RunnerState12:
                //1-2 중간, 2
                //진루 불가능
                if self.recordState == .TagOut {
                    //진루 없음
                    self.runnerState = .RunnerState5
                    self.runner1_2.isHidden = true
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState2
                    self.oneRunnerBackOneMove()
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                }
            case .RunnerState13:
                //1-2 중간, 3 (1H, 3)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState4
                    self.oneRunnerBackOneMove()
                    self.tempOneRunnerHRecord.runnerLocation = "1루"
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState6
                    self.oneRunnerOneMove()
                    self.tempOneRunnerHRecord.runnerLocation = "2루"
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                }
            case .RunnerState14:
                //1, 2-3 중간
                self.addActionState = .Default
                self.runnerState = .RunnerState7
                self.twoRunnerInit()
                self.twoRunnerOneMove()
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
            case .RunnerState15:
                //1, 3-홈 중간
                self.addActionState = .Default
                self.runnerState = .RunnerState4
                
            case .RunnerState16:
                self.addActionState = .Default
                //1, 2-3 중간, 3-홈 중간
                self.runnerState = .RunnerState1
                
            case .RunnerState17:
                self.addActionState = .Default
                //1, 2, 3-홈 중간
                self.runnerState = .RunnerState1
                
            case .RunnerState18:
                self.addActionState = .Default
                //2 중간
                self.runnerState = .RunnerState1
                
            case .RunnerState19:
                self.addActionState = .Default
                //2, 2-3 중간
                self.runnerState = .RunnerState1
                
            case .RunnerState20:
                self.addActionState = .Default
                //2, 3-홈 중간
                self.runnerState = .RunnerState1
                
            case .RunnerState21:
                self.addActionState = .Default
                //2-3 중간, 3
                self.runnerState = .RunnerState1
                
            case .RunnerState22:
                self.addActionState = .Default
                //2-3 중간, 3-홈 중간
                self.runnerState = .RunnerState1
                
            case .RunnerState23:
                self.addActionState = .Default
                //3-홈 중간
                self.runnerState = .RunnerState1
                
            case .RunnerState24:
                //1-2, 2-3, 3-홈 중간 (1H, 2H, 3H)
                //진루
                self.runnerState = .RunnerState16
                
                self.oneRunnerOneMove()
                
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                self.tempRunnerHRecord = self.tempThreeRunnerHRecord
                
            case .RunnerState52:
                //1-2, 3-홈 중간 (1H, 3H)
                if self.recordState == .NotAdvance {
                    //진루없음 (1, 3H)
                    self.runnerState = .RunnerState15
                    
                    self.oneRunnerBackOneMove()
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                }
                else{
                    //진루 (2, 3H)
                    self.runnerState = .RunnerState20
                    
                    self.oneRunnerOneMove()
                    
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord.runnerLocation = "2루"
                    self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    
                }
            default:
                return
            }
        }
        else if runnerPosition == .TwoRunner {
            switch runnerState {
                
            case .Default:
                self.runnerState = .RunnerState1
                self.oneRunnerHRecord = self.currentHRecord
                
            case .RunnerState10:
                //1-2 중간
                self.runnerState = .RunnerState6
            case .RunnerState11:
                //1-2 중간, 2-3 중간 (1H, 2H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState12
                    self.twoRunnerBackOneMove()
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState13
                    self.twoRunnerOneMove()
                    self.tempTwoRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                }
                
                
                
                /*
                if self.recordState == .NotAdvance {
                    self.runnerState = .RunnerState2
                    
                    self.twoRunnerBackOneMove()
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord = self.tempThreeRunnerHRecord
                }
                else {
                    self.runnerState = .RunnerState6
                    
                    self.twoRunnerOneMove()
                    
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                }
                */
                
            case .RunnerState12:
                //1-2 중간, 2
                //진루 불가능
                self.addActionState = .Default
                
            case .RunnerState13:
                //1-2 중간, 3
                self.runnerState = .RunnerState2
                
                
            case .RunnerState14:
                //1, 2-3 중간(1, 2H)
                if self.recordState == .NotAdvance {
                    //진루없음
                    self.runnerState = .RunnerState2
                    
                    self.twoRunnerBackOneMove()
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                }
                else{
                    //진루
                    self.runnerState = .RunnerState4
                    
                    self.twoRunnerOneMove()
                    
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                }
            case .RunnerState15:
                //1, 3-홈 중간
                self.addActionState = .Default
                self.runnerState = .RunnerState4
                
            case .RunnerState16:
                self.addActionState = .Default
                //1, 2-3 중간, 3-홈 중간
                self.runnerState = .RunnerState1
                
            case .RunnerState17:
                self.addActionState = .Default
                //1, 2, 3-홈 중간
                self.runnerState = .RunnerState1
                
            case .RunnerState18:
                //2 중간(2H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState5
                    self.twoRunnerBackOneMove()
                    
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState7
                    self.twoRunnerOneMove()
                    self.tempTwoRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                }
                
            case .RunnerState19:
//                self.addActionState = .Default
                //2, 2-3 중간
                //진루없음 불가능
                self.runnerState = .RunnerState6
                self.twoRunnerOneMove()
                self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                /*
                if self.recordState == .TagOut {
                    //진루 없음
                    self.runnerState = .RunnerState5
                    self.runner2_3.isHidden = true
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState6
                    self.twoRunnerOneMove()
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                }
                */
                
            case .RunnerState20:
                self.addActionState = .Default
                //2, 3-홈 중간
                self.runnerState = .RunnerState1
                
            case .RunnerState21:
                //2-3 중간, 3(2H, 3) - twoRunner
                if self.recordState == .NotAdvance {
                    //진루없음
                    self.runnerState = .RunnerState6
                    self.twoRunnerBackOneMove()
                    
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                }
                else{
                    //진루 (2H, 3)
                    //진루 하지 못함
                }
            case .RunnerState22:
                self.addActionState = .Default
                //2-3 중간, 3-홈 중간(2H, 3H)
//                self.runnerState = .RunnerState1
                if self.recordState == .NotAdvance {
                    //진루없음
                    self.runnerState = .RunnerState20
                    self.twoRunnerBackOneMove()
                    
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                }
                else{
                    //진루 (3, 3H)
                    self.runnerState = .RunnerState51
                    self.twoRunnerOneMove()
                    
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    
                    self.tempRunnerHRecord = self.tempThreeRunnerHRecord
                }
                
            case .RunnerState23:
                self.addActionState = .Default
                //3-홈 중간
                self.runnerState = .RunnerState1
                
            default:
                return
            }
            
        }
        else if runnerPosition == .ThreeRunner {
            switch runnerState {
            case .Default:
                self.runnerState = .RunnerState1
                self.oneRunnerHRecord = self.currentHRecord
            case .RunnerState1:
                //1루만 있을 경우
                self.runnerState = .RunnerState2
                
            case .RunnerState2:
                //1,2루만 있을 경우
                self.addActionState = .Default
                self.runnerState = .RunnerState4
                
                self.twoRunnerOneMove()
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
            case .RunnerState3:
                //1,2,3루만 있을 경우
                if self.addActionState == .TwoAction {
                    //기존 2,3루일 경우에 해당
                    self.addActionState = .oneAction
                    self.runnerState = .RunnerState2
                    self.threeRunnerOneMove()
                    self.oneRunnerHRecord = self.currentHRecord
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.tempThreeRunnerHRecord.runnerLocation = ""
                    self.tempThreeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                }
                else {
                    //기존 1,3루일 경우에 해당
                    self.addActionState = .Default
                    self.runnerState = .RunnerState2
                    self.threeRunnerOneMove()
                    self.oneRunnerHRecord = self.currentHRecord
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.tempThreeRunnerHRecord.runnerLocation = ""
                    self.tempThreeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                }
                
                
            case .RunnerState4:
                //1,3루만 있을 경우
                
                if self.addActionState == .oneAction {
                    self.addActionState = .Default
                    self.runnerState = .RunnerState4
                    self.threeRunnerOneMove()
                    
                    self.oneRunnerHRecord = self.currentHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    
                    self.tempRunnerHRecord.runnerLocation = ""
                    self.tempRunnerHRecord.threeRecord = self.recordState
                    self.tempRunnerHRecord.threeRecordImage = self.recordState.rawValue
                    self.homeRunnerHRecordList.append(self.tempRunnerHRecord)
                }
                else {
                    self.addActionState = .Default
                    self.runnerState = .RunnerState1
                    self.threeRunnerOneMove()
                    self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                }
                
            case .RunnerState5:
                //2루만 있을 경우
                self.addActionState = .Default
                self.runnerState = .RunnerState4
                
            case .RunnerState6:
                //2,3루만 있을 경우
                self.addActionState = .Default
                self.runnerState = .RunnerState4
                
            case .RunnerState7:
                self.addActionState = .Default
                //3루만 있을 경우
                self.runnerState = .RunnerState1
                
            case .RunnerState15:
                //1, 3H
                if self.recordState == .NotAdvance {
                    //진루없음
                    self.runnerState = .RunnerState4
                    
                    self.threeRunnerBackOneMove()
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                }
                else{
                    //진루
                    self.runnerState = .RunnerState1
                    
                    self.threeRunnerOneMove()
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = ""
                    self.threeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeRunnerHRecord)
                }
            case .RunnerState20:
                //2, 3-홈 중간(2, 3H)
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState6
                    
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                }
                else{
                    //진루
                    self.runnerState = .RunnerState5
                    self.threeRunnerOneMove()
                    
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = ""
                    self.threeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeRunnerHRecord)
                }
            case .RunnerState22:
                //2H, 3H
                if self.recordState == .NotAdvance {
                    //진루 없음
                    self.runnerState = .RunnerState21
                    self.threeRunnerBackOneMove()
                    
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                } else {
                    //진루
                    self.runnerState = .RunnerState18
                    self.threeRunnerOneMove()
                    
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = ""
                    self.threeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeRunnerHRecord)
                    
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                }
            case .RunnerState51:
                //3, 3H
                self.runnerState = .RunnerState7
                self.threeRunnerOneMove()
                
                self.tempRunnerHRecord.runnerLocation = ""
                self.tempRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.homeRunnerHRecordList.append(self.tempRunnerHRecord)
            case .RunnerState52:
                //1H, 3H
                if self.recordState == .NotAdvance {
                    //진루없음
                    self.runnerState = .RunnerState13
                    
                    self.threeRunnerBackOneMove()
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                }
                else{
                    //진루
                    self.runnerState = .RunnerState10
                    
                    self.threeRunnerOneMove()
                    
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = ""
                    self.threeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.threeRunnerHRecord)
                    
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                }
            default:
                return
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.complete()
        }
        
        /*
        switch hittingRecord{
        case .FlyOut:
            //루 이동은 무조건 한루
            
            if runnerPosition == .OneRunner {//1루
                switch runnerState {
                    
                case .Default:
                    self.runnerState = .RunnerState1
                    self.oneRunnerHRecord = self.currentHRecord
                    
                case .RunnerState1:
                    //1루만 있을 경우 OK
                    self.runnerState = .RunnerState5
                    self.oneRunnerOneMove()
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord.runnerLocation = "2루"
                    self.addActionState = .Default
                    self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                case .RunnerState2:
                    //1,2루만 있을 경우
                    if addActionState == .TwoAction{
                        self.addActionState = .oneAction
                        self.oneRunnerOneMove()
                        self.twoRunnerHRecord = self.tempOneRunnerHRecord
                        self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        self.twoRunnerHRecord.runnerLocation = "2루"
                        self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    }else{
                        self.addActionState = .Default
                        self.runnerState = .RunnerState6
                        self.oneRunnerOneMove()
                        self.twoRunnerHRecord = self.tempOneRunnerHRecord
                        self.twoRunnerHRecord.runnerLocation = "2루"
                        self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                        
                    }
                case .RunnerState3:
                    
                    
                    //1,2,3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState3
                    self.oneRunnerInit()
                    //                self.twoRunnerOneMove()
                    self.oneRunnerOneMove()
                    //                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord.runnerLocation = "2루"
                    //                self.threeRunnerHRecord.runnerLocation = "3루"
                    
                    
                    
                    
                    
                    
                    
                    //1,2,3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState3
                    
                case .RunnerState4:
                    //1,3루만 있을 경우
                    if addActionState == .TwoAction{
                        //
                    }else if addActionState == .oneAction{
                        self.addActionState = .Default
                        self.runnerState = .RunnerState6
                        self.oneRunnerOneMove()
                        self.twoRunnerHRecord = self.tempOneRunnerHRecord
                        self.twoRunnerHRecord.runnerLocation = "2루"
                        self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                        
                        
                        
                        
                    }else{
                        self.addActionState = .Default
                        self.runnerState = .RunnerState6
                    }
                    
                    
                    
                    
                    
                    
                case .RunnerState5:
                    //2루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState7
                    self.twoRunnerInit()
                    self.twoRunnerOneMove()
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = "3루"
                case .RunnerState6:
                    //2,3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState4
                    
                case .RunnerState7:
                    //3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .Default
                    //  self.threeRunnerInit()
                    self.tempThreeRunnerHRecord.runnerLocation = ""
                    self.threeRunnerOneMove()
                    
                    self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                    
                    
                    
                    
                    //                self.addActionState = .Default
                    //                //3루만 있을 경우
                    //                self.runnerState = .RunnerState1
                    
                default:
                    return
                }
                
            }
            else if runnerPosition == .TwoRunner {
                switch runnerState {
                case .Default:
                    break
                case .RunnerState1:
                    //1루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState5
                    //self.oneRunnerInit()
                    self.oneRunnerOneMove()
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord.runnerLocation = "2루"
                case .RunnerState2:
                    //1,2루만 있을 경우
                    if self.addActionState == .oneAction {
                        //1루가 2루로 진루한 경우
                        self.addActionState = .Default
                        
                        if self.recordState == .NotAdvance {
                            self.runnerState = .RunnerState2
                            
                            self.twoRunnerBackOneMove()
                            
                            self.oneRunnerHRecord = self.tempOneRunnerHRecord
                            self.twoRunnerHRecord = self.tempThreeRunnerHRecord
                        }
                        else {
                            self.runnerState = .RunnerState6
                            
                            self.twoRunnerOneMove()
                            
                            self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                            self.threeRunnerHRecord.runnerLocation = "3루"
                            self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                        }
                    }
                    else if self.addActionState == .TwoAction {
                        self.runnerState = .RunnerState2
                        self.addActionState = .oneAction
                        
                        self.oneRunnerHRecord = self.tempOneRunnerHRecord
                        
                        self.twoRunnerOneMove()
                        
                        self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        self.threeRunnerHRecord.runnerLocation = "3루"
                        self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    }
                    else{
                        //1루가 2루로 진루하지 않은 경우
                        self.runnerState = .RunnerState4
                        self.addActionState = .Default
                        
                        self.twoRunnerOneMove()
                        
                        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                        self.threeRunnerHRecord.runnerLocation = "3루"
                        self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    }
                    
                    
                    
                    
                    
                    
                    
                    /*
                    if addActionState == .TwoAction {
                        //1,2루만 있을 경우
                        self.addActionState = .oneAction
//                        self.runnerState = .RunnerState2
                        //                      self.twoRunnerInit()
                        self.twoRunnerOneMove()
                        //                self.oneRunnerOneMove()
                        self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        self.oneRunnerHRecord = self.tempOneRunnerHRecord
                        //                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                        //                self.twoRunnerHRecord.runnerLocation = "2루"
                        self.threeRunnerHRecord.runnerLocation = "3루"
                        self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    }else {
                        self.addActionState = .Default
                        self.runnerState = .RunnerState6
                        //  self.oneRunnerInit()
                        self.twoRunnerOneMove()
                        //                self.oneRunnerOneMove()
                        
                        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                        //                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                        //                self.twoRunnerHRecord.runnerLocation = "2루"
                        
                        self.threeRunnerHRecord.runnerLocation = "3루"
                        self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    }
                    */
                case .RunnerState3:
                    if addActionState == .ThreeAction{
                        //1,2,3루만 있을 경우
                        self.addActionState = .TwoAction
                        
//                        self.oneRunnerInit()
                        //                self.twoRunnerOneMove()
                        self.twoRunnerOneMove()
                        //                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        self.threeRunnerHRecord.runnerLocation = "2루"
                    }else if addActionState == .TwoAction{
                        //1,2,3루만 있을 경우
                        self.addActionState = .oneAction
                        
                        self.oneRunnerInit()
                        //                self.twoRunnerOneMove()
                        self.oneRunnerOneMove()
                        //                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        self.twoRunnerHRecord = self.tempOneRunnerHRecord
                        self.twoRunnerHRecord.runnerLocation = "2루"
                    }else{
                        //1,2,3루만 있을 경우
                        self.addActionState = .Default
                        self.runnerState = .RunnerState6
                        self.oneRunnerInit()
                        //                self.twoRunnerOneMove()
                        self.oneRunnerOneMove()
                        //                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        self.twoRunnerHRecord = self.tempOneRunnerHRecord
                        self.twoRunnerHRecord.runnerLocation = "2루"
                    }
                    
//                    //1,2,3루만 있을 경우
//                    self.addActionState = .Default
//                    self.runnerState = .RunnerState3
//                    self.oneRunnerInit()
//                    //                self.twoRunnerOneMove()
//                    self.oneRunnerOneMove()
//                    //                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
//                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
//                    self.twoRunnerHRecord.runnerLocation = "2루"
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    //
                    //                //1,2,3루만 있을 경우
                    //
                    //                if self.addActionState == .TwoAction {
                    //                    self.addActionState = .oneAction
                    //                    self.runnerState = .RunnerState4
                    //                    self.twoRunnerOneMove()
                    //
                    //                    self.oneRunnerHRecord = self.currentHRecord
                    ////                    self.tempTwoRunnerHRecord.runnerLocation = "2루"
                    //                    self.tempTwoRunnerHRecord.runnerLocation = "3루"
                    //                    self.tempTwoRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    //                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    //                    //수정 상태가 두개일 경우 나머지는 임시 기록지에 저장
                    //                    self.tempRunnerHRecord = self.tempThreeRunnerHRecord
                    //                }
                    
                case .RunnerState4:
                    //1,3루만 있을 경우
                    break
                    
                case .RunnerState5:
                    //2루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState7
                    
                    self.twoRunnerOneMove()
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    
                case .RunnerState6:
                    //2,3루만 있을 경우
                    if addActionState == .TwoAction{
                        self.addActionState = .oneAction
                        self.twoRunnerOneMove()
                        self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        self.threeRunnerHRecord.runnerLocation = "3루"
                        self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    }else{
                        self.addActionState = .Default
                        self.runnerState = .RunnerState7
                        self.twoRunnerOneMove()
                        self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        self.threeRunnerHRecord.runnerLocation = "3루"
                        self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    }
//                    self.addActionState = .Default
//                    self.runnerState = .RunnerState7
                    
                case .RunnerState7:
                    self.addActionState = .Default
                    //3루만 있을 경우
                    self.runnerState = .Default
                    
                default:
                    return
                }
                
            }
            else if runnerPosition == .ThreeRunner {
                switch runnerState {
                case .Default:
                    self.runnerState = .RunnerState1
                    self.oneRunnerHRecord = self.currentHRecord
                case .RunnerState1:
                    //1루만 있을 경우
                    self.runnerState = .RunnerState2
                    
                case .RunnerState2:
                    //1,2루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState4
                    
                    self.twoRunnerOneMove()
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    
                    self.threeRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                case .RunnerState3:
                    
                    
                    //1,2,3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState3
                    self.oneRunnerInit()
                    //                self.twoRunnerOneMove()
                    self.oneRunnerOneMove()
                    //                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord.runnerLocation = "2루"
                    
                    
                    
                    
                    //1,2,3루만 있을 경우
                    if self.addActionState == .TwoAction {
                        //기존 2,3루일 경우에 해당
                        self.addActionState = .oneAction
                        self.runnerState = .RunnerState2
                        self.threeRunnerOneMove()
                        self.oneRunnerHRecord = self.currentHRecord
                        self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                        self.tempThreeRunnerHRecord.runnerLocation = ""
                        self.tempThreeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                        self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                    }
                    else {
                        //기존 1,3루일 경우에 해당
                        self.addActionState = .Default
                        self.runnerState = .RunnerState2
                        self.threeRunnerOneMove()
                        self.oneRunnerHRecord = self.currentHRecord
                        self.twoRunnerHRecord = self.tempOneRunnerHRecord
                        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                        self.tempThreeRunnerHRecord.runnerLocation = ""
                        self.tempThreeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                        self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                    }
                    
                    
                case .RunnerState4:
                    //1,3루만 있을 경우
                    
                    if self.addActionState == .oneAction {
                        self.addActionState = .Default
                        self.runnerState = .RunnerState4
                        self.threeRunnerOneMove()
                        
                        self.oneRunnerHRecord = self.currentHRecord
                        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                        
                        self.tempRunnerHRecord.runnerLocation = ""
                        self.tempRunnerHRecord.threeRecord = self.recordState
                        self.tempRunnerHRecord.threeRecordImage = self.recordState.rawValue
                        self.homeRunnerHRecordList.append(self.tempRunnerHRecord)
                    }
                    else {
                        self.addActionState = .Default
                        self.runnerState = .RunnerState1
                        self.threeRunnerOneMove()
                        self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                    }
                    
                case .RunnerState5:
                    //2루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState4
                    
                case .RunnerState6:
                    //2,3루만 있을 경우
                    if addActionState == .TwoAction{
                        self.addActionState = .oneAction
                        self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                        self.tempTwoRunnerHRecord.runnerLocation = ""
                    }else{
                        self.addActionState = .Default
                        self.runnerState = .RunnerState7
                        self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                        self.tempTwoRunnerHRecord.runnerLocation = ""
                    }
//                    self.addActionState = .Default
//                    self.runnerState = .RunnerState4
                    
                case .RunnerState7://
                    //3루만 있을 경우
                    /*
                    if addActionState == .oneAction {
                        self.addActionState = .Default
                        self.runnerState = .Default
                        //                        self.threeRunnerInit()
                        self.tempThreeRunnerHRecord.runnerLocation = ""
                        self.threeRunnerOneMove()
                        
                        self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                    }else if addActionState == .TwoAction{
                        
                    }
                    */
                    self.addActionState = .Default
                    self.runnerState = .RunnerState1
                    self.threeRunnerOneMove()
                    self.tempThreeRunnerHRecord.runnerLocation = ""
                    self.tempThreeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                default:
                    return
                }
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.complete()
            }
        default:
            
            //루 이동은 무조건 한루
            
            if runnerPosition == .OneRunner {
                switch runnerState {
                case .Default:
                    self.runnerState = .RunnerState1
                    self.oneRunnerHRecord = self.currentHRecord
                case .RunnerState1:
                    //1루만 있을 경우
                    self.runnerState = .RunnerState5
                    self.oneRunnerOneMove()
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord.runnerLocation = "2루"
                    self.addActionState = .Default
                    self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                case .RunnerState2:
                    //1,2루만 있을 경우
                    //self.addActionState = .Default
                    //self.runnerState = .RunnerState4
                    if self.addActionState == .TwoAction {
                        self.addActionState = .oneAction
                        self.runnerState = .RunnerState2
                        
                        self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        
                        if self.recordState == .NotAdvance {
                            self.oneRunnerBackOneMove()
                            
                            self.oneRunnerHRecord = self.tempOneRunnerHRecord
                        }
                        else{
                            self.oneRunnerOneMove()
                            
                            self.twoRunnerHRecord = self.tempOneRunnerHRecord
                            self.twoRunnerHRecord.runnerLocation = "2루"
                            self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                        }
                    }
                    else if self.addActionState == .oneAction {
                        self.addActionState = .Default
                        self.runnerState = .RunnerState6
                        
                        self.oneRunnerOneMove()
                        
                        self.twoRunnerHRecord = self.tempOneRunnerHRecord
                        self.twoRunnerHRecord.runnerLocation = "2루"
                        self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    }
                case .RunnerState3:
                    //1,2,3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState3
                    
                case .RunnerState4:
                    //1,3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState2
                    
                case .RunnerState5:
                    //2루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState7
                    self.twoRunnerInit()
                    self.twoRunnerOneMove()
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = "3루"
                case .RunnerState6:
                    //2,3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState4
                    
                case .RunnerState7:
                    self.addActionState = .Default
                    //3루만 있을 경우
                    self.runnerState = .RunnerState1
                    
                default:
                    return
                }
                
            }
            else if runnerPosition == .TwoRunner {
                switch runnerState {
                case .Default:
                    break
                case .RunnerState1:
                    //1루만 있을 경우
                    break
                case .RunnerState2:
                    //1,2루만 있을 경우
                    /*
                    self.addActionState = .Default
                    self.runnerState = .RunnerState4
                    
                    self.oneRunnerHRecord = self.currentHRecord
                    
                    self.twoRunnerOneMove()
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    
                    self.threeRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    */
                    if self.addActionState == .oneAction {
                        //1루가 2루로 진루한 경우
                        self.addActionState = .Default
                        
                        if self.recordState == .NotAdvance {
                            self.runnerState = .RunnerState2
                            
                            self.twoRunnerBackOneMove()
                            
                            self.oneRunnerHRecord = self.tempOneRunnerHRecord
                            self.twoRunnerHRecord = self.tempThreeRunnerHRecord
                        }
                        else {
                            self.runnerState = .RunnerState6
                            
                            self.twoRunnerOneMove()
                            
                            self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                            self.threeRunnerHRecord.runnerLocation = "3루"
                            self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                        }
                    }
                    else if self.addActionState == .TwoAction {
                        self.runnerState = .RunnerState2
                        self.addActionState = .oneAction
                        
                        self.oneRunnerHRecord = self.tempOneRunnerHRecord
                        
                        self.twoRunnerOneMove()
                        
                        self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        self.threeRunnerHRecord.runnerLocation = "3루"
                        self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    }
                    else{
                        //1루가 2루로 진루하지 않은 경우
                        self.runnerState = .RunnerState4
                        self.addActionState = .Default
                        
                        self.twoRunnerOneMove()
                        
                        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                        self.threeRunnerHRecord.runnerLocation = "3루"
                        self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    }
                case .RunnerState3:
                    //1,2,3루만 있을 경우
                    
                    if self.addActionState == .TwoAction {
                        self.addActionState = .oneAction
                        self.runnerState = .RunnerState4
                        self.twoRunnerOneMove()
                        
                        self.oneRunnerHRecord = self.currentHRecord
                        //                    self.tempTwoRunnerHRecord.runnerLocation = "2루"
                        self.tempTwoRunnerHRecord.runnerLocation = "3루"
                        self.tempTwoRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                        self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                        //수정 상태가 두개일 경우 나머지는 임시 기록지에 저장
                        self.tempRunnerHRecord = self.tempThreeRunnerHRecord
                    }
                    
                case .RunnerState4:
                    //1,3루만 있을 경우
                    break
                    
                case .RunnerState5:
                    //2루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState4
                    
                    self.twoRunnerOneMove()
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    
                case .RunnerState6:
                    //2,3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState7
                    
                case .RunnerState7:
                    self.addActionState = .Default
                    //3루만 있을 경우
                    self.runnerState = .Default
                    
                default:
                    return
                }
                
            }
            else if runnerPosition == .ThreeRunner {
                switch runnerState {
                case .Default:
                    self.runnerState = .RunnerState1
                    self.oneRunnerHRecord = self.currentHRecord
                case .RunnerState1:
                    //1루만 있을 경우
                    self.runnerState = .RunnerState2
                    
                case .RunnerState2:
                    //1,2루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState4
                    
                    self.twoRunnerOneMove()
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    
                    self.threeRunnerHRecord.runnerLocation = "3루"
                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                case .RunnerState3:
                    //1,2,3루만 있을 경우
                    if self.addActionState == .TwoAction {
                        //기존 2,3루일 경우에 해당
                        self.addActionState = .oneAction
                        self.runnerState = .RunnerState2
                        self.threeRunnerOneMove()
                        self.oneRunnerHRecord = self.currentHRecord
                        self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                        self.tempThreeRunnerHRecord.runnerLocation = ""
                        self.tempThreeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                        self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                    }
                    else {
                        //기존 1,3루일 경우에 해당
                        self.addActionState = .Default
                        self.runnerState = .RunnerState2
                        self.threeRunnerOneMove()
                        self.oneRunnerHRecord = self.currentHRecord
                        self.twoRunnerHRecord = self.tempOneRunnerHRecord
                        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                        self.tempThreeRunnerHRecord.runnerLocation = ""
                        self.tempThreeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                        self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                    }
                    
                    
                case .RunnerState4:
                    //1,3루만 있을 경우
                    
                    if self.addActionState == .oneAction {
                        self.addActionState = .Default
                        self.runnerState = .RunnerState4
                        self.threeRunnerOneMove()
                        
                        self.oneRunnerHRecord = self.currentHRecord
                        self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                        
                        self.tempRunnerHRecord.runnerLocation = ""
                        self.tempRunnerHRecord.threeRecord = self.recordState
                        self.tempRunnerHRecord.threeRecordImage = self.recordState.rawValue
                        self.homeRunnerHRecordList.append(self.tempRunnerHRecord)
                    }
                    else {
                        self.addActionState = .Default
                        self.runnerState = .RunnerState1
                        self.threeRunnerOneMove()
                        self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                    }
                    
                case .RunnerState5:
                    //2루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState4
                    
                case .RunnerState6:
                    //2,3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState4
                    
                case .RunnerState7:
                    self.addActionState = .Default
                    //3루만 있을 경우
                    self.addActionState = .Default
                    self.runnerState = .RunnerState1
                    self.threeRunnerOneMove()
                    self.tempThreeRunnerHRecord.runnerLocation = ""
                    self.tempThreeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                default:
                    return
                }
                
            }
        
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.complete()
            }
        }
        */
        
        
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
    
    //1루주자 뒤로 이동 - 2
    func oneRunnerBackTwoMove() {
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                self.twoLocation(runner: self.runner1_2, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                self.threeLocation(runner: self.runner1_2, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    
    //1루주자 뒤로 이동 - 3
    func oneRunnerBackThreeMove() {
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
    
    
    //2루주자 초기화
    func twoRunnerInit() {
        
        if self.addActionState == .Default {
            self.twoLocation(runner: self.runner2_3, imageName: runnerImageName)
        }
        else {
            self.twoLocation(runner: self.runner2_3, imageName: self.runnerGrayImageName)
        }
        
        self.runner2_3.isHidden = false
        
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
    
    //2루주자 뒤로 이동 - 2
    func twoRunnerBackTwoMove() {
        UIView.animateKeyframes(withDuration: 1.1, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                self.twoLocation(runner: self.runner2_3, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                self.threeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    
    

    //3루주자 초기화
    func threeRunnerInit() {
        
        if self.addActionState == .Default {
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
                completeDelegate?.AddActionAnimationComplete(oneRunnerHRecord: self.oneRunnerHRecord, twoRunnerHRecord: self.twoRunnerHRecord, threeRunnerHRecord : self.threeRunnerHRecord, homeRunnerHRecordList : self.homeRunnerHRecordList, tempRunnerHRecord : self.tempRunnerHRecord, runnerState : self.runnerState, addActionState : self.addActionState, runnerPosition: self.runnerPosition)
            }
        }
    }
    
}















