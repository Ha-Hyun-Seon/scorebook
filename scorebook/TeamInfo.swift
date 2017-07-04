//
//  TeamInfo.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 12..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

class TeamInfo : NSObject, NSCoding {

    
    override init() {
    }
    
    //팀명
    var name:String = ""
    
    //구분(홈팀:H, 원정팀:V)
    var kind:String = ""
    
    //이닝 정보
    var inningInfo:[InningInfo] = [InningInfo]()
    
    //라인업 정보(선수 정보)
    var lineupInfo:[Lineup] = [Lineup]()
    
    //라인업 정보(확정된 라인업)
    var mainLineupInfo:[Lineup] = [Lineup]()
    
    func encode(with encoder: NSCoder){
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.kind, forKey: "kind")
        encoder.encode(self.inningInfo, forKey: "inningInfo")
        encoder.encode(self.lineupInfo, forKey: "lineupInfo")
        encoder.encode(self.mainLineupInfo, forKey: "mainLineupInfo")
    }
    
    required init(coder decoder: NSCoder) {
        
        if let name = decoder.decodeObject(forKey: "name") as? String{
            self.name = name
        }
        
        if let kind = decoder.decodeObject(forKey: "kind") as? String{
            self.kind = kind
        }
        
        if let inningInfo = decoder.decodeObject(forKey: "inningInfo") as? [InningInfo]{
            self.inningInfo = inningInfo
        }
        
        if let lineupInfo = decoder.decodeObject(forKey: "lineupInfo") as? [Lineup]{
            self.lineupInfo = lineupInfo
        }
        
        if let mainLineupInfo = decoder.decodeObject(forKey: "mainLineupInfo") as? [Lineup]{
            self.mainLineupInfo = mainLineupInfo
        }
    }
    
}
