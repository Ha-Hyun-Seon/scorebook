//
//  PaperRecording.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 3. 14..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation
import UIKit

class PaperRecording {
 
    //선수 정보
    var currentLineup : Lineup = Lineup()
    //현재 타격 기록지
    var currentHrecord : HRecordInfo = HRecordInfo()
    //이닝 정보
    var currentInningInfo : InningInfo = InningInfo()
    
    
    //주루별 Image View 정의
    var ivBatterRecord1 : UIImageView = UIImageView()
    var ivBatterRecord2 : UIImageView = UIImageView()
    var ivBatterRecord3 : UIImageView = UIImageView()
    var ivBatterRecord4 : UIImageView = UIImageView()
    var ivBatterRecord5 : UIImageView = UIImageView()
    
    //주루별 Label 정의
    var lblBatterRecord1 : UILabel = UILabel()
    var lblBatterRecord2 : UILabel = UILabel()
    var lblBatterRecord3 : UILabel = UILabel()
    var lblBatterRecord4 : UILabel = UILabel()
    
    //추가 메시지 Label 정의
    var lblPositionMessage : UILabel = UILabel()
    
    //선택 주자 포지션
    var runnerPosition : RunnerPosition = RunnerPosition.Default
    
    init(currentInningInfo : InningInfo, currentLineup : Lineup, currentHrecord : HRecordInfo, ivBatterRecord1 : UIImageView, ivBatterRecord2 : UIImageView, ivBatterRecord3 : UIImageView, ivBatterRecord4 : UIImageView, ivBatterRecord5 : UIImageView, lblBatterRecord1 : UILabel, lblBatterRecord2 : UILabel, lblBatterRecord3 : UILabel, lblBatterRecord4 : UILabel, lblPositionMessage : UILabel) {
        
        self.currentInningInfo = currentInningInfo
        self.currentLineup = currentLineup
        self.currentHrecord = currentHrecord
        self.ivBatterRecord1 = ivBatterRecord1
        self.ivBatterRecord2 = ivBatterRecord2
        self.ivBatterRecord3 = ivBatterRecord3
        self.ivBatterRecord4 = ivBatterRecord4
        self.ivBatterRecord5 = ivBatterRecord5
       
        self.lblBatterRecord1 = lblBatterRecord1
        self.lblBatterRecord2 = lblBatterRecord2
        self.lblBatterRecord3 = lblBatterRecord3
        self.lblBatterRecord4 = lblBatterRecord4
        self.lblPositionMessage = lblPositionMessage
    }

    
    func setHittingDefine() {
        
        switch self.currentHrecord.hittingRecord {
            
           //----------------------------
        case RecordState.FlyOut://플라이아웃
            
            self.setHittingImage(imageName: self.currentHrecord.homeRecordImage, imageControl: self.ivBatterRecord1, labelText: self.currentHrecord.homeRecordText, labelControl: self.lblBatterRecord1)
            
           // self.currentHrecord.runnerLocation = "1루" //넣는것 아님 주루에 갈경우
            
            
            
            
            
            
        case RecordState.HitByPitch://사구
            
            self.setHittingImage(imageName: self.currentHrecord.homeRecordImage, imageControl: self.ivBatterRecord1, labelText: self.currentHrecord.homeRecordText, labelControl: self.lblBatterRecord1)
            
            self.currentHrecord.runnerLocation = "1루"
            
           //----------------------------
            
            
            
            
            
            
            
            
        case RecordState.FourBall://4구
            
            self.setHittingImage(imageName: self.currentHrecord.homeRecordImage, imageControl: self.ivBatterRecord1, labelText: self.currentHrecord.homeRecordText, labelControl: self.lblBatterRecord1)
            
            self.currentHrecord.runnerLocation = "1루"
            
            
        case RecordState.OneHit://1루타
            
            //내야 안타일 경우 이미지 교환
            if Int(self.currentHrecord.homeRecordText)! < 7 {
                self.currentHrecord.homeRecordImage = RecordState.InfieldHit.rawValue
            }
            self.setHittingImage(imageName: self.currentHrecord.homeRecordImage, imageControl: self.ivBatterRecord1, labelText: self.currentHrecord.homeRecordText, labelControl: self.lblBatterRecord1)
            
            self.currentHrecord.runnerLocation = "1루"
            
            self.currentLineup.hittingCount += 1
            
            
        case RecordState.TwoHit://2루타
            
            self.setHittingImage(imageName: self.currentHrecord.homeRecordImage, imageControl: self.ivBatterRecord1, labelText: self.currentHrecord.homeRecordText, labelControl: self.lblBatterRecord1)
            self.setHittingImage(imageName: self.currentHrecord.oneRecordImage, imageControl: self.ivBatterRecord2, labelText: self.currentHrecord.oneRecordText, labelControl: self.lblBatterRecord2)
            
            self.currentHrecord.runnerLocation = "2루"
            
            self.currentLineup.hittingCount += 1
            self.currentLineup.doubleHittingCount += 1
            
        case RecordState.ThreeHit://3루타
            
            self.setHittingImage(imageName: self.currentHrecord.homeRecordImage, imageControl: self.ivBatterRecord1, labelText: self.currentHrecord.homeRecordText, labelControl: self.lblBatterRecord1)
            self.setHittingImage(imageName: self.currentHrecord.oneRecordImage, imageControl: self.ivBatterRecord2, labelText: self.currentHrecord.oneRecordText, labelControl: self.lblBatterRecord2)
            self.setHittingImage(imageName: self.currentHrecord.twoRecordImage, imageControl: self.ivBatterRecord3, labelText: self.currentHrecord.twoRecordText, labelControl: self.lblBatterRecord3)
            
            self.currentHrecord.runnerLocation = "3루"
            
            self.currentLineup.hittingCount += 1
            self.currentLineup.thirdHittingCount += 1
            
        case RecordState.HomeRun://홈런
            
            self.setHittingImage(imageName: self.currentHrecord.homeRecordImage, imageControl: self.ivBatterRecord1, labelText: self.currentHrecord.homeRecordText, labelControl: self.lblBatterRecord1)
            self.setHittingImage(imageName: self.currentHrecord.oneRecordImage, imageControl: self.ivBatterRecord2, labelText: self.currentHrecord.oneRecordText, labelControl: self.lblBatterRecord2)
            self.setHittingImage(imageName: self.currentHrecord.twoRecordImage, imageControl: self.ivBatterRecord3, labelText: self.currentHrecord.twoRecordText, labelControl: self.lblBatterRecord3)
            self.setHittingImage(imageName: self.currentHrecord.threeRecordImage, imageControl: self.ivBatterRecord4, labelText: self.currentHrecord.threeRecordText, labelControl: self.lblBatterRecord4)
            self.setHittingImage(imageName: self.currentHrecord.centerRecordImage, imageControl: self.ivBatterRecord5, labelText: self.currentHrecord.centerRecordText, labelControl: UILabel())
            
        default:
            return
        }
        
        self.currentLineup.timeAtBat += 1
        
    }
    
