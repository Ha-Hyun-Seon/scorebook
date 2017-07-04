//
//  RuunerAnimation.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 23..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation
import UIKit


class RunnerAnimation_bak
{
    
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
    
    //타자 애미메이션인지 체크
    var isBatter : Bool = false
    
    //루상 주자 체크
    var isOneRunner : Bool = false
    var isTwoRunner : Bool = false
    var isThreeRunner : Bool = false
    
    //주자별 기록지(타자, 1루, 2루, 3루)
    var currentHRecord : HRecordInfo = HRecordInfo()
    var oneRunnerHRecord : HRecordInfo = HRecordInfo()
    var twoRunnerHRecord : HRecordInfo = HRecordInfo()
    var threeRunnerHRecord : HRecordInfo = HRecordInfo()
    var homeRunnerHRecord : HRecordInfo = HRecordInfo()
    
    var tempOneRunnerHRecord : HRecordInfo = HRecordInfo()
    var tempTwoRunnerHRecord : HRecordInfo = HRecordInfo()
    var tempThreeRunnerHRecord : HRecordInfo = HRecordInfo()
    var tempHomeRunnerHRecord : HRecordInfo = HRecordInfo()
    
    //득점 상황
    var isHomein : Bool = false
    var homeinLocation : String = ""
    
    //달리는 주자 이미지
    let runnerImageName = "RV_runner_btn.png"
    let runnerGrayImageName = "RV_runner_gray_btn.png"
    
    var completeDelegate : RunnerAnimationComplete?
    
    init(runner1 : UIButton, runner2 : UIButton, runner3 : UIButton, runnerH_1 : UIButton, runner1_2 : UIButton, runner2_3 : UIButton, runner3_H : UIButton, currentHRecord : HRecordInfo, oneRunnerHRecord : HRecordInfo, twoRunnerHRecord : HRecordInfo, threeRunnerHRecord : HRecordInfo, homeRunnerHRecord: HRecordInfo, isOneRunner : Bool, isTwoRunner : Bool, isThreeRunner : Bool) {
    
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
        self.tempHomeRunnerHRecord = homeRunnerHRecord
        self.isOneRunner = isOneRunner
        self.isTwoRunner = isTwoRunner
        self.isThreeRunner = isThreeRunner
        
        //시작점일 때 고정된 주자는 안보이게 한다.
        self.runner1.isHidden = true
        self.runner2.isHidden = true
        self.runner3.isHidden = true
        
        self.isHomein = false
        self.homeinLocation = ""
        
    }
    
    func setRunnerHRecord() {
        
    }
    
