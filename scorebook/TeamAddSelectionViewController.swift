//
//  TeamAddSelectionViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 23..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit
//import CoreData


class TeamAddSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var teamTableView: UITableView!
    var teams = [TeamInfo]()
    var currentTeam : TeamInfo = TeamInfo()
    
    // 원정팀 정보
    var visitedTeam : TeamInfo = TeamInfo()
    // 홈팀 정보
    var homeTeam : TeamInfo = TeamInfo()
    // 게임정보
    var currentGameInfo = GameInfo()
    
    // 선택한 버튼 정보
    var selectTeamButton = ""
    // 선택한 원정팀 명
    var selectVisitTeamName = ""
    // 선택한 홈팀 명
    var selectHomeTeamName = ""
    
    @IBOutlet weak var btnVisitedTeam: UIButton!
    @IBOutlet weak var btnHomeTeam: UIButton!
    @IBOutlet weak var txtfldGameName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.GetTeam()
        self.getGameInfo()
        
        teamTableView.reloadData()
        
        self.settingInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.teams = [TeamInfo]()
        
        self.currentGameInfo.name = self.txtfldGameName.text!
        
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.currentGameInfo)
        userDefaults.set(encodedData, forKey: "Game")
        userDefaults.synchronize()
    }
    
//    func completeTeamAdd() -> Bool {
//        // 게임명 저장
//        var check : Bool = true
//        var message : String = ""
//        if self.selectVisitTeamName == "원정팀 선택" {
//            check = false
//            message = "원정팀을 선택하세요."
//        }
//        else if self.selectHomeTeamName == "홈팀 선택" {
//            check = false
//            message = "홈팀을 선택하세요."
//        }
//        
//        if check == false {
//            let alert = UIAlertController(title: "확인", message: message, preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            
//            return check
//        }
//        
//        self.currentGameInfo.name = self.txtfldGameName.text!
//        
//        let userDefaults = UserDefaults.standard
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.currentGameInfo)
//        userDefaults.set(encodedData, forKey: "Game")
//        userDefaults.synchronize()
//        
//        return true
//    }
    
    func settingInfo(){
        
        if self.visitedTeam.name == "" {
            selectVisitTeamName = "원정팀 선택"
        }
        else{
            selectVisitTeamName = self.visitedTeam.name
        }
        if self.homeTeam.name == "" {
            selectHomeTeamName = "홈팀 선택"
        }
        else{
            selectHomeTeamName = self.homeTeam.name
        }
        
        self.btnVisitedTeam.setTitle(selectVisitTeamName, for: .normal)
        self.btnHomeTeam.setTitle(selectHomeTeamName, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnVisitedTeamAction(_ sender: Any) {
//        self.btnVisitedTeam.isSelected = true
//        self.btnHomeTeam.isSelected = false
        self.selectTeamButton = "V"
        if self.btnVisitedTeam.titleLabel?.text != "원정팀 선택" {
            
            let selectedTeam : TeamInfo = self.teams.first(where : { $0.name == self.btnVisitedTeam.titleLabel?.text })!
            selectedTeam.kind = ""
            
            self.btnVisitedTeam.setTitle("원정팀 선택", for: .normal)
            self.selectVisitTeamName = "원정팀 선택"
            
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.teams)
            userDefaults.set(encodedData, forKey: "Teams")
            userDefaults.synchronize()
        }
    }
    
    @IBAction func btnHomeTeamAction(_ sender: Any) {
//        self.btnVisitedTeam.isSelected = false
//        self.btnHomeTeam.isSelected = true
        self.selectTeamButton = "H"
        if self.btnHomeTeam.titleLabel?.text != "홈팀 선택" {
            
            let selectedTeam : TeamInfo = self.teams.first(where : { $0.name == self.btnHomeTeam.titleLabel?.text })!
            selectedTeam.kind = ""
            
            self.btnHomeTeam.setTitle("홈팀 선택", for: .normal)
            self.selectVisitTeamName = "홈팀 선택"
            
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.teams)
            userDefaults.set(encodedData, forKey: "Teams")
            userDefaults.synchronize()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notLoginTeamList", for: indexPath) as! TeamAddSelectionTableViewCell
        cell.cellTeamNameLabel.text = teams[indexPath.row].name
        
        if self.selectVisitTeamName == teams[indexPath.row].name {
            cell.backgroundColor = UIColor.groupTableViewBackground
//            cell.isSelected = false
        }
        if self.selectHomeTeamName == teams[indexPath.row].name {
            cell.backgroundColor = UIColor.groupTableViewBackground
//            cell.isSelected = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let currentCell = tableView.cellForRow(at: indexPath)! as! TeamAddSelectionTableViewCell
        var teamKind = ""
        
//        if self.btnVisitedTeam.isSelected {
//            self.btnVisitedTeam.titleLabel?.text = currentCell.cellTeamNameLabel.text
//            teamKind = "V"
//        }
//        
//        if self.btnHomeTeam.isSelected {
//            self.btnHomeTeam.titleLabel?.text = currentCell.cellTeamNameLabel.text
//            teamKind = "H"
//        }
        
        if self.selectTeamButton == "V" {
            self.btnVisitedTeam.setTitle(currentCell.cellTeamNameLabel.text, for: .normal)
            self.selectVisitTeamName = currentCell.cellTeamNameLabel.text!
            teamKind = "V"
        }
        
        if self.selectTeamButton == "H" {
            self.btnHomeTeam.setTitle(currentCell.cellTeamNameLabel.text, for: .normal)
            self.selectHomeTeamName = currentCell.cellTeamNameLabel.text!
            teamKind = "H"
        }
        
        self.teams[indexPath.row].name = currentCell.cellTeamNameLabel.text!
        self.teams[indexPath.row].kind = teamKind
        
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: teams)
        userDefaults.set(encodedData, forKey: "Teams")
        userDefaults.synchronize()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "DELETE"){(UITableViewRowAction,NSIndexPath) -> Void in
            
//            print("What u want while Pressed delete")
            self.teams.remove(at: indexPath.row) //teams is array from i delete values
            
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.teams)
            userDefaults.set(encodedData, forKey: "Teams")
            userDefaults.synchronize()
            
            tableView.deleteRows(at: [indexPath],  with: UITableViewRowAnimation.automatic)
        }
        let edit = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "EDIT"){(UITableViewRowAction,NSIndexPath) -> Void in
            
//            print("What u want while Pressed Edit")
            self.currentTeam = self.teams[indexPath.row]
            self.performSegue(withIdentifier: "editTeamPlayerSegue", sender: self)
        }
        
        return [delete,edit]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTeamPlayerSegue" {
            if let viewController = segue.destination as? AddTeamPlayerViewController {
                viewController.currentTeam = currentTeam
                viewController.teams = self.teams
            }
        }
        if segue.identifier == "addTeamPlayerSegue" {
            if let viewController = segue.destination as? AddTeamPlayerViewController {
                viewController.teams = self.teams
            }
        }
    }
    
    func GetTeam(){
//        let userDefaults = UserDefaults.standard
//        if let data = userDefaults.data(forKey: "Teams"), let getTeams = NSKeyedUnarchiver.unarchiveObject(with: data) as? [TeamInfo] {
//            for i in 0...getTeams.count - 1 {
//                teams.append(getTeams[i])
//            }
//        }
        
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "Teams"), let getTeams = NSKeyedUnarchiver.unarchiveObject(with: data) as? [TeamInfo] {
            if getTeams.count > 0 {
                for i in 0...getTeams.count - 1 {
                    self.teams.append(getTeams[i])
                    
                    if self.teams[i].kind == "H" {
                        self.homeTeam = self.teams.first(where : { $0.kind == "H" })!
                    }
                    if self.teams[i].kind == "V" {
                        self.visitedTeam = self.teams.first(where : { $0.kind == "V" })!
                    }
                }
            }
        }
    }
    
    func getGameInfo(){
        let userDefaults = UserDefaults.standard
        let game = userDefaults.data(forKey: "Game")
        self.currentGameInfo = (NSKeyedUnarchiver.unarchiveObject(with: game!) as? GameInfo)!
        
        self.txtfldGameName.text = self.currentGameInfo.name
        
    }
}
