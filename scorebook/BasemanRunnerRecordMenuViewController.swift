//
//  basemanRunnerRecordMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//  포구송구 != 0

import UIKit



class BasemanRunnerRecordMenuViewController: UIViewController {
    
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
    var addActionRunnerSate : AddActionRunnerState = AddActionRunnerState.Default
    
    var recordState : RecordState = RecordState.Default
    
    @IBOutlet weak var fielderChoiceButton: UIButton!   // 야수 선택
    @IBOutlet weak var batterByAdvanceButton: UIButton! // 타자에 의한 진루
    @IBOutlet weak var connectedStateRunnerOutButton: UIButton! // 주자 아웃
    @IBOutlet weak var separateNotAdvanceButton: UIButton!  // 진루 없음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.SetButtons()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickFielderIsChoice(_ sender: Any) {
    }
    @IBAction func clickBatterByAdvance(_ sender: Any) {
        
//        let playerNumberInfo : Utils = Utils(currentHRecord: self.currentHRecord)
//        
//        //주자 상태에 따라 진루
//        if self.runnerPosition == RunnerPosition.OneRunner {
//            self.hRecord.oneRecordImage = playerNumberInfo.getRecordStateImageStringByBatterNumber()
//        }
//        else if self.runnerPosition == RunnerPosition.TwoRunner {
//            self.hRecord.threeRecordImage = playerNumberInfo.getRecordStateImageStringByBatterNumber()
//        }
//        else if self.runnerPosition == RunnerPosition.ThreeRunner {
//            self.hRecord.homeRecordImage = playerNumberInfo.getRecordStateImageStringByBatterNumber()
//        }

        self.recordState = RecordState.AdvanceArrow
        
        self.addActionRunnerSate = AddActionRunnerState.BatterAction
        self.complete()

    }
    @IBAction func clickConnectedStateRunnerOut(_ sender: Any) {
    }
    @IBAction func clickSeparateNotAdvance(_ sender: Any) {
        self.recordState = RecordState.NotAdvance
        
        self.addActionRunnerSate = AddActionRunnerState.BatterAction
        self.complete()
    }
    
    func SetButtons() {
        if runnerPosition == .ThreeRunner {
            if self.runnerState == .RunnerState4 || self.runnerState == .RunnerState29 {
                self.separateNotAdvanceButton.isHidden = true
            }
        }
        
        //1H를 선택하고 루상태값이 2루에 있는 경우에는 진루불가
        if runnerPosition == .OneRunner {
            if self.runnerState == .RunnerState12 {
                self.batterByAdvanceButton.isEnabled = false
            }
        }
        
        //2H를 선택하고 루상태값이 2루에 있는 경우에는 진루없음 불가
        if runnerPosition == .TwoRunner {
            if self.runnerState == .RunnerState21 {
                self.batterByAdvanceButton.isEnabled = false
            }
            
            if self.runnerState == .RunnerState19 {
                self.separateNotAdvanceButton.isEnabled = false
            }
        }
    }
    
    func complete() {
        if((self.runnerCompleteDelegate) != nil)
        {
            runnerCompleteDelegate?.BaseRunnerCompletePopover(runnerPosition: self.runnerPosition, record: self.hRecord, addActionRunnerState : self.addActionRunnerSate, recordState : self.recordState)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
