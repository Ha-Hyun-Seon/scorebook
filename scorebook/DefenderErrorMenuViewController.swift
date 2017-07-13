//
//  DefenderErrorMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//  수비수 실책

import UIKit



class DefenderErrorMenuViewController: UIViewController {
    
    @IBOutlet weak var catchAndThrowAdvanceViewInCatchAndThrowButton: UIButton! // 포구 후 송구 동작
    @IBOutlet weak var catchAndThrowAdvanceViewInThrowButton: UIButton! // 송구자 실책 진루
    @IBOutlet weak var catchAndThrowAdvanceViewInCatchButton: UIButton! // 포구자 실책 진루
    @IBOutlet weak var catchAndThrowAdvanceViewInDefenseErrorButton: UIButton!  // 수비수 실책 진루
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
