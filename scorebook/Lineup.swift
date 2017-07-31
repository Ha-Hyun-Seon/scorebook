//
//  Lineup.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 12..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

class Lineup : NSObject, NSCoding {

    //순번(타석순번임, 교체 순번: 순번 + 순번으로 작성)
    //1번타순 교체 시 - 11
    //2번타순 교체 시 - 21
    //2번타순 재 교체 시 - 22
    var number:String = ""
    
    //선수명
    var name:String = ""
    
    //선수 구분(타자, 투수)
    var kind:String = ""
    
    //선수 등번호
    var memberNumber:String = ""
    
    //포지션 번호(투수-1, 포수-2, 1루수-3 ...)
    var positionNumber:String = ""
    
    //포지션명(투수-1, 포수-2, 1루수-3 ...)
    var positionName:String = ""
    
    //포지션(개괄적인 포지션 : 투수, 포수, 내야, 외야)
    var positionTemp:String = ""
    
    //타자일 전체 경우 기록
    //타석
    //:자기 차례가 몇번인지 (무조건 +1)
    var plateAppearance : Int = 0
    
    //타수
    //: 번트, 고의사구, 사구, 볼넷을 뺀 타석 (자기가 희생해서 이득을 취할때와 자기의 의도와 상관없이 점수가 날때)
    var timeAtBat : Int = 0
    
    //안타
    var hittingCount : Int = 0
    
    //2루타
    var doubleHittingCount : Int = 0
    
    //3루타
    var thirdHittingCount : Int = 0
    
    //홈런
    var homerunCount : Int = 0
    
    //득점
    var getScoreCount : Int = 0
    
    
    //var 00Count : Int = 0
    //루타수
    //:HRecordInfo의 HittingRecord정보 1루- 1, 2루-2, 3루-3, 홈런-4
    var totalBase : Int = 0
    
    //타점(득점타)
    //:자기가 쳐서 홈에 들어온 사람수
    var runBattedIn : Int = 0
    
    //도루
    //:자기가 도루 성공한 경우, 스틸에 의한 진루한 경우
    var stolenBases : Int = 0
    
    //도루자
    //:?
    //희타
    //:?
    //희비
    //:?
    
    //4구(볼넷)
    //:자기가 볼넷으로 진루 되었을때
    var baseOnBalls : Int = 0
    
    //고의4구
    //:자기가 고의4구 눌렸을때
    var intentionalBaseOnBalls : Int = 0
    
    //사구
    //:자기가 사구 눌렸을때
    var hitByPitch : Int = 0
    
    //삼진
    //:스트라이크 세번
    var strikeOut : Int = 0
    
    //병살타
    //:한번쳤을때 Done누르기전에 아웃카운트가 두번일때 병살 : 현재 타자의 기록
    var doublePlay : Int = 0
    
    
    //잔루
    //:3아웃될때 베이스에 있는 주자 기록에 +1
    var leftOnBase : Int = 0
    
    
    //투수일 경우 전체 기록
    //총 투구수
    var pitcherTotalCount : Int = 0
    
    //맞은 안타수
    var pitcherHittingCount : Int = 0
    
    //볼넷 내준 수
    var pitcherBaseOnBallsCount : Int = 0
    
    //타석
    //:
    //타수
    //피안타
    //피홈런
    //희타
    //희비
    //4구
    //고의4구
    //사구
    
    //삼진 수
    var pitcherStrikeOutCount : Int = 0
    
    //폭투
    //보크
    //실점
    //자책점
    //이닝수
    //아웃카운터
    
    //라인업 선수 설정 완료
    var isSetName:Bool = false
    
    //라인업 포지션 설정 완료
    var isSetPosition:Bool = false
    
    override init() {
    }
    
    func encode(with encoder: NSCoder){
        encoder.encode(self.number, forKey: "number")
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.kind, forKey: "kind")
        encoder.encode(self.memberNumber, forKey: "memberNumber")
        encoder.encode(self.positionNumber, forKey: "positionNumber")
        encoder.encode(self.positionName, forKey: "positionName")
        encoder.encode(self.positionTemp, forKey: "positionTemp")
        encoder.encode(self.timeAtBat, forKey: "timeAtBat")
        
        encoder.encode(self.hittingCount, forKey: "hittingCount")
        encoder.encode(self.doubleHittingCount, forKey: "doubleHittingCount")
        encoder.encode(self.thirdHittingCount, forKey: "thirdHittingCount")
        encoder.encode(self.homerunCount, forKey: "homerunCount")
        
        encoder.encode(self.pitcherTotalCount, forKey: "pitcherTotalCount")
        encoder.encode(self.pitcherHittingCount, forKey: "pitcherHittingCount")
        encoder.encode(self.pitcherBaseOnBallsCount, forKey: "pitcherBaseOnBallsCount")
        encoder.encode(self.pitcherStrikeOutCount, forKey: "pitcherStrikeOutCount")
        
        encoder.encode(self.isSetName, forKey: "isSetName")
        encoder.encode(self.isSetPosition, forKey: "isSetPosition")
    }
    
    required init(coder decoder: NSCoder) {
        
        if let number = decoder.decodeObject(forKey: "number") as? String{
            self.number = number
        }
        
        if let name = decoder.decodeObject(forKey: "name") as? String{
            self.name = name
        }
        
        if let kind = decoder.decodeObject(forKey: "kind") as? String{
            self.kind = kind
        }
        
        if let memberNumber = decoder.decodeObject(forKey: "memberNumber") as? String{
            self.memberNumber = memberNumber
        }
        
        if let positionNumber = decoder.decodeObject(forKey: "positionNumber") as? String{
            self.positionNumber = positionNumber
        }
        
        if let positionName = decoder.decodeObject(forKey: "positionName") as? String{
            self.positionName = positionName
        }
        
        if let positionTemp = decoder.decodeObject(forKey: "positionTemp") as? String{
            self.positionTemp = positionTemp
        }
        
        if let timeAtBat = decoder.decodeObject(forKey: "timeAtBat") as? Int{
            self.timeAtBat = timeAtBat
        }
        
        if let hittingCount = decoder.decodeObject(forKey: "hittingCount") as? Int{
            self.hittingCount = hittingCount
        }
        
        if let doubleHittingCount = decoder.decodeObject(forKey: "doubleHittingCount") as? Int{
            self.doubleHittingCount = doubleHittingCount
        }
        
        if let thirdHittingCount = decoder.decodeObject(forKey: "thirdHittingCount") as? Int{
            self.thirdHittingCount = thirdHittingCount
        }
        
        if let homerunCount = decoder.decodeObject(forKey: "homerunCount") as? Int{
            self.homerunCount = homerunCount
        }
        
        if let pitcherTotalCount = decoder.decodeObject(forKey: "pitcherTotalCount") as? Int{
            self.pitcherTotalCount = pitcherTotalCount
        }
        
        if let pitcherHittingCount = decoder.decodeObject(forKey: "pitcherHittingCount") as? Int{
            self.pitcherHittingCount = pitcherHittingCount
        }
        
        if let pitcherBaseOnBallsCount = decoder.decodeObject(forKey: "pitcherBaseOnBallsCount") as? Int{
            self.pitcherBaseOnBallsCount = pitcherBaseOnBallsCount
        }
        
        if let pitcherStrikeOutCount = decoder.decodeObject(forKey: "pitcherStrikeOutCount") as? Int{
            self.pitcherStrikeOutCount = pitcherStrikeOutCount
        }
        
        self.isSetName = decoder.decodeBool(forKey: "isSetName")
        
        self.isSetPosition = decoder.decodeBool(forKey: "isSetPosition")
    }

}
