//
//  RuunerAnimation.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 23..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation
import UIKit

class RunnerAnimation {
    
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
    
    
    //주자 상태
//    0. 아무도 없을 경우 - 타자 무조건 이동
//    1. 1루만 있을 경우 - 무조건 이동
//    2. 1,2루만 있을 경우 - 무조건 이동
//    3. 1,2,3루만 있을 경우 - 무조건 이동
//    4. 1,3루만 있을 경우 - 1루만 무조건 이동, 3루 주자는 중간에 멈춤
//    5. 2루만 있을 경우 - 2루 주자 중간에 멈춤
//    6. 2,3루만 있을 경우 - 2,3루 주자 중간에 멈춤
//    7. 3루만 있을 경우 - 3루 주자 중간에 멈춤
    
    var runnerState : RunnerState = RunnerState.Default
    
    //중간 입력 상태
    var addActionState : AddActionState
    
    
    ////루상 주자 체크
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
    
    ////주자 포지션
    var runnerPosition : RunnerPosition = RunnerPosition.Default
    
    
    //달리는 주자 이미지
    let runnerImageName = "RV_runner_btn.png"
    let runnerGrayImageName = "RV_runner_gray_btn.png"
    
    var completeDelegate : RunnerAnimationComplete?
    
    init(runner1 : UIButton, runner2 : UIButton, runner3 : UIButton, runnerH_1 : UIButton, runner1_2 : UIButton, runner2_3 : UIButton, runner3_H : UIButton, currentHRecord : HRecordInfo, oneRunnerHRecord : HRecordInfo, twoRunnerHRecord : HRecordInfo, threeRunnerHRecord : HRecordInfo, homeRunnerHRecordList: [HRecordInfo], runnerState : RunnerState, addActionState : AddActionState) {
        
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
        self.runnerState = runnerState
        self.addActionState = addActionState
        
        //시작점일 때 고정된 주자는 안보이게 한다.
        self.runner1.isHidden = true
        self.runner2.isHidden = true
        self.runner3.isHidden = true
        
    }
    
