//
//  BaseRunnerComplete.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 3. 31..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import Foundation

protocol BaseRunnerComplete {
    func BaseRunnerCompletePopover(runnerPosition : RunnerPosition, record : HRecordInfo, addActionRunnerState : AddActionRunnerState, recordState : RecordState)
}
