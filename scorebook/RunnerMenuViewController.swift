//
//  RunnerMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit



class RunnerMenuViewController: UIViewController {
    
    var currentInningInfo : InningInfo = InningInfo()
    var currentLineup : Lineup = Lineup()
    var teamKind = ""
    var mainRunnerMenuCompleteDelegate : MainRunnerMenuComplete?
    var changeRunnerCompleteDelegate : ChangeRunnerComplete?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickChangeRunner(_ sender: Any) {
        let changeRunnerMenuViewController = storyboard?.instantiateViewController(withIdentifier: "changerunner") as! ChangeRunnerMenuViewController
        changeRunnerMenuViewController.changeRunnerCompleteDelegate = self.changeRunnerCompleteDelegate
        changeRunnerMenuViewController.teamKind = self.teamKind
        changeRunnerMenuViewController.preferredContentSize = CGSize(width: 220, height: 360)
        
        changeRunnerMenuViewController.modalPresentationStyle = .popover
        
        if let popoverController = changeRunnerMenuViewController.popoverPresentationController {
            popoverController.sourceView = sender as! UIView
            popoverController.sourceRect = (sender as AnyObject).bounds
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self.parent as! UIPopoverPresentationControllerDelegate?
        }
        
        present(changeRunnerMenuViewController, animated: true, completion: nil)
    }
    
}
