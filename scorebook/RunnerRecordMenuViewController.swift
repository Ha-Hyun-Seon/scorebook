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
//        if self.runnerPosition == RunnerPosition.OneRunner {
//            self.recordState = RecordState.TwoAdvanceArrows
//        }
//        else if self.runnerPosition == RunnerPosition.TwoRunner {
//            self.recordState = RecordState.ThreeAdvanceArrows
//        }
//        else if self.runnerPosition == RunnerPosition.ThreeRunner {
//            self.recordState = RecordState.HomeAdvanceArrows
//        }
        //연속 진루
        self.recordState = RecordState.AdvanceArrow
        self.addActionRunnerSate = AddActionRunnerState.BatterAction
        
        self.complete()

    }
    
    //수비수 실책
    @IBAction func clickDefenseErrorButton(_ sender: Any) {
        
    }
    
    //태그 아웃
    @IBAction func clickTagOutButton(_ sender: Any) {
    }
    
    func complete() {
        if((self.runnerCompleteDelegate) != nil)
        {
            runnerCompleteDelegate?.HoldRunnerCompletePopover(runnerPosition: self.runnerPosition, record: self.hRecord, addActionRunnerState : self.addActionRunnerSate, recordState : self.recordState)
            self.dismiss(animated: true, completion: nil)
        }
    }

}