    func hittingRunnerAnimation(recordState : RecordState) {
        
        //타자
        self.isBatter = true
        
        //달리는 시작 지점 이동
        self.homeLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
        
        self.runnerH_1.isHidden = false
        
        switch recordState {
            
        case RecordState.FourBall:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.oneLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isOneRunner = true
                    self.oneRunnerHRecord = self.currentHRecord
                    self.complete()
                }
                
            })
            
        case RecordState.OneHit:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.oneLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isOneRunner = true
                    self.oneRunnerHRecord = self.currentHRecord
                    self.complete()
                }
                
            })
            
        case RecordState.TwoHit:
            
            UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                    self.oneLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
                })
                UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                    self.twoLocation(runner: self.runnerH_1, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isTwoRunner = true
                    self.twoRunnerHRecord = self.currentHRecord
                    self.complete()
                }
                
            })
            
        case RecordState.ThreeHit:
            
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
                
            }, completion: {finished in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isThreeRunner = true
                    self.threeRunnerHRecord = self.currentHRecord
                    self.complete()
                }
            })
            
        case RecordState.HomeRun:
            
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
                
            }, completion: {finished in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isHomein = true
                    self.homeinLocation = "H"
                    self.homeRunnerHRecord = self.currentHRecord
                    self.complete()
                }
            })
            
        default:
            return
        }
    }
    
    func oneRunnerAnimation(recordState : RecordState) {
        
        //달리는 시작 지점 이동
        self.oneLocation(runner: self.runner1_2, imageName: runnerImageName)
        
        //1루 주자는 사라진다.
        self.isOneRunner = false
        self.oneRunnerHRecord = HRecordInfo()
        
        self.runner1_2.isHidden = false
        
        switch recordState {
          
        case RecordState.FourBall:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.twoLocation(runner: self.runner1_2, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isTwoRunner = true
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.complete()
                }
            })
            
        case RecordState.OneHit:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.twoLocation(runner: self.runner1_2, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isTwoRunner = true
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.complete()
                }
            })
            
        case RecordState.TwoHit:
            
            UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                    self.twoLocation(runner: self.runner1_2, imageName: self.runnerImageName)
                })
                UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                    self.threeLocation(runner: self.runner1_2, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isThreeRunner = true
                    self.threeRunnerHRecord = self.tempOneRunnerHRecord
                    self.complete()
                }
                
            })
            
        case RecordState.ThreeHit:
            
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
                
            }, completion: {finished in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isHomein = true
                    self.homeinLocation = "1"
                    self.homeRunnerHRecord = self.tempOneRunnerHRecord
                    self.complete()
                }
            })
            
        case RecordState.HomeRun:
            
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
                
            }, completion: {finished in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isHomein = true
                    self.homeinLocation = "1"
                    self.homeRunnerHRecord = self.tempOneRunnerHRecord
                    self.complete()
                }
            })
            
        case RecordState.TwoAdvanceArrows:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.twoLocation(runner: self.runner1_2, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isTwoRunner = true
                    self.twoRunnerHRecord = self.tempOneRunnerHRecord
                    self.complete()
                }
            })
            
        default:
            
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
                
            }, completion: {finished in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isHomein = true
                    self.homeinLocation = "1"
                    self.homeRunnerHRecord = self.tempOneRunnerHRecord
                    self.complete()
                }
            })
        }
    }
    
    func twoRunnerAnimation(recordState : RecordState) {
        
        //달리는 시작 지점 이동
        self.twoLocation(runner: self.runner2_3, imageName: runnerImageName)
        
        //2루 주자는 사라진다
        self.isTwoRunner = false
        self.twoRunnerHRecord = HRecordInfo()
        
        self.runner2_3.isHidden = false
        
        switch recordState {
            
        case RecordState.FourBall:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.threeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isThreeRunner = true
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.complete()
                }
                
            })
            
        case RecordState.OneHit:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.threeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isThreeRunner = true
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.complete()
                }
                
            })
            
        case RecordState.TwoHit:
            
            UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                    self.threeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
                })
                UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                    self.homeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isHomein = true
                    self.homeinLocation = "2"
                    self.homeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.complete()
                    
                }
                
            })
            
        case RecordState.ThreeHit:
            
            UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                    self.threeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
                })
                UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                    self.homeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isHomein = true
                    self.homeinLocation = "2"
                    self.homeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.complete()
                    
                }
                
            })
            
        case RecordState.HomeRun:
            
            UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                    self.threeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
                })
                UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 2/2, animations: {
                    self.homeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isHomein = true
                    self.homeinLocation = "2"
                    self.homeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.complete()
                    
                }
                
            })
            
        case RecordState.ThreeAdvanceArrows:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.threeLocation(runner: self.runner2_3, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.isThreeRunner = true
                    self.threeRunnerHRecord = self.tempTwoRunnerHRecord
                    self.complete()
                }
                
            })
            
        default:
            self.isTwoRunner = true
            self.complete()
        }
    }
    
    func threeRunnerAnimation(recordState : RecordState) {
        
        //달리는 시작 지점 이동
        self.threeLocation(runner: self.runner3_H, imageName: runnerImageName)
        
        //3루 주자는 사라진다
        self.isThreeRunner = false
        self.threeRunnerHRecord = HRecordInfo()
        
        self.runner3_H.isHidden = false
        
        switch recordState {
            
        case RecordState.FourBall:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.homeLocation(runner: self.runner3_H, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.isHomein = true
                    self.homeinLocation = "3"
                    self.homeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.complete()
                }
                
            })
        case RecordState.OneHit:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.homeLocation(runner: self.runner3_H, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.isHomein = true
                    self.homeinLocation = "3"
                    self.homeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.complete()
                }
                
            })
        case RecordState.TwoHit:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.homeLocation(runner: self.runner3_H, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.isHomein = true
                    self.homeinLocation = "3"
                    self.homeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.complete()
                }
                
            })
            
        case RecordState.ThreeHit:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.homeLocation(runner: self.runner3_H, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.isHomein = true
                    self.homeinLocation = "3"
                    self.homeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.complete()
                }
                
            })
            
        case RecordState.HomeRun:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.homeLocation(runner: self.runner3_H, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.isHomein = true
                    self.homeinLocation = "3"
                    self.homeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.complete()
                }
                
            })
            
        case RecordState.HomeAdvanceArrows:
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.homeLocation(runner: self.runner3_H, imageName: self.runnerImageName)
                })
                
            }, completion: {finished in
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.isHomein = true
                    self.homeinLocation = "3"
                    self.homeRunnerHRecord = self.tempThreeRunnerHRecord
                    self.complete()
                }
                
            })

            
        default:
            self.isThreeRunner = true
            self.complete()
        }
        
        
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
    
    func complete() {
        if((self.completeDelegate) != nil)
        {
//            print(String(self.isOneRunner) + ", " + String(self.isTwoRunner) + ", " + String(self.isThreeRunner))
            
            if self.isOneRunner == true {
                self.runner1.isHidden = false
            }
            else {
                self.runner1.isHidden = true
            }
            
            if self.isTwoRunner == true {
                self.runner2.isHidden = false
            }
            else {
                self.runner2.isHidden = true
            }
            
            if self.isThreeRunner == true {
                self.runner3.isHidden = false
            }
            else {
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
            
//            completeDelegate?.AnimationComplete(isBatter : self.isBatter, isOneRunner: self.isOneRunner, isTwoRunner: self.isTwoRunner, isThreeRunner: self.isThreeRunner, isHomein: self.isHomein, homeinLocation: self.homeinLocation, oneRunnerHRecord: self.oneRunnerHRecord, twoRunnerHRecord: self.twoRunnerHRecord, threeRunnerHRecord : self.threeRunnerHRecord, homeRunnerHRecord : self.homeRunnerHRecord, runnerState : RunnerState.Default)
        }
    }
    
}














