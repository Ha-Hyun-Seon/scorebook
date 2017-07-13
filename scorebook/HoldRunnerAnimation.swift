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
    var tempOneRunnerHRecord : HRecordInfo = HRecordInfo()
    var tempTwoRunnerHRecord : HRecordInfo = HRecordInfo()
    var tempThreeRunnerHRecord : HRecordInfo = HRecordInfo()
    var tempHomeRunnerHRecordList : [HRecordInfo] = [HRecordInfo]()
    
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
    
    init(runner1 : UIButton, runner2 : UIButton, runner3 : UIButton, runnerH_1 : UIButton, runner1_2 : UIButton, runner2_3 : UIButton, runner3_H : UIButton, currentHRecord : HRecordInfo, oneRunnerHRecord : HRecordInfo, twoRunnerHRecord : HRecordInfo, threeRunnerHRecord : HRecordInfo, homeRunnerHRecordList: [HRecordInfo], runnerState : RunnerState, runnerPosition : RunnerPosition, recordState : RecordState, addActionState : AddActionState) {
        
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
        self.recordState = recordState
        self.runnerPosition = runnerPosition
        self.addActionState = addActionState
        
    }
    
    func RunnerAnimation() {
        
        //루 이동은 무조건 한루
        
        if runnerPosition == .OneRunner {
            self.oneRunnerInit()
            switch runnerState {
            case .Default:
                self.runnerState = .Default
            case .RunnerState1:
                //1루만 있을 경우
                self.oneRunnerOneMove()
                self.runnerState = .RunnerState5
                self.twoRunnerHRecord = self.tempOneRunnerHRecord
                self.twoRunnerHRecord.runnerLocation = "2루"
                self.twoRunnerHRecord.oneRecord = self.recordState
                self.twoRunnerHRecord.oneRecordImage = self.recordState.rawValue
                
            case .RunnerState2:
                //1,2루만 있을 경우
                self.runnerState = .RunnerState6
            case .RunnerState3:
                //1,2,3루만 있을 경우
                self.runnerState = .RunnerState6
                
            case .RunnerState4:
                //1,3루만 있을 경우
                self.runnerState = .RunnerState6
                
            case .RunnerState5:
                //2루만 있을 경우
                self.runnerState = .RunnerState4
                
            case .RunnerState6:
                //2,3루만 있을 경우
                self.addActionState = .Default
                self.runnerState = .RunnerState4
                
            case .RunnerState7:
                //3루만 있을 경우
                self.runnerState = .RunnerState1
                
            default:
                return
            }
            
        }
        else if runnerPosition == .TwoRunner {
            self.twoRunnerInit()
            switch runnerState {
            case .Default:
                break
            case .RunnerState1:
                //1루만 있을 경우
                break
            case .RunnerState2:
                //1,2루만 있을 경우
                self.twoRunnerOneMove()
                self.runnerState = .RunnerState4
                self.oneRunnerHRecord = self.tempOneRunnerHRecord
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.twoRecord = self.recordState
                self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue

            case .RunnerState3:
                //1,2,3루만 있을 경우
                self.runnerState = .RunnerState3
                
            case .RunnerState4:
                //1,3루만 있을 경우
                break
                
            case .RunnerState5:
                //2루만 있을 경우
                self.twoRunnerOneMove()
                self.runnerState = .RunnerState7
                self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = "3루"
                self.threeRunnerHRecord.twoRecord = self.recordState
                self.threeRunnerHRecord.twoRecordImage = self.recordState.rawValue
                
            case .RunnerState6:
                //2,3루만 있을 경우
                self.runnerState = .RunnerState7
                
            case .RunnerState7:
                //3루만 있을 경우
                self.runnerState = .Default
                
            default:
                return
            }
            
        }
        else if runnerPosition == .ThreeRunner {
            self.threeRunnerInit()
            switch runnerState {
            case .Default:
                self.runnerState = .Default
            case .RunnerState1:
                //1루만 있을 경우
                self.runnerState = .RunnerState1
            case .RunnerState2:
                //1,2루만 있을 경우
                self.runnerState = .RunnerState2
            case .RunnerState3:
                //1,2,3루만 있을 경우
                self.threeRunnerOneMove()
                self.runnerState = .RunnerState2
                self.oneRunnerHRecord = self.tempOneRunnerHRecord
                self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = ""
                self.threeRunnerHRecord.threeRecord = self.recordState
                self.threeRunnerHRecord.threeRecordImage = self.recordState.rawValue
                self.homeRunnerHRecordList.append(self.threeRunnerHRecord)
            case .RunnerState4:
                //1,3루만 있을 경우
                self.threeRunnerOneMove()
                self.runnerState = .RunnerState1
                self.oneRunnerHRecord = self.tempOneRunnerHRecord
                self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = ""
                self.threeRunnerHRecord.threeRecord = self.recordState
                self.threeRunnerHRecord.threeRecordImage = self.recordState.rawValue
                self.homeRunnerHRecordList.append(self.threeRunnerHRecord)
                
            case .RunnerState5:
                //2루만 있을 경우
                self.runnerState = .RunnerState4
                
            case .RunnerState6:
                //2,3루만 있을 경우
                self.threeRunnerOneMove()
                self.runnerState = .RunnerState5
                self.twoRunnerHRecord = self.tempTwoRunnerHRecord
                self.threeRunnerHRecord = self.tempThreeRunnerHRecord
                self.threeRunnerHRecord.runnerLocation = ""
                self.threeRunnerHRecord.threeRecord = self.recordState
                self.threeRunnerHRecord.threeRecordImage = self.recordState.rawValue
                self.homeRunnerHRecordList.append(self.threeRunnerHRecord)

                
            case .RunnerState7:
                self.addActionState = .Default
                //3루만 있을 경우
                self.threeRunnerOneMove()
                self.runnerState = .Default
                //3루 기록지가 없다면 타자가 친 경우이다
                if self.tempThreeRunnerHRecord.number == "" {
                    self.tempThreeRunnerHRecord = self.currentHRecord
                }
                self.tempThreeRunnerHRecord.runnerLocation = ""
                self.tempThreeRunnerHRecord.threeRecord = self.recordState
                self.tempThreeRunnerHRecord.threeRecordImage = self.recordState.rawValue
                self.homeRunnerHRecordList.append(self.tempThreeRunnerHRecord)
                
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
            //주자들 초기화
            self.setRunnerViewByRunnerState()
            
            completeDelegate?.AnimationComplete(oneRunnerHRecord: self.oneRunnerHRecord, twoRunnerHRecord: self.twoRunnerHRecord, threeRunnerHRecord : self.threeRunnerHRecord, homeRunnerHRecordList : self.homeRunnerHRecordList, runnerState : self.runnerState, addActionState : self.addActionState, runnerPosition: self.runnerPosition)
        }
    }
    
}














