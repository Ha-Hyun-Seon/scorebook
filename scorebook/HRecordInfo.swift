//
//  HRecordInfo.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 12..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

class HRecordInfo : NSObject, NSCoding {
    
    //순번
    var number:String = ""
    
    //선수 등번호
    var memberNumber:String = ""
    
    //선수 이름
    var name:String = ""
    
    //타석 기록 정보
    var hittingRecord : RecordState = RecordState.Default
    
    //홈-1루 사이 기록
    var homeRecord : RecordState = RecordState.Default
    
    //홈-1루 사이 기록 이미지
    var homeRecordImage : String = ""
    
    //홈-1루 사이 기록 라벨
    var homeRecordText : String = ""
    
    //1-2루 사이 기록
    var oneRecord : RecordState = RecordState.Default
    
    //1-2루 사이 기록 이미지
    var oneRecordImage : String = ""
    
    //1-2루 사이 기록 라벨
    var oneRecordText : String = ""
    
    //2-3루 사이 기록
    var twoRecord : RecordState = RecordState.Default
    
    //2-3루 사이 기록 이미지
    var twoRecordImage : String = ""
    
    //2-3루 사이 기록 라벨
    var twoRecordText : String = ""
    
    //3-홈 사이 기록
    var threeRecord : RecordState = RecordState.Default
    
    //3-홈 사이 기록 이미지
    var threeRecordImage : String = ""
    
    //3-홈 사이 기록 라벨
    var threeRecordText : String = ""
    
    //기록지 상의 중간 공간 기록(아웃, 타점 등)
    var centerRecord : RecordState = RecordState.Default
    
    //기록지 상의 중간 공간 기록(아웃, 타점 등) 이미지
    var centerRecordImage:String = ""
    
    //기록지 상의 중간 공간 기록 라벨
    var centerRecordText : String = ""
    
    //타자위치
    var runnerLocation : String = ""
    
    //투수 기록(기록지 상의 왼쪽 세로 줄)
    var pitcherRecord:[RecordState] = [RecordState]()
    
    var pitcherRecord1:[String] = [String]()
    
    //투수 기록(기록지 상의 왼쪽 세로 줄) 이미지
    var pitcherRecordImage:[String] = [String]()
    
    //투구수
    var pitcherCount:[String:Int] = [String:Int]()
    
    override init() {
    }
    
