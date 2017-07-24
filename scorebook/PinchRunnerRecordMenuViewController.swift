//
//  PinchRunnerRecordMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//  대기주자기록 : 단독주자-대기주자메뉴

import UIKit



class PinchRunnerRecordMenuViewController: UIViewController {
    
    //자기 기록지
    var hRecord : HRecordInfo = HRecordInfo()
    //타격 기록지
    var currentHRecord : HRecordInfo = HRecordInfo()
    //주자 포지션
    var runnerPosition : RunnerPosition = RunnerPosition.Default
    var runnerCompleteDelegate : BaseRunnerComplete?
    
    //루 상태(1,12,13,23....)
    var runnerState : RunnerState = .Default
    
    //주자 진루 형태
    var addActionRunnerState : AddActionRunnerState = AddActionRunnerState.Default
    
    var addActionRunnerSate : AddActionRunnerState = AddActionRunnerState.Default
    var recordState : RecordState = RecordState.Default
    var holdrunnerCompleteDelegate : HoldRunnerComplete?
    
    @IBOutlet weak var wildPitchButton: UIButton!   // 폭투에 의한
    @IBOutlet weak var passedBallButton: UIButton!  // 포일에 의한
    @IBOutlet weak var defenseErrorCausedByAdvanceButton: UIButton! // 실책에 의한
    @IBOutlet weak var batterByAdvanceButton: UIButton! // 타자에 의한
    @IBOutlet weak var stealByAdvanceButton: UIButton!  // 스틸에 의한
    @IBOutlet weak var checkAdvanceButton: UIButton!    // 견제에 의한
    @IBOutlet weak var runnerAdvanceButton: UIButton!   // 주자에 의한
    @IBOutlet weak var tagOutButton: UIButton!  // 태그 아웃
    @IBOutlet weak var waitStateStealErrorButton: UIButton! // 도루 실패
    @IBOutlet weak var separateNotAdvanceButton: UIButton!  // 진루 없음
    
    @IBAction func clickWildPitch(_ sender: UIButton) {
    }
    
    @IBAction func clickPassedBall(_ sender: UIButton) {
    }
    
    @IBAction func clickDefenseError(_ sender: UIButton) {
    }
    
    @IBAction func clickBatterByAdvance(_ sender: UIButton) {
    }
    
    @IBAction func clickStealByAdvance(_ sender: UIButton) {
        self.recordState = RecordState.StealImage
        complete()
    }
    
    @IBAction func clickCheckAdvance(_ sender: UIButton) {
    }
    
    @IBAction func clickRunnerAdvance(_ sender: UIButton) {
    }
    
    @IBAction func clickTagOut(_ sender: UIButton) {
    }
    
    @IBAction func clickWaitStateStealError(_ sender: UIButton) {
    }
    
    @IBAction func clickSeparateNotAdvance(_ sender: UIButton) {
        self.recordState = RecordState.NotAdvance
        complete()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wildPitchButton.isEnabled = false
        passedBallButton.isEnabled = false
        defenseErrorCausedByAdvanceButton.isEnabled = false
        batterByAdvanceButton.isEnabled = false
        stealByAdvanceButton.isEnabled = false
        checkAdvanceButton.isEnabled = false
        runnerAdvanceButton.isEnabled = false
        tagOutButton.isEnabled = false
        tagOutButton.isEnabled = false
        
        switch addActionRunnerState {
        case .StealAction:
            stealByAdvanceButton.isEnabled = true
        default:
            break
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    func complete(){
        if ((self.holdrunnerCompleteDelegate) != nil) {
            holdrunnerCompleteDelegate?.HoldRunnerCompletePopover(runnerPosition: self.runnerPosition, record: self.hRecord, addActionRunnerState: self.addActionRunnerState, recordState: self.recordState)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

