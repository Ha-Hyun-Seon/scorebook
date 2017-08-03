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
    
    //폭투에 의한
    @IBAction func clickWildPitch(_ sender: UIButton) {
    }
    
    //포일에 의한
    @IBAction func clickPassedBall(_ sender: UIButton) {
    }
    
    // 실책에 의한
    @IBAction func clickDefenseError(_ sender: UIButton) {
    }
    
    // 타자에 의한
    @IBAction func clickBatterByAdvance(_ sender: UIButton) {
    }
    
    // 스틸에 의한
    @IBAction func clickStealByAdvance(_ sender: UIButton) {
        self.recordState = RecordState.StealImage
        complete()
    }
    
    // 견제에 의한
    @IBAction func clickCheckAdvance(_ sender: UIButton) {
    }
    
    // 주자에 의한
    @IBAction func clickRunnerAdvance(_ sender: UIButton) {
        
        self.recordState = RecordState.AdvanceArrow
        complete()
    }
    
    // 태그 아웃
    @IBAction func clickTagOut(_ sender: UIButton) {
        self.recordState = RecordState.StealError
        
        switch self.runnerPosition {
        case .OneRunner:
            self.hRecord.oneRecord = RecordState.StealError
//            self.hRecord.oneRecordImage = RecordState.StealError.rawValue
        case .TwoRunner:
            self.hRecord.twoRecord = RecordState.StealError
//            self.hRecord.twoRecordImage = RecordState.StealError.rawValue
        case .ThreeRunner:
            self.hRecord.threeRecord = RecordState.StealError
//            self.hRecord.threeRecordImage = RecordState.StealError.rawValue
        default:
            break
        }
        complete()
    }
    
    //도루실패
    @IBAction func clickWaitStateStealError(_ sender: UIButton) {
        self.recordState = RecordState.StealError
        
        switch self.runnerPosition {
        case .OneRunner:
            self.hRecord.oneRecord = RecordState.StealError
//            self.hRecord.oneRecordImage = RecordState.StealError.rawValue
        case .TwoRunner:
            self.hRecord.twoRecord = RecordState.StealError
//            self.hRecord.twoRecordImage = RecordState.StealError.rawValue
        case .ThreeRunner:
            self.hRecord.threeRecord = RecordState.StealError
//            self.hRecord.threeRecordImage = RecordState.StealError.rawValue
        default:
            break
        }
        addActionRunnerState = AddActionRunnerState.StealAction
        complete()
    }
    
    //진루없음
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
        waitStateStealErrorButton.isEnabled = false
        
        switch addActionRunnerState {
        case .StealAction:
            stealByAdvanceButton.isEnabled = true
            waitStateStealErrorButton.isEnabled = true
        case .runnerAction:
            runnerAdvanceButton.isEnabled = true
            tagOutButton.isEnabled = true
        default:
            break
        }
        // Do any additional setup after loading the view, typically from a nib.
        button()
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
    func button(){
        
        switch runnerPosition {
        case .OneRunner:
            switch runnerState {
            case .RunnerState12:
                stealByAdvanceButton.isEnabled = false
                runnerAdvanceButton.isEnabled = false
            case .RunnerState17:
                stealByAdvanceButton.isEnabled = false
                runnerAdvanceButton.isEnabled = false
            case .RunnerState30:
                stealByAdvanceButton.isEnabled = false
                runnerAdvanceButton.isEnabled = false
            case .RunnerState34:
                stealByAdvanceButton.isEnabled = false
                runnerAdvanceButton.isEnabled = false
            default:
                return
            }
        case .TwoRunner:
            switch runnerState {
            case .RunnerState19:
                separateNotAdvanceButton.isEnabled = false
            case .RunnerState21:
                stealByAdvanceButton.isEnabled = false
                runnerAdvanceButton.isEnabled = false
            case .RunnerState26:
                separateNotAdvanceButton.isEnabled = false
            case .RunnerState27:
                stealByAdvanceButton.isEnabled = false
                runnerAdvanceButton.isEnabled = false
            case .RunnerState32:
                stealByAdvanceButton.isEnabled = false
                runnerAdvanceButton.isEnabled = false
            case .RunnerState33:
                stealByAdvanceButton.isEnabled = false
                runnerAdvanceButton.isEnabled = false
            case .RunnerState34:
                stealByAdvanceButton.isEnabled = false
                runnerAdvanceButton.isEnabled = false
            case .RunnerState35:
                stealByAdvanceButton.isEnabled = false
                runnerAdvanceButton.isEnabled = false
                separateNotAdvanceButton.isEnabled = false
            default:
                return
            }
        case .ThreeRunner:
            switch runnerState {
            case .RunnerState27:
                separateNotAdvanceButton.isEnabled = false
            case .RunnerState28:
                separateNotAdvanceButton.isEnabled = false
            case .RunnerState29:
                separateNotAdvanceButton.isEnabled = false
            case .RunnerState31:
                separateNotAdvanceButton.isEnabled = false
            default:
                return
            }
        default:
            return
        }
    }
}

