//
//  RunnerRecordMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//  주자기록 : 주자기본 메뉴-연속되는

import UIKit



class RunnerRecordMenuViewController: UIViewController {
    
    var hRecord : HRecordInfo = HRecordInfo()
    var runnerPosition : RunnerPosition = RunnerPosition.Default
    var isRunning : Bool = false
    var recordState : RecordState = RecordState.Default
    var runnerState : RunnerState = RunnerState.Default
    
    //주자 진루 형태
    var addActionRunnerSate : AddActionRunnerState = AddActionRunnerState.Default
    
    var runnerCompleteDelegate : HoldRunnerComplete?
    
    @IBOutlet weak var addAdvanceButton: UIButton!  // 연속 진루
    @IBOutlet weak var defenseErrorButton: UIButton!    // 수비수 실책
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setIsRunning()
        button()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //다음 루에 주자가 있으면 연속 진루가 안된다.
    func setIsRunning() {
        if isRunning == true {
            self.addAdvanceButton.isEnabled = false
        }
        else {
            self.addAdvanceButton.isEnabled = true
        }
    }
    
    //연속 진루
    @IBAction func clickAddAdvanceButton(_ sender: Any) {

        //주자 상태에 따라 진루
            self.recordState = RecordState.AdvanceArrow
        
        self.complete()

    }
    
    //수비수 실책
    @IBAction func clickDefenseErrorButton(_ sender: Any) {//클릭후 수비수 클릭을 할수 있어야됨
        //수비수클릭시 DefenderErrorMenuView가 나와야됨
        self.recordState = RecordState.AdvanceArrow
        self.addActionRunnerSate = AddActionRunnerState.ErrorAction
        self.complete()
        
    }
    
    //태그 아웃
    @IBAction func clickTagOutButton(_ sender: Any) {
        //2루만 완료
        if self.addActionRunnerSate == .StealAction{
            self.recordState = RecordState.StealError
            switch self.runnerPosition {
            case .OneRunner:
                self.hRecord.oneRecord = RecordState.StealError
                self.hRecord.oneRecordImage = RecordState.TwoAdvanceArrows.rawValue
            case .TwoRunner:
                self.hRecord.twoRecord = RecordState.StealError
                self.hRecord.twoRecordImage = RecordState.ThreeAdvanceArrows.rawValue
            case .ThreeRunner:
                self.hRecord.threeRecord = RecordState.StealError
                self.hRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
            default:
                break
            }
            self.addActionRunnerSate = AddActionRunnerState.runnerAction
        }else{
            self.recordState = RecordState.TagOut
        }
        
        
        self.complete()
        
        
    }
    
    func complete() {
        if((self.runnerCompleteDelegate) != nil)
        {
            runnerCompleteDelegate?.HoldRunnerCompletePopover(runnerPosition: self.runnerPosition, record: self.hRecord, addActionRunnerState : self.addActionRunnerSate, recordState : self.recordState)
            self.dismiss(animated: true, completion: nil)
        }
    }
    func button(){
        switch runnerPosition {
        case .OneRunner:
            switch runnerState {
            case .RunnerState12:
                addAdvanceButton.isEnabled = false
            case .RunnerState17:
                addAdvanceButton.isEnabled = false
            case .RunnerState30:
                addAdvanceButton.isEnabled = false
            case .RunnerState34:
                addAdvanceButton.isEnabled = false
            default:
                return
            }
        case .TwoRunner:
            switch runnerState {
            case .RunnerState6:
                addAdvanceButton.isEnabled = false
            case .RunnerState21:
                addAdvanceButton.isEnabled = false
            case .RunnerState27:
                addAdvanceButton.isEnabled = false
            case .RunnerState32:
                addAdvanceButton.isEnabled = false
            case .RunnerState33:
                addAdvanceButton.isEnabled = false
            case .RunnerState34:
                addAdvanceButton.isEnabled = false
            case .RunnerState35:
                addAdvanceButton.isEnabled = false
            default:
                return
            }
        default:
            return
        }
    }

}
