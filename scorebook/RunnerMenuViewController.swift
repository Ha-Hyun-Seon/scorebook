//
//  RunnerMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit



class RunnerMenuViewController: UIViewController {
    
    var recordState : RecordState = RecordState.Default
    var holdRunnerComplete : HoldRunnerComplete?
    var runnerPosition : RunnerPosition = RunnerPosition.Default
    var hRecord : HRecordInfo = HRecordInfo()
    var addActionRunnerState : AddActionRunnerState = AddActionRunnerState.Default
    var currentInningInfo : InningInfo = InningInfo()
    var currentLineup : Lineup = Lineup()
    var teamKind = ""
    var mainRunnerMenuCompleteDelegate : MainRunnerMenuComplete?
    var changeRunnerCompleteDelegate : ChangeRunnerComplete?
    var currentHRecord : HRecordInfo = HRecordInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //도루
    @IBAction func clickStolenBase(_ sender: UIButton) {
        let stolenBasesMenuViewController = storyboard?.instantiateViewController(withIdentifier: "stolenbasesmenu") as! StolenBasesMenuViewController
        
        stolenBasesMenuViewController.hRecord = self.hRecord;
        stolenBasesMenuViewController.currentHRecord = self.currentHRecord
        stolenBasesMenuViewController.runnerPosition = self.runnerPosition
        stolenBasesMenuViewController.holdRunnerComplete = self.holdRunnerComplete
        
        
        stolenBasesMenuViewController.preferredContentSize = CGSize(width: 200, height: 208)
        
        stolenBasesMenuViewController.modalPresentationStyle = .popover
        
        if let popoverController = stolenBasesMenuViewController.popoverPresentationController {
            popoverController.sourceView = sender as! UIView
            popoverController.sourceRect = (sender as AnyObject).bounds
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self.parent as! UIPopoverPresentationControllerDelegate?
        }
        
        present(stolenBasesMenuViewController, animated: true, completion: nil)
    }
    
    
    //견제
    @IBAction func clickCheckAdvance(_ sender: UIButton) {
        let pickOffMenuViewController = storyboard?.instantiateViewController(withIdentifier: "pickoffmenu") as! PickOffMenuViewController //팝오버할 뷰컨트롤러 선언
//                stolenBasesMenuViewController.stolenBasesCompleteDelegate = self.stolenBasesCompleteDelegate
//                stolenBasesMenuViewController.teamKind = self.teamKind
        
        pickOffMenuViewController.preferredContentSize = CGSize(width: 200, height: 208)//사이즈(창크기) 조절
        
        pickOffMenuViewController.modalPresentationStyle = .popover//팝오버 선언
        
        if let popoverController = pickOffMenuViewController.popoverPresentationController {
            popoverController.sourceView = sender as! UIView//origin설정(?)
            popoverController.sourceRect = (sender as AnyObject).bounds//origin설정(?)
            popoverController.permittedArrowDirections = .any//방향설정
            popoverController.delegate = self.parent as! UIPopoverPresentationControllerDelegate?//델리게이트 설정
        }
        
        present(pickOffMenuViewController, animated: true, completion: nil)//델리게이트 설정
    }
    
    //폭투
    @IBAction func clickWildPitch(_ sender: UIButton) {
        
    }
    
    //포일
    @IBAction func clickPassedBall(_ sender: UIButton) {
        self.hRecord.oneRecord = RecordState.PassedBall
        self.hRecord.oneRecordImage = RecordState.PassedBall.rawValue
        complete()
        
    }
    
    
    //선수 교체
    @IBAction func clickChangeRunner(_ sender: Any) {
        let changeRunnerMenuViewController = storyboard?.instantiateViewController(withIdentifier: "changerunner") as! ChangeRunnerMenuViewController
        changeRunnerMenuViewController.changeRunnerCompleteDelegate = self.changeRunnerCompleteDelegate
        changeRunnerMenuViewController.teamKind = self.teamKind
        changeRunnerMenuViewController.preferredContentSize = CGSize(width: 220, height: 360)
        
        changeRunnerMenuViewController.modalPresentationStyle = .popover
        
        if let popoverController = changeRunnerMenuViewController.popoverPresentationController {
            popoverController.sourceView = sender as! UIView
            popoverController.sourceRect = (sender as AnyObject).bounds
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self.parent as! UIPopoverPresentationControllerDelegate?
        }
        
        present(changeRunnerMenuViewController, animated: true, completion: nil)
    }
    
    
    func complete(){
        holdRunnerComplete?.HoldRunnerCompletePopover(runnerPosition: self.runnerPosition, record: self.hRecord, addActionRunnerState: self.addActionRunnerState, recordState: self.recordState)
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