    func setRunnerRecordingDefine() {
        
        switch self.runnerPosition {
            
        case RunnerPosition.OneRunner:
            
            self.setHittingImage(imageName: self.currentHrecord.oneRecordImage, imageControl: self.ivBatterRecord2, labelText: self.currentHrecord.oneRecordText, labelControl: self.lblBatterRecord2)
            
        case RunnerPosition.TwoRunner:
            
            self.setHittingImage(imageName: self.currentHrecord.twoRecordImage, imageControl: self.ivBatterRecord3, labelText: self.currentHrecord.twoRecordText, labelControl: self.lblBatterRecord3)
            
            
        case RunnerPosition.ThreeRunner:
            
            self.setHittingImage(imageName: self.currentHrecord.threeRecordImage, imageControl: self.ivBatterRecord4, labelText: self.currentHrecord.threeRecordText, labelControl: self.lblBatterRecord4)
            
            
        default:
            return
        }
        
        self.currentLineup.timeAtBat += 1
        
    }
    
    func setHittingImage(imageName : String, imageControl : AnyObject, labelText : String, labelControl : AnyObject) {
        
        let image: UIImage = UIImage(named: imageName)!
        (imageControl as! UIImageView).image = image
        self.lblPositionMessage.isHidden = true
        (labelControl as! UILabel).text = labelText
        
//        self.runnerAnimation(recordState: self.currentHrecord.hittingRecord)
        
    }
}
