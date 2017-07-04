//
//  GameInfo.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 11..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

class GameInfo : NSObject, NSCoding {
    
    override init() {
    }
    
    //게임명
    var name:String = ""
    
    // 구장명
    var stadiumName:String = ""
    
    // 일기
    var weatherInfo:String = ""
    
    // 현재온도
    var temperatureInfo:String = ""
    
    // 습도
    var humidityInfo:String = ""
    
    // 풍향
    var windDirectionInfo:String = ""
    
    // 풍속
    var windSpeedInfo:String = ""
    
    //주심
    var chiefUmpire:String = ""
    
    //1루심
    var firstUmpire:String = ""
    
    //2루심
    var secondUmpire:String = ""
    
    //3루심
    var thirdUmpire:String = ""
    
    //좌선심
    var leftLineUmpire:String = ""
    
    //우선심
    var rightLineUmpire:String = ""
    
    //기록원1
    var firstRecorder:String = ""
    
    //기록원2
    var secondRecorder:String = ""
    
    //전체 게임 시간(1-9회)
    var totlaTime:String = ""
    
    //게임 시작 일시
    var startDate:String = ""
    
    //게임 시작 시간
    var startTime:String = ""
    
    //게임 종료 시간
    var endTime:String = ""
    
    //게임 제외 시간(우천등의 사유)
    var withoutTime:String = ""
    
    //연장전 시간
    var overTime:String = ""
    
    func encode(with encoder: NSCoder){
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.stadiumName, forKey: "stadiumName")
        encoder.encode(self.weatherInfo, forKey: "weatherInfo")
        encoder.encode(self.temperatureInfo, forKey: "temperatureInfo")
        encoder.encode(self.humidityInfo, forKey: "humidityInfo")
        encoder.encode(self.windDirectionInfo, forKey: "windDirectionInfo")
        encoder.encode(self.windSpeedInfo, forKey: "windSpeedInfo")
        encoder.encode(self.chiefUmpire, forKey: "chiefUmpire")
        encoder.encode(self.firstUmpire, forKey: "firstUmpire")
        encoder.encode(self.secondUmpire, forKey: "secondUmpire")
        encoder.encode(self.thirdUmpire, forKey: "thirdUmpire")
        encoder.encode(self.leftLineUmpire, forKey: "leftLineUmpire")
        encoder.encode(self.rightLineUmpire, forKey: "rightLineUmpire")
        encoder.encode(self.firstRecorder, forKey: "firstRecorder")
        encoder.encode(self.secondRecorder, forKey: "secondRecorder")
        encoder.encode(self.totlaTime, forKey: "totlaTime")
        encoder.encode(self.startDate, forKey: "startDate")
        encoder.encode(self.startTime, forKey: "startTime")
        encoder.encode(self.endTime, forKey: "endTime")
        encoder.encode(self.withoutTime, forKey: "withoutTime")
        encoder.encode(self.overTime, forKey: "overTime")
    }
    
    required init(coder decoder: NSCoder) {
        
        if let name = decoder.decodeObject(forKey: "name") as? String{
            self.name = name
        }
        
        if let stadiumName = decoder.decodeObject(forKey: "stadiumName") as? String{
            self.stadiumName = stadiumName
        }
        
        if let weatherInfo = decoder.decodeObject(forKey: "weatherInfo") as? String{
            self.weatherInfo = weatherInfo
        }
        
        if let temperatureInfo = decoder.decodeObject(forKey: "temperatureInfo") as? String{
            self.temperatureInfo = temperatureInfo
        }
        
        if let humidityInfo = decoder.decodeObject(forKey: "humidityInfo") as? String{
            self.humidityInfo = humidityInfo
        }
        
        if let windDirectionInfo = decoder.decodeObject(forKey: "windDirectionInfo") as? String{
            self.windDirectionInfo = windDirectionInfo
        }
        
        if let windSpeedInfo = decoder.decodeObject(forKey: "windSpeedInfo") as? String{
            self.windSpeedInfo = windSpeedInfo
        }
        
        if let chiefUmpire = decoder.decodeObject(forKey: "chiefUmpire") as? String{
            self.chiefUmpire = chiefUmpire
        }
        
        if let firstUmpire = decoder.decodeObject(forKey: "firstUmpire") as? String{
            self.firstUmpire = firstUmpire
        }
        
        if let secondUmpire = decoder.decodeObject(forKey: "secondUmpire") as? String{
            self.secondUmpire = secondUmpire
        }
        
        if let thirdUmpire = decoder.decodeObject(forKey: "thirdUmpire") as? String{
            self.thirdUmpire = thirdUmpire
        }
        
        if let leftLineUmpire = decoder.decodeObject(forKey: "leftLineUmpire") as? String{
            self.leftLineUmpire = leftLineUmpire
        }
        
        if let rightLineUmpire = decoder.decodeObject(forKey: "rightLineUmpire") as? String{
            self.rightLineUmpire = rightLineUmpire
        }
        
        if let firstRecorder = decoder.decodeObject(forKey: "firstRecorder") as? String{
            self.firstRecorder = firstRecorder
        }
        
        if let secondRecorder = decoder.decodeObject(forKey: "secondRecorder") as? String{
            self.secondRecorder = secondRecorder
        }
        
        if let totlaTime = decoder.decodeObject(forKey: "totlaTime") as? String{
            self.totlaTime = totlaTime
        }
        
        if let startDate = decoder.decodeObject(forKey: "startDate") as? String{
            self.startDate = startDate
        }
        
        if let startTime = decoder.decodeObject(forKey: "startTime") as? String{
            self.startTime = startTime
        }
        
        if let endTime = decoder.decodeObject(forKey: "endTime") as? String{
            self.endTime = endTime
        }
        
        if let withoutTime = decoder.decodeObject(forKey: "withoutTime") as? String{
            self.withoutTime = withoutTime
        }
        
        if let overTime = decoder.decodeObject(forKey: "overTime") as? String{
            self.overTime = overTime
        }
    }
}
