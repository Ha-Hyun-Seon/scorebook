//
//  DefenderAddRunMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//  추가진루

import UIKit



class DefenderAddRunMenuViewController: UIViewController {
    
    var recordState : RecordState = RecordState.Default
    var hRecord : HRecordInfo = HRecordInfo()
    var runnerPosition : RunnerPosition = RunnerPosition.Default
    var holdRunnerComplete : HoldRunnerComplete?
    var addActionRunnerState : AddActionRunnerState = AddActionRunnerState.Default
    var sendd : String = ""
    
    @IBOutlet weak var addOutMenuViewInCatchAndThrowButton: UIButton!   // 포구 송구동작
    @IBOutlet weak var addAdvanceMenuViewInThrowButton: UIButton!   // 송구자 실책 진루
    @IBOutlet weak var addAdvanceMenuViewInCatchButton: UIButton!   // 포구자 실책 진루
    @IBOutlet weak var addAdvanceMenuViewInDefenseErrorButton: UIButton!    // 수비수 실책 진루
    
    @IBAction func clickCatchAndThrowButton(_ sender: UIButton) {
        recordState = RecordState.ThroughPass
        complete()
    }
    
    @IBAction func clickThrowButton(_ sender: UIButton) {
    }
    
    @IBAction func clickCatchButton(_ sender: UIButton) {
    }
    
    @IBAction func clickErrorButton(_ sender: UIButton) {
    }
    
    @IBAction func clickTagOutButton(_ sender: UIButton) {
        //hRecord.00RecordText += ""
        
        recordState = RecordState.TagOut
        
        complete()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addOutMenuViewInCatchAndThrowButton.isEnabled=false
        addAdvanceMenuViewInThrowButton.isEnabled=false
        addAdvanceMenuViewInCatchButton.isEnabled=false
        addAdvanceMenuViewInDefenseErrorButton.isEnabled=false
        if hRecord.threeRecord != .Default {
            if hRecord.threeRecord == .StealError{
                addOutMenuViewInCatchAndThrowButton.isEnabled=true
            }
        }else if hRecord.twoRecord != .Default{
            if hRecord.twoRecord == .StealError{
                addOutMenuViewInCatchAndThrowButton.isEnabled=true
            }
        }else if hRecord.oneRecord != .Default{
            if hRecord.oneRecord == .StealError{
                addOutMenuViewInCatchAndThrowButton.isEnabled=true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func complete(){
        holdRunnerComplete?.HoldRunnerCompletePopover(runnerPosition: self.runnerPosition, record: self.hRecord, addActionRunnerState: self.addActionRunnerState, recordState: self.recordState)
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
