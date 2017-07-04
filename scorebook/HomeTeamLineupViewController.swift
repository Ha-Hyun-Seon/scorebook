//
//  HomeTeamLineupViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 16..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit
import GameKit


class HomeTeamLineupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var teams = [TeamInfo]()
    var homeTeam = TeamInfo()
    var selectedLineups = [Lineup]()
    var lineups = [Lineup]()
    var currentSelectedLineup = Lineup()
    var currentLineup = Lineup()
    
    //홈팀명
    @IBOutlet weak var lblHomeTeamName: UILabel!
    
    // 포지션별 버튼 정의
    @IBOutlet weak var btnPositionSP: UIButton!
    @IBOutlet weak var btnPositionC: UIButton!
    @IBOutlet weak var btnPosition1B: UIButton!
    @IBOutlet weak var btnPosition2B: UIButton!
    @IBOutlet weak var btnPositionSS: UIButton!
    @IBOutlet weak var btnPosition3B: UIButton!
    @IBOutlet weak var btnPositionLF: UIButton!
    @IBOutlet weak var btnPositionCF: UIButton!
    @IBOutlet weak var btnPositionRF: UIButton!
    
    //라인업과 설정하는 라인업 tableview 정의
    @IBOutlet weak var selectedLineupTableView: UITableView!
    @IBOutlet weak var lineupTableView: UITableView!
    
    //투수 정보(포지션을 투수 선택 했을 때 자동으로 설정)
    @IBOutlet weak var btnSPName: UIButton!
    @IBOutlet weak var lblSPMemberNumber: UILabel!
    @IBOutlet weak var lblSPPositionName: UILabel!
    
    //자동 설정 버튼 정의
    @IBOutlet weak var btnAutoSetLineup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickPositionSP(_ sender: Any) {
        selectedPosition(isSelected: true, sender: sender)
    }
    
    @IBAction func clickPositionC(_ sender: Any) {
        selectedPosition(isSelected: true, sender: sender)
    }
    
    @IBAction func clickPosition1B(_ sender: Any) {
        selectedPosition(isSelected: true, sender: sender)
    }
    
    @IBAction func clickPosition2B(_ sender: Any) {
        selectedPosition(isSelected: true, sender: sender)
    }
    
    @IBAction func clickPositionSS(_ sender: Any) {
        selectedPosition(isSelected: true, sender: sender)
    }
    
    @IBAction func clickPosition3B(_ sender: Any) {
        selectedPosition(isSelected: true, sender: sender)
    }
    
    @IBAction func clickPositionLF(_ sender: Any) {
        selectedPosition(isSelected: true, sender: sender)
    }
    
    @IBAction func clickPositionCF(_ sender: Any) {
        selectedPosition(isSelected: true, sender: sender)
    }
    
    @IBAction func clickPositionRF(_ sender: Any) {
        selectedPosition(isSelected: true, sender: sender)
    }
    
    func selectedPosition(isSelected: Bool, sender: Any) {
        
        let positionButton = sender as! UIButton
        
        if isSelected {
            
            let positionName = (sender as! UIButton).title(for: .normal)!
            
            //기존 선택된 포지션이 있다면 제거
            if self.selectedLineups.first(where: { $0.positionName == positionName }) != nil {
                
                let alreadyLineup = self.selectedLineups.first(where: { $0.positionName == positionName })
                /*
                 * daisy
                 */
                let pastPositionButton = self.getPositionButtonByPositionName(positionName: currentSelectedLineup.positionName)
                //                self.loadPositionD(sender: btnSender)
                (pastPositionButton as AnyObject).setBackgroundImage(UIImage(named: "btn_pref_position_off.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
                /*
                 * daisy
                 */
                
                alreadyLineup?.positionName = "포지션"
                alreadyLineup?.isSetPosition = false
            }
            
            //선택된 포지션 설정
            self.currentSelectedLineup.positionName = positionName
            self.currentSelectedLineup.isSetPosition = true
            positionButton.setBackgroundImage(UIImage(named: "btn_pref_position_on.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
            //포지션이 투수일때는 투수 정보란에 입력
            if self.currentSelectedLineup.positionName == "SP" {
                self.setSPInformation(isSet: true, spName: self.currentSelectedLineup.name, spMemberNumber: self.currentSelectedLineup.memberNumber, spPositionName: self.currentSelectedLineup.positionName)
            }
        }
        else {
            positionButton.setBackgroundImage(UIImage(named: "btn_pref_position_off.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        //        if self.currentSelectedLineup.memberNumber == "라인업 설정"
        
        self.reLoadTableView()
    }
    
    func reLoadTableView() {
        let index = self.selectedLineupTableView.indexPathForSelectedRow
        self.selectedLineupTableView.reloadData()
        self.selectedLineupTableView.selectRow(at: index, animated: false, scrollPosition: .none)
    }
    
    @IBAction func clickSetLineupComplete(_ sender: Any) {
        
        if self.selectedLineups.count > 0 {
            if self.selectedLineups.first(where: { $0.isSetName == false }) != nil {
                let alert = UIAlertController(title: "확인", message: "라인업 설정을 확인 하세요.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if self.selectedLineups.first(where: { $0.isSetPosition == false }) != nil {
                let alert = UIAlertController(title: "확인", message: "포지션을 확인 하세요.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        
        self.homeTeam.mainLineupInfo = self.selectedLineups
//        
//        print(self.homeTeam.mainLineupInfo[0].isSetPosition)
//        
//        print(self.teams[0].mainLineupInfo[0].isSetPosition)
        
        //최종 저장
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.teams)
        userDefaults.set(encodedData, forKey: "Teams")
        userDefaults.synchronize()
        
    }
    
    @IBAction func clickAutoSetLineup(_ sender: Any) {
        
        if self.btnAutoSetLineup.tag == 0 {
            //라인업 초기화
            self.selectedLineups = [Lineup]()
            for i in 1...9 {
                let selectedLineup = Lineup()
                selectedLineup.number = String(i) + "번타자"
                selectedLineup.name = "라인업 설정"
                selectedLineup.memberNumber = "등번호"
                selectedLineup.positionName = "포지션"
                selectedLineup.isSetName = false
                selectedLineup.isSetPosition = false
                self.selectedLineups.append(selectedLineup)
            }
            self.setSPInformation(isSet: false, spName: "", spMemberNumber: "", spPositionName: "")
            self.btnAutoSetLineup.setTitle("라인업 설정", for: .normal)
            self.btnAutoSetLineup.tag = 1
        }
        else {
            //간단하게 차례데로
            self.selectedLineups = [Lineup]()
            for i in 0...self.lineups.count - 1 {
                let lineup = self.lineups[i]
                
                var isSetPosition = false
                while isSetPosition == false {
                    let positionName = self.getRandomPosition()
                    if self.selectedLineups.first(where : { $0.positionName == positionName }) == nil {
                        self.loadPosition(sender: self.getPositionButtonByPositionName(positionName: lineup.positionName))
                        lineup.positionName = positionName
                        lineup.isSetPosition = true
                        isSetPosition = true
                    }
                }
                
                lineup.number = String(i + 1) + "번타자"
                lineup.isSetName = true
                self.selectedLineups.append(lineup)
                
                if lineup.positionName == "SP" {
                    self.btnSPName.setTitle(lineup.name, for: .normal)
                    self.lblSPMemberNumber.text = lineup.memberNumber
                }
                
                if self.selectedLineups.count == 9 {
                    break
                }
            }
            
            self.btnAutoSetLineup.setTitle("라인업 초기화", for: .normal)
            self.btnAutoSetLineup.tag = 0
        }
        
        self.selectedLineupTableView.reloadData()
    }
    
    func setSPInformation(isSet:Bool, spName:String, spMemberNumber:String, spPositionName:String) {
        if isSet == true {
            self.btnSPName.setTitle(spName, for: .normal)
            self.lblSPMemberNumber.text = spMemberNumber
            self.lblSPPositionName.text = spPositionName
        }
        else {
            self.btnSPName.setTitle("라인업 설정", for: .normal)
            self.lblSPMemberNumber.text = ""
            self.lblSPPositionName.text = "SP"
        }
        
    }
    
    func getRandomPosition() -> String {
        let position = ["SP", "C", "1B", "2B", "SS", "3B", "LF", "CF", "RF"]
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: position.count)
        return position[randomNumber].description
    }
    
    func getRandomPlayer() -> Int {
        return 0
    }
    
    func loadPosition(sender: Any) {
        let positionButton = sender as! UIButton
        positionButton.setBackgroundImage(UIImage(named: "btn_pref_position_on.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func getPositionButtonByPositionName(positionName : String) -> Any {
        switch positionName {
        case "SP":
            return self.btnPositionSP
        case "C":
            return self.btnPositionC
        case "1B":
            return self.btnPosition1B
        case "2B":
            return self.btnPosition2B
        case "SS":
            return self.btnPositionSS
        case "3B":
            return self.btnPosition3B
        case "LF":
            return self.btnPositionLF
        case "CF":
            return self.btnPositionCF
        case "RF":
            return self.btnPositionRF
        default:
            return self.btnPositionRF
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == self.selectedLineupTableView {
            count = selectedLineups.count
        }
        
        if tableView == self.lineupTableView {
            count =  lineups.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case self.selectedLineupTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectedLineupCell", for: indexPath) as! SelectedLineupTableViewCell
            cell.lblNumber.text = selectedLineups[indexPath.row].number
            cell.lblName.text = selectedLineups[indexPath.row].name
            cell.lblMemberNumber.text = selectedLineups[indexPath.row].memberNumber
            cell.lblPosition.text = selectedLineups[indexPath.row].positionName
            return cell
        case self.lineupTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "lineupCell", for: indexPath) as! LineupTableViewCell
            cell.lblMemberNumber.text = lineups[indexPath.row].memberNumber
            cell.lblName.text = lineups[indexPath.row].name
            cell.lblPosition.text = lineups[indexPath.row].positionTemp
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "lineupCell", for: indexPath) as! LineupTableViewCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        switch tableView {
        case self.selectedLineupTableView:
            let cell = tableView.cellForRow(at: indexPath)! as! SelectedLineupTableViewCell
            
            let index = self.homeTeam.lineupInfo.index{$0.name == cell.lblName.text}
            if index != nil {
                self.lineupTableView.selectRow(at: IndexPath(row: index!, section: 0), animated: true, scrollPosition: .none)
            }
            else {
                self.lineupTableView.selectRow(at: IndexPath(row: -1, section: 0), animated: true, scrollPosition: .none)
            }
            
            self.currentSelectedLineup = self.selectedLineups[indexPath.row]
            
        case self.lineupTableView:
            
            let cell = tableView.cellForRow(at: indexPath)! as! LineupTableViewCell
            
            if self.selectedLineups.first(where: { $0.name == cell.lblName.text }) != nil {
                let alreadyLineup = self.selectedLineups.first(where: { $0.name == cell.lblName.text })
                self.selectedPosition(isSelected: false, sender: self.getPositionButtonByPositionName(positionName: (alreadyLineup?.positionName)!))
                self.btnSPName.setTitle("라인업 설정", for: .normal)
                self.lblSPMemberNumber.text = ""
                alreadyLineup?.name = "라인업 설정"
                alreadyLineup?.memberNumber = "등번호"
                alreadyLineup?.positionName = "포지션"
                alreadyLineup?.isSetName = false
                alreadyLineup?.isSetPosition = false
            }
            
            self.currentSelectedLineup.name = cell.lblName.text!
            self.currentSelectedLineup.memberNumber = cell.lblMemberNumber.text!
            self.currentSelectedLineup.isSetName = true
            self.reLoadTableView()
            
        default:
            return
        }
        
    }
    
    func getData() {
        let userDefaults = UserDefaults.standard
        
        if let data = userDefaults.data(forKey: "Teams"), let getTeams = NSKeyedUnarchiver.unarchiveObject(with: data) as? [TeamInfo] {
            if getTeams.count > 0 {
                for i in 0...getTeams.count - 1 {
                    teams.append(getTeams[i])
                }
            }
        }
        
        if self.teams.first(where: {$0.kind == "H"}) != nil {
            self.homeTeam = self.teams.first(where: {$0.kind == "H"})!
            self.lblHomeTeamName.text = self.homeTeam.name
            
            if self.homeTeam.lineupInfo.count > 0 {
                for i in 0...self.homeTeam.lineupInfo.count - 1 {
                    self.lineups.append(self.homeTeam.lineupInfo[i])
                }
            }
            
            //기존 등록된 라인업이 있다면 셋팅
            if self.homeTeam.mainLineupInfo.count != 0  {
                for i in 0...self.homeTeam.mainLineupInfo.count - 1 {
                    self.selectedLineups.append(self.homeTeam.mainLineupInfo[i])
                    let name = self.homeTeam.mainLineupInfo[i].name
                    let number = self.homeTeam.mainLineupInfo[i].memberNumber
                    let positionName = self.homeTeam.mainLineupInfo[i].positionName
                    if self.homeTeam.mainLineupInfo[i].isSetPosition == true {
                        let btnSender = self.getPositionButtonByPositionName(positionName: positionName)
                        self.loadPosition(sender: btnSender)
                    }
                    
                    //포지션이 투수일때는 투수 정보란에 입력
                    if self.homeTeam.mainLineupInfo[i].positionName == "SP" {
                        self.setSPInformation(isSet: true, spName: name, spMemberNumber: number, spPositionName: positionName)
                    }
                }
                self.btnAutoSetLineup.setTitle("라인업 초기화", for: .normal)
                self.btnAutoSetLineup.tag = 0
            }
            
        }
        else {
            let alert = UIAlertController(title: "확인", message: "원정팀을 지정 하세요.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if self.selectedLineups.count == 0 {
            for i in 1...9 {
                let selectedLineup = Lineup()
                selectedLineup.number = String(i) + "번타자"
                selectedLineup.name = "라인업 설정"
                selectedLineup.memberNumber = "등번호"
                selectedLineup.positionName = "포지션"
                selectedLineup.isSetName = false
                selectedLineup.isSetPosition = false
                self.selectedLineups.append(selectedLineup)
            }
        }
        
    }
}
