//
//  StolenBasesMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit



class StolenBasesMenuViewController: UIViewController {
    
    var recordState : RecordState = RecordState.Default
    var hRecord : HRecordInfo = HRecordInfo()
    var runnerPosition : RunnerPosition = RunnerPosition.Default
    
    @IBAction func clickStealSuccess(_ sender: UIButton) {
        self.recordState = RecordState.StealImage
//        switch runnerPosition {
//        case OneRunner:
//            <#code#>
//        case OneRunner:
//            <#code#>
//        case OneRunner:
//            <#code#>
//        default:
//            <#code#>
//        }
        self.hRecord.oneRecord = RecordState.StealImage
        self.hRecord.oneRecordImage = RecordState.StealImage.rawValue
        Complite()
    }
    @IBAction func clickStealFail(_ sender: UIButton) {
        self.recordState = RecordState.StealError
        Complite()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func Complite(){
        
    }
}
