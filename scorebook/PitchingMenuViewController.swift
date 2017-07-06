//
//  PitchingMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit

class PitchingMenuViewController: UIViewController {
    var test : Bool = false
    var hRecord : HRecordInfo = HRecordInfo()
    var pRecord : PRecordInfo = PRecordInfo()
    var recordImageInfo : RecordImageInfo = RecordImageInfo()
    
    //투구 전광판 (스트라이크, 볼, 아웃 카운트)
    var pitcherScoreBoardInfo : PitcherScoreBoardInfo = PitcherScoreBoardInfo()
    
    //낫 아웃때문에 주자가 1루에 있는지 확인
    var isRunner1 : Bool = false
    
    @IBOutlet weak var intentional4Balls: UIButton! // 고의 4구 버튼
    @IBOutlet weak var notOutMenuView: UIButton!    // 낫 아웃 버튼
    @IBOutlet weak var balkButton: UIButton!    // 보크

    var pitcherCompleteDelegate : PitcherPopoverComplete?
    var batterCompleteDelegate : BatterPopoverComplete?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //낫 아웃 버튼
        if isRunner1 == false && self.pitcherScoreBoardInfo.strikeCount == 2 {
            self.notOutMenuView.isEnabled = true
        }
        
        //고의 사구 버튼
        if self.pitcherScoreBoardInfo.ballCount == 3 {
            self.intentional4Balls.isEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //스트라이크
    @IBAction func clickPitchingStrike(_ sender: AnyObject) {
        self.hRecord.pitcherRecord.append(RecordState.PitchingStrike)
        self.hRecord.pitcherRecordImage.append(RecordState.PitchingStrike.rawValue)
        self.pitcherScoreBoardInfo.strikeCount += 1
        self.completeStrike()
        
            
        
    }
    
    //볼
    @IBAction func clickPitchingBall(_ sender: AnyObject) {
        self.hRecord.pitcherRecord.append(RecordState.PitchingBall)
        self.hRecord.pitcherRecordImage.append(RecordState.PitchingBall.rawValue)
        self.pitcherScoreBoardInfo.ballCount += 1
        
        self.completeBall()
    }
    
    //헛스윙,파울팁
    @IBAction func clickPitchingSwing(_ sender: AnyObject) {
        self.hRecord.pitcherRecord.append(RecordState.PitchingSwing)
        self.hRecord.pitcherRecordImage.append(RecordState.PitchingSwing.rawValue)
        self.pitcherScoreBoardInfo.strikeCount += 1
        self.completeStrike()
        
    }
    
    //번트 헛스윙
    @IBAction func clickPitchingBuntSwing(_ sender: AnyObject) {
        self.hRecord.pitcherRecord.append(RecordState.PitchingBuntSwing)
        self.hRecord.pitcherRecordImage.append(RecordState.PitchingBuntSwing.rawValue)
        self.pitcherScoreBoardInfo.strikeCount += 1
        self.completeStrike()
        
    }
    
    
    //타격 파울
    @IBAction func clickPitchingFoul(_ sender: AnyObject) {
        self.hRecord.pitcherRecord.append(RecordState.PitchingFoul)
        self.hRecord.pitcherRecordImage.append(RecordState.PitchingFoul.rawValue)
        
        if self.pitcherScoreBoardInfo.strikeCount < 2 {
            self.pitcherScoreBoardInfo.strikeCount += 1
        }
        self.completeStrike()
        
    }
    
    //번트 파울
    @IBAction func clickPitchingBuntFoul(_ sender: AnyObject) {
        self.hRecord.pitcherRecord.append(RecordState.PitchingBuntFoul)
        self.hRecord.pitcherRecordImage.append(RecordState.PitchingBuntFoul.rawValue)
        self.pitcherScoreBoardInfo.strikeCount += 1
        self.completeStrike()
        
    }
    
    
    //고의 4구
    @IBAction func clickIntentionalBall(_ sender: AnyObject) {
        self.hRecord.pitcherRecord.append(RecordState.PitchingBall)
        self.hRecord.pitcherRecordImage.append(RecordState.PitchingBall.rawValue)
        self.hRecord.homeRecord = RecordState.IntentionalBall
        self.hRecord.homeRecordImage = RecordState.IntentionalBall.rawValue
        self.pitcherScoreBoardInfo.ballCount += 1
        self.pitcherScoreBoardInfo.isPitcherChanged = true
        self.complete()
    }
    
    //사구
    @IBAction func clickFourBall(_ sender: AnyObject) {
        self.hRecord.pitcherRecord.append(RecordState.PitchingEnd)//???????
//----------------------------------------        
    self.hRecord.pitcherRecordImage.append(RecordState.PitchingEnd.rawValue)//세로줄
        if self.pitcherScoreBoardInfo.ballCount==3 {
            self.pitcherScoreBoardInfo.ballCount+=2
        }else if self.pitcherScoreBoardInfo.ballCount==2 {
            self.pitcherScoreBoardInfo.ballCount+=3
        }else if self.pitcherScoreBoardInfo.ballCount==1 {
            self.pitcherScoreBoardInfo.ballCount+=4
        }else if self.pitcherScoreBoardInfo.ballCount==0 {
            self.pitcherScoreBoardInfo.ballCount+=5
        }else{
            
        }
//----------------------------------------
   
        self.pitcherScoreBoardInfo.isPitcherChanged = true
        self.complete()
    }
   
    //타격방해
    @IBAction func clickBatterInterfere(_ sender: AnyObject) {
        self.hRecord.pitcherRecord.append(RecordState.PitchingEnd)
        self.hRecord.pitcherRecordImage.append(RecordState.PitchingEnd.rawValue)
        
        self.hRecord.homeRecord = RecordState.BatterInterfere
        print(self.hRecord.homeRecord.rawValue)
        self.hRecord.homeRecordImage = RecordState.BatterInterfere.rawValue
        self.pitcherScoreBoardInfo.orderCount = 1
        self.pitcherScoreBoardInfo.isPitcherChanged = true
        self.complete()
    }
    
    //낫 아웃
    @IBAction func clickNotOut(_ sender: AnyObject) {
        self.hRecord.pitcherRecord.append(RecordState.NotOut)
        self.hRecord.pitcherRecordImage.append(RecordState.NotOut.rawValue)
        self.pitcherScoreBoardInfo.strikeCount += 1
        self.completeStrike()
    }
    
    //타격
    @IBAction func clickBatter(_ sender: AnyObject) {
        let BattingMenuViewController = storyboard?.instantiateViewController(withIdentifier: "battermenu") as! BattingMenuViewController
        BattingMenuViewController.completeDelegate = self.batterCompleteDelegate
        BattingMenuViewController.preferredContentSize = CGSize(width: 320, height: 420)
        BattingMenuViewController.hRecord = self.hRecord
        BattingMenuViewController.pitcherScoreBoardInfo = self.pitcherScoreBoardInfo//값전달 
        BattingMenuViewController.modalPresentationStyle = .popover
        
        if let popoverController = BattingMenuViewController.popoverPresentationController {
            popoverController.sourceView = sender as! UIView
            popoverController.sourceRect = sender.bounds
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self.parent as! UIPopoverPresentationControllerDelegate?
        }
        
//        self.dismiss(animated: true, completion: nil)
        present(BattingMenuViewController, animated: true, completion: nil)
    }
    
    //보크
    @IBAction func clickBalk(_ sender: AnyObject) {
        //보크 이미지 없음
        self.hRecord.pitcherRecord.append(RecordState.PitchingStrike)
        self.hRecord.pitcherRecordImage.append(RecordState.PitchingStrike.rawValue)
        self.complete()
        
    }
    
    //나가기
    @IBAction func clickExit(_ sender: AnyObject) {
        self.complete()
        
    }
    
    func complete() {
        if((self.pitcherCompleteDelegate) != nil)
        {
            pitcherCompleteDelegate?.PitcherCompletedPopover()
           
        
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    func completeBall() {
        if((self.pitcherCompleteDelegate) != nil)
        {
            pitcherCompleteDelegate?.PitcherCompletedPopover()
            
            
            
            if self.pitcherScoreBoardInfo.ballCount==0 {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func completeStrike() {
        if((self.pitcherCompleteDelegate) != nil)
        {
            pitcherCompleteDelegate?.PitcherCompletedPopover()
            
            
            
            if self.pitcherScoreBoardInfo.strikeCount==0 {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
