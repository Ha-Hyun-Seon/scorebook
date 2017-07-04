//
//  PreferenceViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 9..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController {
    
    var containerView: ContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 비로그인시 임의의 team정보를 보여주기 위해 파일 작성
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMain(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTeamAdd(_ sender: AnyObject) {
        containerView!.segueIdentifierReceivedFromParent(button: "segueTeamAdd")
    }
    
    @IBAction func btnGameInfo(_ sender: Any) {
        let returnValue = validationCheck(button: "GameInfo")
        if returnValue == true {
            containerView!.segueIdentifierReceivedFromParent(button: "segueGameInfo")
        }
    }
    
    @IBAction func btnVisitLineup(_ sender: Any) {
        let returnValue = validationCheck(button: "VisitLineup")
        if returnValue == true {
            containerView!.segueIdentifierReceivedFromParent(button: "segueVisitTeam")
        }
    }
    @IBAction func btnHomeLineup(_ sender: Any) {
        let returnValue = validationCheck(button: "HomeLineup")
        if returnValue == true {
            containerView!.segueIdentifierReceivedFromParent(button: "segueHomeTeam")
        }
    }
    
    @IBAction func btnRecordStart(_ sender: Any) {
        let returnValue = validationCheck(button: "RecordStart")
        if returnValue == true {
            self.performSegue(withIdentifier: "segueRecordStart", sender: self)
        }
    }
    
    @IBAction func btnVisitRecordPaper(_ sender: Any) {
        let returnValue = validationCheck(button: "VisitRecordPaper")
        if returnValue == true {
            self.performSegue(withIdentifier: "segueVisitRecordPaper", sender: self)
        }
    }
    
    @IBAction func btnHomeRecordPaper(_ sender: Any) {
        let returnValue = validationCheck(button: "HomeRecordPaper")
        if returnValue == true {
            self.performSegue(withIdentifier: "segueHomeRecordPaper", sender: self)
        }
    }
    
    func validationCheck(button : String)->Bool{
        
        var teams = [TeamInfo]()
        
        // 원정팀 정보
        var visitedTeam : TeamInfo = TeamInfo()
        
        // 홈팀 정보
        var homeTeam : TeamInfo = TeamInfo()
        
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "Teams"), let getTeams = NSKeyedUnarchiver.unarchiveObject(with: data) as? [TeamInfo] {
            for i in 0...getTeams.count - 1 {
                teams.append(getTeams[i])
                
                if teams[i].kind == "H" {
                    homeTeam = teams.first(where : { $0.kind == "H" })!
                }
                if teams[i].kind == "V" {
                    visitedTeam = teams.first(where : { $0.kind == "V" })!
                }
            }
        }
        
        var check : Bool = true
        var message : String = ""
        if button == "RecordStart" {
            if visitedTeam.mainLineupInfo.count < 9 {
                check = false
                message = "원정팀 Line-up을 설정하세요."
            }
            else if homeTeam.mainLineupInfo.count < 9 {
                check = false
                message = "홈팀 Line-up을 설정하세요."
            }
        }
        else if button == "HomeLineup" {
            if homeTeam.name == "" {
                check = false
                message = "홈팀을 선택하세요."
            }
        }
        else if button == "VisitLineup" {
            if visitedTeam.name == "" {
                check = false
                message = "원정팀을 선택하세요."
            }
        }
        else if button == "GameInfo" {
            if homeTeam.name == "" {
                check = false
                message = "홈팀을 선택하세요."
            }
            else if visitedTeam.name == "" {
                check = false
                message = "원정팀을 선택하세요."
            }
        }
        else if button == "VisitRecordPaper" {
            if visitedTeam.mainLineupInfo.count < 9 {
                check = false
                message = "원정팀 Line-up을 설정하세요."
            }
        }
        else if button == "HomeRecordPaper" {
            if homeTeam.mainLineupInfo.count < 9 {
                check = false
                message = "홈팀 Line-up을 설정하세요."
            }
        }
        
        if check == false {
            let alert = UIAlertController(title: "확인", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return check
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "container"{
            self.containerView = segue.destination as? ContainerViewController
            
        }
        else if segue.identifier == "segueVisitRecordPaper" {
            if let viewController = segue.destination as? RecordingPaperViewController {
                viewController.teamKind = "V"
            }
        }
        else if segue.identifier == "segueHomeRecordPaper" {
            if let viewController = segue.destination as? RecordingPaperViewController {
                viewController.teamKind = "H"
            }
        }
    }
}