    func RunnerAnimation(recordState : RecordState) {
        
        
        //루 이동
        let moveRunCount = self.getMoveCount(recordState: recordState)
        
        //타자 초기화
        if moveRunCount != 0{
            self.batterRunnerInit()
        }
        
        //애니메이션 시간
        var animationTime : Double = 0
        
        //이동 루상
        if moveRunCount == 1 {
            //루상 상태에 따른 이동
            switch runnerState {
            case .Default:
                self.runnerState = .RunnerState1
                self.oneRunnerHRecord = self.currentHRecord
            case .RunnerState1:
                //1루만 있을 경우
                self.runnerState = .RunnerState2
                self.oneRunnerInit()
                self.oneRunnerOneMove()
                self.oneRunnerHRecord = self.currentHRecord
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
            case .RunnerState2:
                //1,2루만 있을 경우
                self.runnerState = .RunnerState3
                self.oneRunnerInit()
                self.twoRunnerInit()
                self.twoRunnerOneMove()
                self.oneRunnerOneMove()
                self.oneRunnerHRecord = self.currentHRecord
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
            case .RunnerState3:
                //1,2,3루만 있을 경우
                self.runnerState = .RunnerState3
                self.oneRunnerInit()
                self.twoRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.twoRunnerOneMove()
                self.oneRunnerOneMove()
                self.oneRunnerHRecord = self.currentHRecord
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                for index in 0...self.homeRunnerHRecordList.count - 1 {
                    self.homeRunnerHRecordList[index].runnerLocation = ""
                    self.homeRunnerHRecordList[index].threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                }
            case .RunnerState4:
                //1,3루만 있을 경우
                self.addActionState = .oneAction
                self.runnerState = .RunnerState3
                self.oneRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerHalfMove()
                self.oneRunnerOneMove()
                self.oneRunnerHRecord = self.currentHRecord
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                
            case .RunnerState5:
                //2루만 있을 경우
                self.addActionState = .oneAction
                self.runnerState = .RunnerState2
                self.twoRunnerInit()
                self.twoRunnerHalfMove()
                self.oneRunnerHRecord = self.currentHRecord
                self.twoRunnerHRecord = self.tempTwoRunnerHRecord
            case .RunnerState6:
                //2,3루만 있을 경우
                self.addActionState = .TwoAction
                self.runnerState = .RunnerState3
                self.twoRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerHalfMove()
                self.twoRunnerHalfMove()
                self.oneRunnerHRecord = self.currentHRecord
                self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord = self.tempThreeRunnerHRecord
            case .RunnerState7:
                self.addActionState = .oneAction
                //3루만 있을 경우
                self.runnerState = .RunnerState4
                self.threeRunnerInit()
                self.threeRunnerHalfMove()
                self.oneRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord = self.tempThreeRunnerHRecord
            default:
                return
            }
            
            self.batterOneMove()
            animationTime = 0.5
        }
        else if moveRunCount == 2 {
            //루상 상태에 따른 이동
            switch runnerState {
            case .Default:
                self.runnerState = .RunnerState5
                self.twoRunnerHRecord = self.currentHRecord
            case .RunnerState1:
                //1루만 있을 경우
                self.runnerState = .RunnerState6
                self.oneRunnerInit()
                self.oneRunnerTwoMove()
                self.twoRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord = self.tempOneRunnerHRecord
                
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.twoRecord = RecordState.ThreeAdvanceArrows
                self.threeRunnerHRecord.twoRecordImage = RecordState.ThreeAdvanceArrows.rawValue
                
            case .RunnerState2:
                //1,2루만 있을 경우
                self.runnerState = .RunnerState6
                self.oneRunnerInit()
                self.twoRunnerInit()
                self.twoRunnerTwoMove()
                self.oneRunnerTwoMove()
                self.twoRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord = self.tempOneRunnerHRecord
                
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.twoRecord = RecordState.ThreeAdvanceArrows
                self.threeRunnerHRecord.twoRecordImage = RecordState.ThreeAdvanceArrows.rawValue
                
                self.tempTwoRunnerHRecord.runnerLocation = ""
                self.tempTwoRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempTwoRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempTwoRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                self.homeRunnerHRecordList.append(self.tempTwoRunnerHRecord)
                
            case .RunnerState3:
                //1,2,3루만 있을 경우
                self.runnerState = .RunnerState6
                self.oneRunnerInit()
                self.twoRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.twoRunnerTwoMove()
                self.oneRunnerTwoMove()
                
                self.twoRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord = self.tempOneRunnerHRecord
                
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.twoRecord = RecordState.ThreeAdvanceArrows
                self.threeRunnerHRecord.twoRecordImage = RecordState.ThreeAdvanceArrows.rawValue
                
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.homeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                
                
                self.tempTwoRunnerHRecord.runnerLocation = ""
                self.tempTwoRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempTwoRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempTwoRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                self.homeRunnerHRecordList.append(self.tempTwoRunnerHRecord)
                
                
            case .RunnerState4:
                //1,3루만 있을 경우
                self.runnerState = .RunnerState6
                self.oneRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.oneRunnerTwoMove()
                
                self.twoRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord = self.tempOneRunnerHRecord
                
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.threeRunnerHRecord.twoRecord = RecordState.ThreeAdvanceArrows
                self.threeRunnerHRecord.twoRecordImage = RecordState.ThreeAdvanceArrows.rawValue
                
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.homeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                
            case .RunnerState5:
                //2루만 있을 경우
                self.runnerState = .RunnerState5
                self.twoRunnerInit()
                self.twoRunnerTwoMove()
                
                self.twoRunnerHRecord = self.currentHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                
                self.tempTwoRunnerHRecord.runnerLocation = ""
                self.tempTwoRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempTwoRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempTwoRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.homeRunnerHRecordList.append(self.tempTwoRunnerHRecord)
                
            case .RunnerState6:
                //2,3루만 있을 경우
                self.runnerState = .RunnerState5
                self.twoRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.twoRunnerOneMove()
                
                self.twoRunnerHRecord = self.currentHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.homeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                
                self.tempTwoRunnerHRecord.runnerLocation = ""
                self.tempTwoRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempTwoRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempTwoRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                self.homeRunnerHRecordList.append(self.tempTwoRunnerHRecord)
                
            case .RunnerState7:
                //3루만 있을 경우
                self.runnerState = .RunnerState5
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                
                self.twoRunnerHRecord = self.currentHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                
            default:
                return
            }
            
            self.batterTwoMove()
            animationTime = 1
        }
        else if moveRunCount == 3 {
            //루상 상태에 따른 이동
            switch runnerState {
            case .Default:
                self.runnerState = .RunnerState7
                self.threeRunnerHRecord = self.currentHRecord
            case .RunnerState1:
                //1루만 있을 경우
                self.runnerState = .RunnerState7
                self.oneRunnerInit()
                self.oneRunnerThreeMove()
                
                self.threeRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.homeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                
            case .RunnerState2:
                //1,2루만 있을 경우
                self.runnerState = .RunnerState7
                self.oneRunnerInit()
                self.twoRunnerInit()
                self.twoRunnerTwoMove()
                self.oneRunnerThreeMove()
                
                self.threeRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                
                self.tempOneRunnerHRecord.runnerLocation = ""
                self.tempOneRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempOneRunnerHRecord.twoRecord = RecordState.TwoAdvanceArrows
                self.tempOneRunnerHRecord.twoRecordImage = RecordState.TwoAdvanceArrows.rawValue
                self.tempOneRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempOneRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.tempTwoRunnerHRecord.runnerLocation = ""
                self.tempTwoRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempTwoRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempTwoRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.homeRunnerHRecordList.append(self.tempTwoRunnerHRecord)
                self.homeRunnerHRecordList.append(self.tempOneRunnerHRecord)
                
            case .RunnerState3:
                //1,2,3루만 있을 경우
                self.runnerState = .RunnerState7
                self.oneRunnerInit()
                self.twoRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.twoRunnerTwoMove()
                self.oneRunnerThreeMove()
                
                self.threeRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                
                self.tempOneRunnerHRecord.runnerLocation = ""
                self.tempOneRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempOneRunnerHRecord.twoRecord = RecordState.TwoAdvanceArrows
                self.tempOneRunnerHRecord.twoRecordImage = RecordState.TwoAdvanceArrows.rawValue
                self.tempOneRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempOneRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.tempTwoRunnerHRecord.runnerLocation = ""
                self.tempTwoRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempTwoRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempTwoRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempThreeRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                self.homeRunnerHRecordList.append(self.tempTwoRunnerHRecord)
                self.homeRunnerHRecordList.append(self.tempOneRunnerHRecord)
                
            case .RunnerState4:
                //1,3루만 있을 경우
                self.runnerState = .RunnerState7
                self.oneRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.oneRunnerThreeMove()
                
                self.threeRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                
                self.tempOneRunnerHRecord.runnerLocation = ""
                self.tempOneRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempOneRunnerHRecord.twoRecord = RecordState.TwoAdvanceArrows
                self.tempOneRunnerHRecord.twoRecordImage = RecordState.TwoAdvanceArrows.rawValue
                self.tempOneRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempOneRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempThreeRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                self.homeRunnerHRecordList.append(self.tempOneRunnerHRecord)
                
            case .RunnerState5:
                //2루만 있을 경우
                self.runnerState = .RunnerState7
                self.twoRunnerInit()
                self.twoRunnerTwoMove()
                
                self.threeRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                
                self.tempTwoRunnerHRecord.runnerLocation = ""
                self.tempTwoRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempTwoRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempTwoRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.homeRunnerHRecordList.append(self.tempTwoRunnerHRecord)
                
            case .RunnerState6:
                //2,3루만 있을 경우
                self.runnerState = .RunnerState7
                self.twoRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.twoRunnerTwoMove()
                
                self.threeRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                
                self.tempTwoRunnerHRecord.runnerLocation = ""
                self.tempTwoRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                self.tempTwoRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempTwoRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempThreeRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                self.homeRunnerHRecordList.append(self.tempTwoRunnerHRecord)
                
            case .RunnerState7:
                //3루만 있을 경우
                self.runnerState = .RunnerState7
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                
                self.threeRunnerHRecord = self.currentHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.threeRecord = RecordState.HomeAdvanceArrows
                self.tempThreeRunnerHRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
                
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                
            default:
                return
            }
            
            self.batterThreeMove()
            animationTime = 1.5
        }
        else if moveRunCount == 4 {
            //루상 상태에 따른 이동
            switch runnerState {
            case .Default:
                self.runnerState = .Default
            case .RunnerState1:
                //1루만 있을 경우
                self.runnerState = .Default
                self.oneRunnerInit()
                self.oneRunnerThreeMove()
            case .RunnerState2:
                //1,2루만 있을 경우
                self.runnerState = .Default
                self.oneRunnerInit()
                self.twoRunnerInit()
                self.twoRunnerTwoMove()
                self.oneRunnerThreeMove()
            case .RunnerState3:
                //1,2,3루만 있을 경우
                self.runnerState = .Default
                self.oneRunnerInit()
                self.twoRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.twoRunnerTwoMove()
                self.oneRunnerThreeMove()
            case .RunnerState4:
                //1,3루만 있을 경우
                self.runnerState = .Default
                self.oneRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.oneRunnerThreeMove()
            case .RunnerState5:
                //2루만 있을 경우
                self.runnerState = .Default
                self.twoRunnerInit()
                self.twoRunnerTwoMove()
            case .RunnerState6:
                //2,3루만 있을 경우
                self.runnerState = .Default
                self.twoRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.twoRunnerTwoMove()
            case .RunnerState7:
                //3루만 있을 경우
                self.runnerState = .Default
                self.threeRunnerInit()
                self.threeRunnerOneMove()
            default:
                return
            }
            
            self.batterFourMove()
            animationTime = 2
        }
        else if moveRunCount == 5 {
            //루상 상태에 따른 이동
            switch runnerState {
            case .Default:
                self.runnerState = .RunnerState1
            case .RunnerState1:
                //1루만 있을 경우
                self.runnerState = .RunnerState2
                self.oneRunnerInit()
                self.oneRunnerOneMove()
            case .RunnerState2:
                //1,2루만 있을 경우
                self.runnerState = .RunnerState3
                self.oneRunnerInit()
                self.twoRunnerInit()
                self.twoRunnerOneMove()
                self.oneRunnerOneMove()
            case .RunnerState3:
                //1,2,3루만 있을 경우
                self.runnerState = .RunnerState3
                self.oneRunnerInit()
                self.twoRunnerInit()
                self.threeRunnerInit()
                self.threeRunnerOneMove()
                self.twoRunnerOneMove()
                self.oneRunnerOneMove()
            case .RunnerState4:
                //1,3루만 있을 경우
                self.runnerState = .RunnerState3
                self.runner3.isHidden = false
                self.oneRunnerInit()
                self.oneRunnerOneMove()
            case .RunnerState5:
                //2루만 있을 경우
                self.runner2.isHidden = false
                self.runnerState = .RunnerState2
            case .RunnerState6:
                //2,3루만 있을 경우
                self.runner2.isHidden = false
                self.runner3.isHidden = false
                self.runnerState = .RunnerState3
            case .RunnerState7:
                //3루만 있을 경우
                self.runner3.isHidden = false
                self.runnerState = .RunnerState4
            default:
                return
            }
            
            self.batterOneMove()
        }else if moveRunCount == 0 {
            switch recordState {
            case .FlyOut:
                switch runnerState {
                    
                case .Default:
                    break

                case .RunnerState1:

                    //1루만 있을 경우
                    self.addActionState = .oneAction
                    self.runnerState = .RunnerState1
                    self.oneRunnerInit()//1루 초기화
                    self.oneRunnerHalfMove()//1-2루 중간
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    
                    
                    
                    
                    
                    
                    
                    
                case .RunnerState2:
                    //1,2루만 있을 경우
                    self.addActionState = .TwoAction
                    self.runnerState = .RunnerState2
                    self.oneRunnerInit()
                    self.twoRunnerInit()
                    self.twoRunnerHalfMove()
                    self.oneRunnerHalfMove()
                    //self.oneRunnerHRecord = self.currentHRecord
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    
//                    self.twoRunnerHRecord.runnerLocation = "2루"
//                    self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
//                    self.threeRunnerHRecord.runnerLocation = "3루"
//                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                case .RunnerState3:
                    //1,2,3루만 있을 경우
                    self.addActionState = .ThreeAction
                    self.runnerState = .RunnerState3
                    self.oneRunnerInit()
                    self.twoRunnerInit()
                    self.threeRunnerInit()
                    self.threeRunnerHalfMove()
                    self.twoRunnerHalfMove()
                    self.oneRunnerHalfMove()
                    self.oneRunnerHRecord = self.tempOneRunnerHRecord
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
//                    self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
//                    
//                    self.twoRunnerHRecord.runnerLocation = "2루"
//                    self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
//                    self.threeRunnerHRecord.runnerLocation = "3루"
//                    self.threeRunnerHRecord.twoRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
//                    for index in 0...self.homeRunnerHRecordList.count - 1 {
//                        self.homeRunnerHRecordList[index].runnerLocation = ""
//                        self.homeRunnerHRecordList[index].threeRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
//                    }
                case .RunnerState4:
                    //1,3루만 있을 경우
                    self.addActionState = .oneAction
                    self.runnerState = .RunnerState4
                    self.oneRunnerInit()
                    self.threeRunnerInit()
                    self.threeRunnerHalfMove()
                    self.oneRunnerHalfMove()
                    self.oneRunnerHRecord = self.currentHRecord
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    
                    self.twoRunnerHRecord.runnerLocation = "2루"
                    self.twoRunnerHRecord.oneRecordImage = Utils(currentHRecord: self.currentHRecord).getRecordStateImageStringByBatterNumber()
                    
                case .RunnerState5:
                    //2루만 있을 경우
                    self.addActionState = .oneAction
                    self.runnerState = .RunnerState5
                    self.twoRunnerInit()
                    self.twoRunnerHalfMove()
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord

                    
                case .RunnerState6:
                    //2,3루만 있을 경우
                    self.addActionState = .TwoAction
                    self.runnerState = .RunnerState6
                    self.twoRunnerInit()
                    self.threeRunnerInit()
                    self.threeRunnerHalfMove()
                    self.twoRunnerHalfMove()
                    self.oneRunnerHRecord = self.currentHRecord
                    self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                case .RunnerState7:
                    
                    
                    
                    //3루만 있을 경우
                    self.addActionState = .oneAction
                    self.runnerState = .RunnerState7
                    self.threeRunnerInit()
                    self.threeRunnerHalfMove()
                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                    
                    
                    
                    
                    
                    
//                    self.addActionState = .oneAction
//                    //3루만 있을 경우
//                    self.runnerState = .RunnerState4
//                    self.threeRunnerInit()
//                    self.threeRunnerHalfMove()
//                    self.oneRunnerHRecord = self.currentHRecord
//                    self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                default:
                    return
                }
//                self.batterOneMove()
                animationTime = 0.5
            default: break
//                return
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationTime) {
            self.complete()
        }
    }
    
    
    func getMoveCount (recordState : RecordState) -> Int {
        var moveRunCount = 0
        
        //일반 타격(안타, 2루타, 3루타, 홈런)
        switch recordState {
        case .OneHit:
            moveRunCount = 1
        case .TwoHit:
            moveRunCount = 2
        case .ThreeHit:
            moveRunCount = 3
        case .HomeRun:
            moveRunCount = 4
        case .FourBall:
            moveRunCount = 1
        case .HitByPitch:
            moveRunCount = 1
        case .BatterInterfere:
            moveRunCount = 1
//        case .FlyOut://
//            moveRunCount = 5
        default:
            moveRunCount = 0
        }
        
        return moveRunCount
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
        
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
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
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 2/3, animations: {
                self.twoLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 3/3, animations: {
                self.threeLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            
        }, completion: {finished in})
    }
    
    //타자 이동 - 4
    func batterFourMove() {

        UIView.animateKeyframes(withDuration: 2.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/4, animations: {
                self.oneLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/4, relativeDuration: 2/4, animations: {
                self.twoLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 2/4, relativeDuration: 3/4) {
                self.threeLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 4/4) {
                self.homeLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
            }
            
        }, completion: {finished in})
        
        
        
    }
    
    //1루주자 초기화
    func oneRunnerInit() {
        
        
        if self.addActionState == .Default {
            
            self.oneLocation(runner: self.runner1_2, imageName: runnerImageName)
        }
        else {
            
            self.oneLocation(runner: self.runner1_2, imageName: runnerGrayImageName)
        }
        
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
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
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
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 2/3, animations: {
                self.threeLocation(runner: self.runner1_2, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 3/3, animations: {
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
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                self.threeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                self.homeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
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
    
    //3루주자 반 이동(추가 입력 요구)
    func threeRunnerHalfMove() {
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
            //print(String(self.isOneRunner) + ", " + String(self.isTwoRunner) + ", " + String(self.isThreeRunner))
            
            if self.addActionState == .Default{
                //주자들 초기화
                self.setRunnerViewByRunnerState()
                completeDelegate?.AnimationComplete(oneRunnerHRecord: self.oneRunnerHRecord, twoRunnerHRecord: self.twoRunnerHRecord, threeRunnerHRecord : self.threeRunnerHRecord, homeRunnerHRecordList : self.homeRunnerHRecordList, runnerState : self.runnerState, addActionState : self.addActionState)
            }
            else {
                completeDelegate?.AddActionAnimationComplete(oneRunnerHRecord: self.oneRunnerHRecord, twoRunnerHRecord: self.twoRunnerHRecord, threeRunnerHRecord : self.threeRunnerHRecord, homeRunnerHRecordList : self.homeRunnerHRecordList, tempRunnerHRecord : self.tempRunnerHRecord, runnerState : self.runnerState, addActionState : self.addActionState)
            }
        
        }
    }
}