    func encode(with encoder: NSCoder){
        encoder.encode(self.number, forKey: "number")
        encoder.encode(self.memberNumber, forKey: "memberNumber")
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.hittingRecord.rawValue, forKey: "hittingRecord")
        encoder.encode(self.homeRecord.rawValue, forKey: "homeRecord")
        encoder.encode(self.homeRecordImage, forKey: "homeRecordImage")
        encoder.encode(self.homeRecordText, forKey: "homeRecordText")
        encoder.encode(self.oneRecord.rawValue, forKey: "oneRecord")
        encoder.encode(self.oneRecordImage, forKey: "oneRecordImage")
        encoder.encode(self.oneRecordText, forKey: "oneRecordText")
        encoder.encode(self.twoRecord.rawValue, forKey: "twoRecord")
        encoder.encode(self.twoRecordImage, forKey: "twoRecordImage")
        encoder.encode(self.twoRecordText, forKey: "twoRecordText")
        encoder.encode(self.threeRecord.rawValue, forKey: "threeRecord")
        encoder.encode(self.threeRecordImage, forKey: "threeRecordImage")
        encoder.encode(self.threeRecordText, forKey: "threeRecordText")
        encoder.encode(self.centerRecord.rawValue, forKey: "centerRecord")
        encoder.encode(self.centerRecordImage, forKey: "centerRecordImage")
        encoder.encode(self.centerRecordText, forKey: "centerRecordText")
        encoder.encode(self.runnerLocation, forKey: "runnerLocation")
//        encoder.encode(self.pitcherRecord, forKey: "pitcherRecord")
        encoder.encode(self.pitcherRecord1, forKey: "pitcherRecord1")
        encoder.encode(self.pitcherRecordImage, forKey: "pitcherRecordImage")
        encoder.encode(self.pitcherCount, forKey: "pitcherCount")
        
        
        let pitcherRecord = self.pitcherRecord.map { $0.rawValue }
        encoder.encode(pitcherRecord, forKey: "pitcherRecord")

    }
    
    required init(coder decoder: NSCoder) {
        
        if let number = decoder.decodeObject(forKey: "number") as? String{
            self.number = number
        }
        
        if let memberNumber = decoder.decodeObject(forKey: "memberNumber") as? String{
            self.memberNumber = memberNumber
        }
        
        if let name = decoder.decodeObject(forKey: "name") as? String{
            self.name = name
        }
        
        self.hittingRecord = RecordState(rawValue: (decoder.decodeObject(forKey: "hittingRecord") as! String)) ?? .Default
        
        self.homeRecord = RecordState(rawValue: (decoder.decodeObject(forKey: "homeRecord") as! String)) ?? .Default
        
        
        if let homeRecordImage = decoder.decodeObject(forKey: "homeRecordImage") as? String{
            self.homeRecordImage = homeRecordImage
        }
        
        if let homeRecordText = decoder.decodeObject(forKey: "homeRecordText") as? String{
            self.homeRecordText = homeRecordText
        }
        
        self.oneRecord = RecordState(rawValue: (decoder.decodeObject(forKey: "oneRecord") as! String)) ?? .Default
        
        
        if let oneRecordImage = decoder.decodeObject(forKey: "oneRecordImage") as? String{
            self.oneRecordImage = oneRecordImage
        }
        
        if let oneRecordText = decoder.decodeObject(forKey: "oneRecordText") as? String{
            self.oneRecordText = oneRecordText
        }
        
        self.twoRecord = RecordState(rawValue: (decoder.decodeObject(forKey: "twoRecord") as! String)) ?? .Default
        
        if let twoRecordImage = decoder.decodeObject(forKey: "twoRecordImage") as? String{
            self.twoRecordImage = twoRecordImage
        }
        
        if let twoRecordText = decoder.decodeObject(forKey: "twoRecordText") as? String{
            self.twoRecordText = twoRecordText
        }
        
        self.threeRecord = RecordState(rawValue: (decoder.decodeObject(forKey: "threeRecord") as! String)) ?? .Default
        
        if let threeRecordImage = decoder.decodeObject(forKey: "threeRecordImage") as? String{
            self.threeRecordImage = threeRecordImage
        }
        
        if let threeRecordText = decoder.decodeObject(forKey: "threeRecordText") as? String{
            self.threeRecordText = threeRecordText
        }
        
        self.centerRecord = RecordState(rawValue: (decoder.decodeObject(forKey: "centerRecord") as! String)) ?? .Default
        
        if let centerRecordImage = decoder.decodeObject(forKey: "centerRecordImage") as? String{
            self.centerRecordImage = centerRecordImage
        }
        
        if let centerRecordText = decoder.decodeObject(forKey: "centerRecordText") as? String{
            self.centerRecordText = centerRecordText
        }
        
        if let runnerLocation = decoder.decodeObject(forKey: "runnerLocation") as? String{
            self.runnerLocation = runnerLocation
        }
        
        if let pitcherRecord = decoder.decodeObject(forKey: "pitcherRecord") as? [String] {
            self.pitcherRecord = pitcherRecord.map { RecordState(rawValue: $0) ?? .Default }
        }
        
        if let pitcherRecord1 = decoder.decodeObject(forKey: "pitcherRecord1") as? [String]{
            self.pitcherRecord1 = pitcherRecord1
        }
        
        if let pitcherRecordImage = decoder.decodeObject(forKey: "pitcherRecordImage") as? [String]{
            self.pitcherRecordImage = pitcherRecordImage
        }
        
        if let pitcherCount = decoder.decodeObject(forKey: "pitcherCount") as? [String:Int]{
            self.pitcherCount = pitcherCount
        }
        
    }
}

