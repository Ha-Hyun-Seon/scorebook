//
//  DefenderAddRunMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//  추가진루

import UIKit



class DefenderAddRunMenuViewController: UIViewController {
    
    @IBOutlet weak var addOutMenuViewInCatchAndThrowButton: UIButton!   // 포구 송구동작
    @IBOutlet weak var addAdvanceMenuViewInThrowButton: UIButton!   // 송구자 실책 진루
    @IBOutlet weak var addAdvanceMenuViewInCatchButton: UIButton!   // 포구자 실책 진루
    @IBOutlet weak var addAdvanceMenuViewInDefenseErrorButton: UIButton!    // 수비수 실책 진루
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
