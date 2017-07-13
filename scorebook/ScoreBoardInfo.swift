//
//  ScoreBoardInfo.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 12..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

class ScoreBoardInfo : NSObject, NSCoding {
    
    //전체 안타수
    var tHCount:Int = 0
    
    //전체 볼넷수
    var tBCount:Int = 0
    
    //전체 에러수
    var tECount:Int = 0
    
    //전체 삼진수
    var tSCount:Int = 0
    
    //전체 점수
    var tRCount:Int = 0
    
    override init() {
    }
    
    func encode(with encoder: NSCoder){
        encoder.encode(self.tHCount, forKey: "tHCount")
        encoder.encode(self.tBCount, forKey: "tBCount")
        encoder.encode(self.tECount, forKey: "tECount")
        encoder.encode(self.tSCount, forKey: "tSCount")
        encoder.encode(self.tRCount, forKey: "tRCount")
    }
    
    required init(coder decoder: NSCoder) {
        
        if let tHCount = decoder.decodeObject(forKey: "tHCount") as? Int{
            self.tHCount = tHCount
        }
        
        if let tBCount = decoder.decodeObject(forKey: "tBCount") as? Int{
            self.tBCount = tBCount
        }
        
        if let tECount = decoder.decodeObject(forKey: "tECount") as? Int{
            self.tECount = tECount
        }
        
        if let tSCount = decoder.decodeObject(forKey: "tSCount") as? Int{
            self.tSCount = tSCount
        }
        
        if let tRCount = decoder.decodeObject(forKey: "tRCount") as? Int{
            self.tRCount = tRCount
        }
    }
}
