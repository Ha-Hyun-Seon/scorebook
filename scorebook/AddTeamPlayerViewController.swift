//
//  AddTeamPlayerViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 23..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit
import Foundation

class AddTeamPlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playerNumber: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var positionSegmentControl: UISegmentedControl!
    
    var currentPositionNumber : String = ""
    var currentPositionString : String = ""
    
    // TeamInfo 정보 담아두기
    var teams = [TeamInfo]()
    var teamInfo : TeamInfo = TeamInfo()
    var lineups : [Lineup] = [Lineup]()
    var currentTeam : TeamInfo = TeamInfo() // 이전화면에서 선택된 team정보가 넘어옴
    var selectedPlayer : Lineup = Lineup()  // 선택된 선수정보
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modifyTeam()
        if self.currentTeam.name == "" {
            self.teamName.isEnabled = true
            self.teamName.isUserInteractionEnabled = true
        }
        else{
            self.teamName.isEnabled = false
            self.teamName.isUserInteractionEnabled = false
        }
    }
    
    func modifyTeam() {
        //셋팅
        //팀명
        self.teamName.text = currentTeam.name
        
        //라인업
        lineups = currentTeam.lineupInfo
        //self.tableView.selectRow(at: 0, animated: true, scrollPosition: nil)
        
        // 수정시 신규만 추가할때 문제가 있음
        /*
        self.selectedPlayer = lineups[0]
        self.playerName.text = self.selectedPlayer.name
        self.playerNumber.text = self.selectedPlayer.memberNumber
        
        var positionSegmentIdx = 0
        switch self.selectedPlayer.positionTemp {
        case "투수":
            positionSegmentIdx = 0
        case "포수":
            positionSegmentIdx = 1
        case "내야수":
            positionSegmentIdx = 2
        case "외야수":
            positionSegmentIdx = 3
        default:
            positionSegmentIdx = 0
        }
        
        self.positionSegmentControl.selectedSegmentIndex = positionSegmentIdx
         */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAddPlayer(_ sender: Any) {
        // _ = :리턴값이 있을경우 받아서 사용할 필요가 없을때 사용
        // ? : 형을 모를때 사용
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCompleted(_ sender: Any) {
        
        if self.currentTeam.name == "" {
            if self.teamName.text != "" && lineups.count > 0 {
                teamInfo.name = self.teamName.text!
                teamInfo.lineupInfo = lineups
                teams.append(teamInfo)
            }
        }
        else{
            self.currentTeam.name = self.teamName.text!
            self.currentTeam.lineupInfo = lineups
        }
        
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: teams)
        userDefaults.set(encodedData, forKey: "Teams")
        userDefaults.synchronize()
        
        _ = navigationController?.popViewController(animated: true)
    }
    

    @IBAction func newPlayer(_ sender: Any) {
        
        playerName.text = ""
        playerNumber.text = ""
        positionSegmentControl.selectedSegmentIndex = 0
        
        self.selectedPlayer = Lineup()

    }
    
    
    @IBAction func addPlayer(_ sender: Any) {
        // 저장된 팀정보 가져오기, 중복 확인을 위함
        
        if self.validtionCheck() == false {
            return
        }
        
        var positionSegmentName = ""
        switch self.positionSegmentControl.selectedSegmentIndex {
        case 0:
            positionSegmentName = "투수"
        case 1:
            positionSegmentName = "포수"
        case 2:
            positionSegmentName = "내야수"
        case 3:
            positionSegmentName = "외야수"
        default:
            positionSegmentName = "투수"
        }

//        print(lineups.count)
//        print(lineups[0].name)
//        print(lineups[0].memberNumber)
        
        if selectedPlayer.name == "" {
            // 신규 추가
            let lineup : Lineup = Lineup()
            lineup.name = self.playerName.text!
            lineup.memberNumber = self.playerNumber.text!
            lineup.positionTemp = positionSegmentName
            
            lineups.append(lineup)
        }
        else{
            // 기존 수정
//            lineups.remove(at: selectedIndex)
//            lineups.insert(lineup, at: selectedIndex)
            self.selectedPlayer.name = self.playerName.text!
            self.selectedPlayer.memberNumber = self.playerNumber.text!
            self.selectedPlayer.positionTemp = positionSegmentName
        }
        
        tableView.reloadData()
        
        playerName.text = ""
        playerNumber.text = ""
//        teamName.isEnabled = false
        positionSegmentControl.selectedSegmentIndex = 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "lineupcell", for: indexPath) as! AddTeamPlayerTableViewCell
        
        cell.cellPlayerNameLabel.text = lineups[indexPath.row].name
        cell.cellPlayerNumberLabel.text = lineups[indexPath.row].memberNumber
        cell.cellPositionLabel.text = lineups[indexPath.row].positionTemp

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        let currentCell = tableView.cellForRow(at: indexPath)! as! AddTeamPlayerTableViewCell
        
        self.selectedPlayer = self.lineups[indexPath.row]
        
        self.playerName.text = currentCell.cellPlayerNameLabel.text
        self.playerNumber.text = currentCell.cellPlayerNumberLabel.text
        
        switch currentCell.cellPositionLabel.text! {
            case "투수":
                self.positionSegmentControl.selectedSegmentIndex = 0
            case "포수":
                self.positionSegmentControl.selectedSegmentIndex = 1
            case "내야수":
                self.positionSegmentControl.selectedSegmentIndex = 2
            case "외야수":
                self.positionSegmentControl.selectedSegmentIndex = 3
        default:
            self.positionSegmentControl.isSelected = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "DELETE"){(UITableViewRowAction,NSIndexPath) -> Void in
//           print("What u want while Pressed delete")
            self.lineups.remove(at: indexPath.row) //lineups is array from i delete values
            tableView.deleteRows(at: [indexPath],  with: UITableViewRowAnimation.automatic)
        }
        /*
         // 수정일 경우
        let edit = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "EDIT"){(UITableViewRowAction,NSIndexPath) -> Void in
            
            print("What u want while Pressed Edit")
            
            self.selectedPlayer = self.lineups[indexPath.row]
         
            self.playerName.text = self.lineups[indexPath.row].name
            self.playerNumber.text = self.lineups[indexPath.row].memberNumber
            
            var positionSegmentIdx = 0
            switch self.lineups[indexPath.row].positionTemp {
            case "투수":
                positionSegmentIdx = 0
            case "포수":
                positionSegmentIdx = 1
            case "내야수":
                positionSegmentIdx = 2
            case "외야수":
                positionSegmentIdx = 3
            default:
                positionSegmentIdx = 0
            }
            
            self.positionSegmentControl.selectedSegmentIndex = positionSegmentIdx
        }
        */
        
//        return [delete,edit]
        return [delete]
    }
    
    func validtionCheck() -> Bool {
        var check : Bool = true
        var message : String = ""
        if self.teamName.text == "" {
            check = false
            message = "팀명을 확인 하세요."
        }
        else if self.playerName.text == "" {
            check = false
            message = "선수명을 확인 하세요."
        }
        else if self.playerNumber.text == "" {
            check = false
            message = "선수 등번호를 확인 하세요."
        }
      
        if teams.index(where: {$0.name == teamName.text}) != nil {
            if self.currentTeam.name == "" {
                check = false
                message = "동일한 팀명이 있습니다."
            }
        }
        
        if check == false {
            let alert = UIAlertController(title: "확인", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return check
    }
    
}
