//
//  PlayerNumberInfo.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 3. 31..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

//루 상태
enum RunnerState : String {
    case Default = ""
    case RunnerState1 = "1"
    case RunnerState2 = "1,2"
    case RunnerState3 = "1,2,3"
    case RunnerState4 = "1,3"
    case RunnerState5 = "2"
    case RunnerState6 = "2,3"
    case RunnerState7 = "3"
}

//루 상태
enum AddActionRunnerState : String {
    case Default = ""
    case BatterAction = "타자에의한"
    case ErrorAction = "실책에의한"
}

//추가 입력 상태
enum AddActionState : String {
    case Default = ""
    case oneAction = "한명"
    case TwoAction = "두명"
    case ThreeAction = "세명"
}

//팝업 상태
enum ActionPopState : String {
    case Default = "메인메뉴"
    case HoldRunner = "루도착주자"
    case HalfRunner = "중간주자"
}

//기록지 작성 주체
enum RecordingByThing : String {
    case Default = ""
    case Pitcher = "투수에의해"
    case Batter = "타자에의해"
}

extension Array {
    subscript (safe index: Int) -> Element? {
        // iOS 9 or later
        return indices ~= index ? self[index] : nil
        // iOS 8 or earlier
        // return startIndex <= index && index < endIndex ? self[index] : nil
        // return 0 <= index && index < self.count ? self[index] : nil
    }
}


class Utils {
    
    var currentHRecord : HRecordInfo = HRecordInfo()
    
    init(currentHRecord : HRecordInfo){
        self.currentHRecord = currentHRecord
    }
    
    //루 상태
    enum RunnerState : String {
        case Default = ""
        case RunnerState1 = "1"
        case RunnerState2 = "1,2"
        case RunnerState3 = "1,2,3"
        case RunnerState4 = "1,3"
        case RunnerState5 = "2"
        case RunnerState6 = "2,3"
        case RunnerState7 = "3"
    }
    
    func getRecordStateImageStringByBatterNumber() -> String {
        var imageString : String = ""
        switch self.currentHRecord.number.replacingOccurrences(of: "번타자", with: "") {
        case "1":
            imageString = RecordState.NumberOne.rawValue
        case "11":
            imageString = RecordState.NumberOne.rawValue
        case "21":
            imageString = RecordState.NumberOne.rawValue
            
        case "2":
            imageString = RecordState.NumberTwo.rawValue
        case "12":
            imageString = RecordState.NumberTwo.rawValue
        case "22":
            imageString = RecordState.NumberTwo.rawValue
            
        case "3":
            imageString = RecordState.NumberThree.rawValue
        case "13":
            imageString = RecordState.NumberThree.rawValue
        case "23":
            imageString = RecordState.NumberThree.rawValue
            
        case "4":
            imageString = RecordState.NumberFour.rawValue
        case "14":
            imageString = RecordState.NumberFour.rawValue
        case "24":
            imageString = RecordState.NumberFour.rawValue
            
        case "5":
            imageString = RecordState.NumberFive.rawValue
        case "15":
            imageString = RecordState.NumberFive.rawValue
        case "25":
            imageString = RecordState.NumberFive.rawValue
            
        case "6":
            imageString = RecordState.NumberSix.rawValue
        case "16":
            imageString = RecordState.NumberSix.rawValue
        case "26":
            imageString = RecordState.NumberSix.rawValue
            
        case "7":
            imageString = RecordState.NumberSeven.rawValue
        case "17":
            imageString = RecordState.NumberSeven.rawValue
        case "27":
            imageString = RecordState.NumberSeven.rawValue
            
        case "8":
            imageString = RecordState.NumberEight.rawValue
        case "18":
            imageString = RecordState.NumberEight.rawValue
        case "28":
            imageString = RecordState.NumberEight.rawValue
            
        case "9":
            imageString = RecordState.NumberNine.rawValue
        case "19":
            imageString = RecordState.NumberNine.rawValue
        case "29":
            imageString = RecordState.NumberNine.rawValue
        default:
            imageString = ""
        }
        
        return imageString
    }
}