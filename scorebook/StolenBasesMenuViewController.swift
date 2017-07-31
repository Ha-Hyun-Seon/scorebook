//
//  StolenBasesMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit



class StolenBasesMenuViewController: UIViewController {
    
    var recordState : RecordState = RecordState.Default
    var hRecord : HRecordInfo = HRecordInfo()
    var runnerPosition : RunnerPosition = RunnerPosition.Default
    var holdRunnerComplete : HoldRunnerComplete?
    var addActionRunnerState : AddActionRunnerState = AddActionRunnerState.Default
    var currentHRecord : HRecordInfo = HRecordInfo()
    
    @IBAction func clickStealSuccess(_ sender: UIButton) {
        self.recordState = RecordState.StealImage
        
        switch self.runnerPosition {
        case .OneRunner:
            self.hRecord.oneRecord = RecordState.StealImage
            self.hRecord.oneRecordImage = RecordState.StealImage.rawValue
            self.hRecord.oneRecordText = currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
           
        case .TwoRunner:
            self.hRecord.twoRecord = RecordState.StealImage
            self.hRecord.twoRecordImage = RecordState.StealImage.rawValue
//            self.hRecord.oneRecordText = currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
        case .ThreeRunner:
            self.hRecord.threeRecord = RecordState.StealImage
            self.hRecord.threeRecordImage = RecordState.StealImage.rawValue
        default:
            break
        }
        self.addActionRunnerState = AddActionRunnerState.StealAction
        complete()
    }
    @IBAction func clickStealFail(_ sender: UIButton) {
        self.recordState = RecordState.StealError
        
        switch self.runnerPosition {
        case .OneRunner:
            self.hRecord.oneRecord = RecordState.StealError
            self.hRecord.oneRecordImage = RecordState.StealError.rawValue
//            self.hRecord.oneRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
        case .TwoRunner:
            self.hRecord.twoRecord = RecordState.StealError
            self.hRecord.twoRecordImage = RecordState.StealError.rawValue
//            self.hRecord.twoRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
        case .ThreeRunner:
            self.hRecord.threeRecord = RecordState.StealError
            self.hRecord.threeRecordImage = RecordState.StealError.rawValue
//            self.hRecord.threeRecordText = Utils(currentHRecord: self.currentHRecord).currentHRecord.number.replacingOccurrences(of: "번타자", with: "")
        default:
            break
        }
        addActionRunnerState = AddActionRunnerState.StealAction
        complete()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
