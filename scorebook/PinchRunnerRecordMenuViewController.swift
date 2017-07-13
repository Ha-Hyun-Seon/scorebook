//
//  PinchRunnerRecordMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//  대기주자기록 : 단독주자-대기주자메뉴

import UIKit



class PinchRunnerRecordMenuViewController: UIViewController {
    
    @IBOutlet weak var wildPitchButton: UIButton!   // 폭투에 의한
    @IBOutlet weak var passedBallButton: UIButton!  // 포일에 의한
    @IBOutlet weak var defenseErrorCausedByAdvanceButton: UIButton! // 실책에 의한
    @IBOutlet weak var batterByAdvanceButton: UIButton! // 타자에 의한
    @IBOutlet weak var stealByAdvanceButton: UIButton!  // 스틸에 의한
    @IBOutlet weak var checkAdvanceButton: UIButton!    // 견제에 의한
    @IBOutlet weak var runnerAdvanceButton: UIButton!   // 주자에 의한
    @IBOutlet weak var tagOutButton: UIButton!  // 태그 아웃
    @IBOutlet weak var waitStateStealErrorButton: UIButton! // 도루 실패
    @IBOutlet weak var separateNotAdvanceButton: UIButton!  // 진루 없음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

