//
//  ContainerViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 4. 4..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//
import UIKit

class ContainerViewController: UIViewController {
    
    var vc : UIViewController!
    var segueIdentifier : String!
    var lastViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segueIdentifierReceivedFromParent(button: "segueTeamAdd")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueIdentifierReceivedFromParent(button: String){
        
        self.segueIdentifier = button
        self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
        
//        if button == "buttonOne"
//        {
//            
//            self.segueIdentifier = "first"
//            self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
//            
//        }
//        else if button == "buttonTwo"
//        {
//            
//            self.segueIdentifier = "second"
//            self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == segueIdentifier{
            //Avoids creation of a stack of view controllers
            if lastViewController != nil{
                lastViewController.view.removeFromSuperview()
            }
            //Adds View Controller to Container "first" or "second"
            vc = segue.destination 
            self.addChildViewController(vc)
            vc.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            self.view.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
            lastViewController = vc
        }
    }
}
