//
//  BattingMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit



class BattingMenuViewController: UIViewController{
    
    var hRecord : HRecordInfo = HRecordInfo()
    //투구 전광판 (스트라이크, 볼, 아웃 카운트)
    var pitcherScoreBoardInfo : PitcherScoreBoardInfo = PitcherScoreBoardInfo()
    
    
    
    @IBOutlet weak var batterConnectedButton: UIButton! // 포구 후 송구 동작 버튼
//
    var completeDelegate : BatterPopoverComplete?
    var pitcherCompleteDelegate : PitcherPopoverComplete?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //홈런
    @IBAction func clickHomeRun(_ sender: Any) {
        //타격 기록
        self.hRecord.hittingRecord = RecordState.HomeRun
        
        //홈-1루간, 1-2루간, 2-3루간 정보 필요
        self.hRecord.homeRecord = RecordState.OneHit
        self.hRecord.homeRecordImage = RecordState.OneHit.rawValue
        self.hRecord.oneRecord = RecordState.TwoHit
        self.hRecord.oneRecordImage = RecordState.TwoHit.rawValue
        self.hRecord.twoRecord = RecordState.ThreeHit
        self.hRecord.twoRecordImage = RecordState.ThreeHit.rawValue
        self.hRecord.threeRecord = RecordState.HomeRun
        self.hRecord.threeRecordImage = RecordState.HomeRun.rawValue
        self.hRecord.centerRecord = RecordState.HomeRun
        self.hRecord.centerRecordImage = RecordState.EarnedRun.rawValue
        
        self.complete()
    }
    
    //1루타
    @IBAction func clickOneHit(_ sender: Any) {
        //타격 기록
        self.hRecord.hittingRecord = RecordState.OneHit
        
        //홈 - 1루간 정보만 필요
        self.hRecord.homeRecord = RecordState.OneHit
        self.hRecord.homeRecordImage = RecordState.OneHit.rawValue
        self.complete()
        

    }
   
    //2루타
    @IBAction func clickTwoHit(_ sender: Any) {
        //타격 기록
        self.hRecord.hittingRecord = RecordState.TwoHit
        
        //홈-1루간, 1-2루간 정보 필요
        self.hRecord.homeRecord = RecordState.OneHit
        self.hRecord.homeRecordImage = RecordState.OneHit.rawValue
        self.hRecord.oneRecord = RecordState.TwoHit
        self.hRecord.oneRecordImage = RecordState.TwoHit.rawValue
        
        self.complete()
        
    }
    
    //3루타
    @IBAction func clickThreeHit(_ sender: Any) {
        //타격 기록
        self.hRecord.hittingRecord = RecordState.ThreeHit
        
        //홈-1루간, 1-2루간, 2-3루간 정보 필요
        self.hRecord.homeRecord = RecordState.OneHit
        self.hRecord.homeRecordImage = RecordState.OneHit.rawValue
        self.hRecord.oneRecord = RecordState.TwoHit
        self.hRecord.oneRecordImage = RecordState.TwoHit.rawValue
        self.hRecord.twoRecord = RecordState.ThreeHit
        self.hRecord.twoRecordImage = RecordState.ThreeHit.rawValue
        
        self.complete()
    }
    
    //번트
    @IBAction func clickInfieldBunt(_ sender: Any) {
        //타격 기록
        self.hRecord.hittingRecord = RecordState.InfieldBunt
        
        //홈 - 1루간 정보만 필요
        self.hRecord.homeRecord = RecordState.InfieldBunt
        self.hRecord.homeRecordImage = RecordState.InfieldBunt.rawValue
        
        self.hRecord.pitcherRecord.append(RecordState.InfieldBunt)
        self.hRecord.pitcherRecordImage.append(RecordState.InfieldBunt.rawValue)
        self.complete()
    }
    
    //플라이
    @IBAction func clickFlyOut(_ sender: Any) { 
        //타격 기록
        self.hRecord.hittingRecord = RecordState.FlyOut
        //홈 - 1루간 정보만 필요
        self.hRecord.homeRecord = RecordState.FlyOut
        self.hRecord.homeRecordImage = RecordState.FlyOut.rawValue
        self.outCount()
        
        
        self.pitcherScoreBoardInfo.outCount += 1
        self.complete()
    }
    
    //파울 플라이
    @IBAction func clickFoulFlyOut(_ sender: Any) {
        //타격 기록
        self.hRecord.hittingRecord = RecordState.FoulFlyOut
        self.hRecord.homeRecord = RecordState.FoulFlyOut
        self.hRecord.homeRecordImage = RecordState.FoulFlyOut.rawValue
        self.outCount()
        self.pitcherScoreBoardInfo.outCount += 1
        self.complete()
    }
    
    //라인 드라이브
    @IBAction func clickLineDrive(_ sender: Any) {
        self.hRecord.hittingRecord = RecordState.LineDrive
        self.hRecord.homeRecord = RecordState.LineDrive
        self.hRecord.homeRecordImage = RecordState.LineDrive.rawValue
        self.outCount()
        self.pitcherScoreBoardInfo.outCount += 1
        self.complete()
    }
    
    //베이스 터치(X)
    @IBAction func clickBaseTouch(_ sender: Any) {
//        self.hRecord.homeRecord = RecordState.LineDrive
//        self.hRecord.homeRecordImage = RecordState.LineDrive.rawValue
//        self.complete()
    }
    
    @IBAction func clickExit(_ sender: Any) {
//        self.complete()
    }
    
    func complete() {
        if((self.completeDelegate) != nil)
        {
            print(pitcherScoreBoardInfo.outCount)
            completeDelegate?.BatterCompletedPopover()
            
            //
//            self.dismiss(animated: true, completion: nil)
//            self.parent?.dismiss(animated: true, completion: nil)
            
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    

    func outCount(){
        switch pitcherScoreBoardInfo.outCount {
        case 0:
            self.hRecord.centerRecord = RecordState.OutCountOne
            self.hRecord.centerRecordImage = RecordState.OutCountOne.rawValue
        case 1:
            self.hRecord.centerRecord = RecordState.OutCountTwo
            self.hRecord.centerRecordImage = RecordState.OutCountTwo.rawValue
        case 2:
            self.hRecord.centerRecord = RecordState.OutCountThree
            self.hRecord.centerRecordImage = RecordState.OutCountThree.rawValue
        default: break
            
        }
    }
}
