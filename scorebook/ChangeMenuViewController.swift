//
//  ChangeMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit



class ChangeMenuViewController: UIViewController {
    
    @IBOutlet weak var defensePlayerChangeButton: UIButton! // 선수 교체 버튼
    @IBOutlet weak var defensePlayersPositionChangeButton: UIButton!    // 포지션 교체 버튼
    @IBOutlet weak var hitChangeButton: UIButton!   // 타자 교체 버튼
    @IBOutlet weak var defensePositionChangeButtonDH: UIButton! // 지명타자 포지션 교체 버튼
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
