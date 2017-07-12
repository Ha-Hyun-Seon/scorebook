//
//  RunnerAnimationComplete.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 28..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit

protocol RunnerAnimationComplete {
    func AnimationComplete(oneRunnerHRecord : HRecordInfo, twoRunnerHRecord : HRecordInfo, threeRunnerHRecord : HRecordInfo, homeRunnerHRecordList : [HRecordInfo], runnerState : RunnerState, addActionState : AddActionState)
    
    func AddActionAnimationComplete(oneRunnerHRecord : HRecordInfo, twoRunnerHRecord : HRecordInfo, threeRunnerHRecord : HRecordInfo, homeRunnerHRecordList : [HRecordInfo], tempRunnerHRecord : HRecordInfo, runnerState : RunnerState, addActionState : AddActionState, runnerPosition: RunnerPosition)
}
