//
//  PRecordInfo.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 12..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

class PRecordInfo : NSObject, NSCoding {
    
    //선수 등번호
    var memberNumber:String = ""
    
    //선수 이름
    var name:String = ""
    
    //총 투구수
    var pCount:String = ""
    
    //볼넷수
    var bCount:String = ""
    
    //피안타수
    var hCount:String = ""
    
    //피홈런수
    var hhCount:String = ""
    
    //실점
    var rCount:String = ""
    
    //자책점
    var rrCount:String = ""
    
    //총 투구 이닝
    //(3 1/3) - 4회 원아웃까지 잡고 교체된 경우
    var totalInning:String = ""
    
    override init() {
    }
    
    func encode(with encoder: NSCoder){
        encoder.encode(self.memberNumber, forKey: "memberNumber")
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.pCount, forKey: "pCount")
        encoder.encode(self.bCount, forKey: "bCount")
        encoder.encode(self.hCount, forKey: "hCount")
        encoder.encode(self.hhCount, forKey: "hhCount")
        encoder.encode(self.rCount, forKey: "rCount")
        encoder.encode(self.rrCount, forKey: "rrCount")
        encoder.encode(self.totalInning, forKey: "totalInning")
    }
    
    required init(coder decoder: NSCoder) {
        
        if let memberNumber = decoder.decodeObject(forKey: "memberNumber") as? String{
            self.memberNumber = memberNumber
        }
        
        if let name = decoder.decodeObject(forKey: "name") as? String{
            self.name = name
        }
        
        if let pCount = decoder.decodeObject(forKey: "pCount") as? String{
            self.hCount = pCount
        }
        
        if let bCount = decoder.decodeObject(forKey: "bCount") as? String{
            self.rCount = bCount
        }
        
        if let hCount = decoder.decodeObject(forKey: "hCount") as? String{
            self.bCount = hCount
        }
        
        if let hhCount = decoder.decodeObject(forKey: "hhCount") as? String{
            self.hhCount = hhCount
        }
        
        if let rCount = decoder.decodeObject(forKey: "rCount") as? String{
            self.rCount = rCount
        }
        
        if let rrCount = decoder.decodeObject(forKey: "rrCount") as? String{
            self.rrCount = rrCount
        }
        
        if let totalInning = decoder.decodeObject(forKey: "totalInning") as? String{
            self.totalInning = totalInning
        }
     
    }
}
