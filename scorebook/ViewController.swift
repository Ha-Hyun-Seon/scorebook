//
//  ViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2016. 12. 20..
//  Copyright © 2016년 Ha Hyunseon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnTest(_ sender: Any) {
        let fielderMenuViewController =  storyboard?.instantiateViewController(withIdentifier: "changeHitterMenu") as! ChangeHitterMenuViewController
        fielderMenuViewController.preferredContentSize = CGSize(width: 220, height: 360)
        fielderMenuViewController.modalPresentationStyle = .popover
        
        if let popoverController = fielderMenuViewController.popoverPresentationController {
            popoverController.sourceView = sender as? UIView
            //            popoverController.sourceRect = sender.bounds
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
        }
        present(fielderMenuViewController, animated: true, completion: nil)
    }
}

