//
//  PitcherScoreBoardInfo.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 3. 13..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

class PitcherScoreBoardInfo : NSObject, NSCoding {
    
    //스트라이크 수
    var strikeCount:Int = 0
    
    //볼넷 수
    var ballCount:Int = 0
    
    //아웃 수
    var outCount:Int = 0
    
    //투구 상태(삼진 아웃, 볼넷, 사구 등 타자 변경이 일어나는 경우)
    var isPitcherChanged:Bool = false
    
    override init() {
    }
    
    func encode(with encoder: NSCoder){
        encoder.encode(self.strikeCount, forKey: "strikeCount")
        encoder.encode(self.ballCount, forKey: "ballCount")
        encoder.encode(self.outCount, forKey: "outCount")
        encoder.encode(self.isPitcherChanged, forKey: "isPitcherChanged")
    }
    
    required init(coder decoder: NSCoder) {
        
        if let strikeCount = decoder.decodeObject(forKey: "strikeCount") as? Int{
            self.strikeCount = strikeCount
        }
        
        if let ballCount = decoder.decodeObject(forKey: "ballCount") as? Int{
            self.ballCount = ballCount
        }
        
        if let outCount = decoder.decodeObject(forKey: "outCount") as? Int{
            self.outCount = outCount
        }
        
        self.isPitcherChanged = decoder.decodeBool(forKey: "isPitcherChanged")
    }
}
