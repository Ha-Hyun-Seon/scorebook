//
//  InningInfo.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 12..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

class InningInfo : NSObject, NSCoding {
    
    //이닝 번호(1-15회)
    var number:Int = 1
    
    //이닝 구분(초-Top, 말-Bottom)
    var kind:String = ""
    
    //안타수
    var hCount:Int = 0
    
    //점수
    var rCount:Int = 0
    
    //볼넷수
    var bCount:Int = 0
    
    //에러수
    var eCount:Int = 0
    
    //삼진수
    var sCount:Int = 0
    
    //타석 기록지 Class
    var hRecord:[HRecordInfo] = [HRecordInfo]()
    
    //투수 기록지 Class
    var pRecord:[PRecordInfo] = [PRecordInfo]()
    
    //교대 수비 선수 등번호(마지막 아웃 수비한 선수 등번호)
    var changeDefenceNumber:String = ""
    
    //교대 수비 선수 이름(마지막 아웃 수비한 선수 이름)
    var changeDefenceName:String = ""
    
    //수비 보살수
    var assistCount:Int = 0
    
    override init() {
    }
    
    func encode(with encoder: NSCoder){
        encoder.encode(self.number, forKey: "number")
        encoder.encode(self.kind, forKey: "kind")
        encoder.encode(self.hCount, forKey: "hCount")
        encoder.encode(self.rCount, forKey: "rCount")
        encoder.encode(self.bCount, forKey: "bCount")
        encoder.encode(self.eCount, forKey: "eCount")
        encoder.encode(self.sCount, forKey: "sCount")
        encoder.encode(self.hRecord, forKey: "hRecord")
        encoder.encode(self.pRecord, forKey: "pRecord")
        encoder.encode(self.changeDefenceNumber, forKey: "changeDefenceNumber")
        encoder.encode(self.changeDefenceName, forKey: "changeDefenceName")
        encoder.encode(self.assistCount, forKey: "assistCount")
    }
    
    required init(coder decoder: NSCoder) {
        
        if let number = decoder.decodeObject(forKey: "number") as? Int{
            self.number = number
        }
        
        if let kind = decoder.decodeObject(forKey: "kind") as? String{
            self.kind = kind
        }
        
        if let hCount = decoder.decodeObject(forKey: "hCount") as? Int{
            self.hCount = hCount
        }
        
        if let rCount = decoder.decodeObject(forKey: "rCount") as? Int{
            self.rCount = rCount
        }
        
        if let bCount = decoder.decodeObject(forKey: "bCount") as? Int{
            self.bCount = bCount
        }
        
        if let eCount = decoder.decodeObject(forKey: "eCount") as? Int{
            self.eCount = eCount
        }
        
        if let sCount = decoder.decodeObject(forKey: "sCount") as? Int{
            self.sCount = sCount
        }
        
        if let hRecord = decoder.decodeObject(forKey: "hRecord") as? [HRecordInfo]{
            self.hRecord = hRecord
        }
        
        if let pRecord = decoder.decodeObject(forKey: "pRecord") as? [PRecordInfo]{
            self.pRecord = pRecord
        }
        
        if let changeDefenceNumber = decoder.decodeObject(forKey: "changeDefenceNumber") as? String{
            self.changeDefenceNumber = changeDefenceNumber
        }
        
        if let changeDefenceName = decoder.decodeObject(forKey: "changeDefenceName") as? String{
            self.changeDefenceName = changeDefenceName
        }
        
        if let assistCount = decoder.decodeObject(forKey: "assistCount") as? Int{
            self.assistCount = assistCount
        }
    }

}
