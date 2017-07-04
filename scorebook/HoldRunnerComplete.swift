//
//  HoldRunnerComplete.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 4. 8..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

protocol HoldRunnerComplete {
    func HoldRunnerCompletePopover(runnerPosition : RunnerPosition, record : HRecordInfo, addActionRunnerState : AddActionRunnerState, recordState : RecordState)
}
