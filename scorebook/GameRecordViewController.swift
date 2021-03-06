//
//  GameRecordViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 15..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit

class GameRecordViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDataSource, UITableViewDelegate, PitcherPopoverComplete, BatterPopoverComplete, RunnerAnimationComplete, HoldRunnerComplete, BaseRunnerComplete, MainRunnerMenuComplete, ChangeRunnerComplete {
    
    var runnerPosition1 : RunnerPosition = RunnerPosition.Default
    var sendd : String = ""
    var tagOutRecord : String = ""
    //공위치
    var ballXY : String = ""
    var teams : [TeamInfo] = [TeamInfo]()
    var visitedTeam : TeamInfo = TeamInfo()
    var homeTeam : TeamInfo = TeamInfo()
    var hRecord : HRecordInfo = HRecordInfo()
    //현재 이닝 정보(1회초, 2회말...)
    //    var inningNumber : Int = 1
    //    var inningKind : String = "ST"
    
    //이닝 변경 상태
    var isInningChange : Bool = false
    
    //공수 교대 상태
    var isOffenceDefenceChange : Bool = false
    
    //현재 팀 정보
    var currentTeam : TeamInfo = TeamInfo()
    
    //현재 이닝 정보
    var currentInningInfo : InningInfo = InningInfo()
    
    //현재 타석 기록 정보
    var currentHrecord : HRecordInfo = HRecordInfo()
    
    //현재 투수 기록 정보
    var currentPrecord : PRecordInfo = PRecordInfo()
    
    //현재 투수 정보
    var currentPLineup : Lineup = Lineup()
    
    //현재 타자 정보
    var currentLineup : Lineup = Lineup()
    
    //다음 타자 정보
    var secondLineup : Lineup = Lineup()
    
    //세번째 타자 정보
    var thirdLineup : Lineup = Lineup()
    
    //첫 타자 여부
    var isFirstBatter : Bool = false
    
    //추가 기록 상태
    var addActionState : AddActionState = .Default
    
    //주자별 기록지(1루, 2루, 3루, 홈, 기타)
    var oneRunnerHRecord : HRecordInfo = HRecordInfo()
    var twoRunnerHRecord : HRecordInfo = HRecordInfo()
    var threeRunnerHRecord : HRecordInfo = HRecordInfo()
    var homeRunnerHRecordList : [HRecordInfo] = [HRecordInfo]()
    var tempRunnerHRecord : HRecordInfo = HRecordInfo()
    
    //중간주자별 기록
    var oneHalfRunnerHRecord : HRecordInfo = HRecordInfo()
    var twoHalfRunnerHRecord : HRecordInfo = HRecordInfo()
    var threeHalfRunnerHRecord : HRecordInfo = HRecordInfo()
    
    //포지션별 주자 형태
    var runnerState : RunnerState = RunnerState.Default
    
    //포지션 버튼 클릭 상태(메인일때와 서브일때 구분)
    var positionClickState = ""
    
    //기록지 기본 숫자
    var recordCount : Int = 2
    
    //주자 존재 상태
    var isOneRunner : Bool = false
    var isTwoRunner : Bool = false
    var isThreeRunner : Bool = false
    
    //완료 상태(타자의 완료와, 주자의 완료 구분)
    var statusDone : StatusDone = StatusDone.Default
    
    //도루 상태
    var stealState : StealState = StealState.Default

    
    //주자 기록 종류
    var actionPopState : ActionPopState = ActionPopState.Default
    
    //달리는 주자 형태
    var addActionRunnerState : AddActionRunnerState = AddActionRunnerState.Default
    
    //투구 전광판 (스트라이크, 볼, 아웃 카운트)
    var pitcherScoreBoardInfo : PitcherScoreBoardInfo = PitcherScoreBoardInfo()
    
    
    //현재 이닝 Label
    var currentInningLabel : UILabel = UILabel()
    
    //전광판 원정팀 이름 정의
    @IBOutlet weak var lblDSVisitedTeamName: UILabel!
    
    //전광판 원정팀 이닝 정의
    @IBOutlet weak var lblDS1ST: UILabel!
    @IBOutlet weak var lblDS2ST: UILabel!
    @IBOutlet weak var lblDS3ST: UILabel!
    @IBOutlet weak var lblDS4ST: UILabel!
    @IBOutlet weak var lblDS5ST: UILabel!
    @IBOutlet weak var lblDS6ST: UILabel!
    @IBOutlet weak var lblDS7ST: UILabel!
    @IBOutlet weak var lblDS8ST: UILabel!
    @IBOutlet weak var lblDS9ST: UILabel!
    
    //전광판 원정팀 점수, 안타, 볼넷, 에러 정의
    @IBOutlet weak var lblDSVisitedTeamRuns: UILabel!
    @IBOutlet weak var lblDSVisitedTeamHits: UILabel!
    @IBOutlet weak var lblDSVisitedTeamBaseOnBalls: UILabel!
    @IBOutlet weak var lblDSVisitedTeamErrors: UILabel!
    
    //전광판 홈팀 이름 정의
    @IBOutlet weak var lblDSHomeTeamName: UILabel!
    
    //전광판 홈팀 이닝 정의
    @IBOutlet weak var lblDS1BT: UILabel!
    @IBOutlet weak var lblDS2BT: UILabel!
    @IBOutlet weak var lblDS3BT: UILabel!
    @IBOutlet weak var lblDS4BT: UILabel!
    @IBOutlet weak var lblDS5BT: UILabel!
    @IBOutlet weak var lblDS6BT: UILabel!
    @IBOutlet weak var lblDS7BT: UILabel!
    @IBOutlet weak var lblDS8BT: UILabel!
    
    //전광판 원정팀 점수, 안타, 볼넷, 에러 정의
    @IBOutlet weak var lblDS9BT: UILabel!
    @IBOutlet weak var lblDSHomeTeamRuns: UILabel!
    @IBOutlet weak var lblDSHomeTeamHits: UILabel!
    @IBOutlet weak var lblDSHomeTeamBaseOnBalls: UILabel!
    @IBOutlet weak var lblDSHomeTeamErrors: UILabel!
    
    //전광판 볼, 스트라이크, 아웃 정의
    @IBOutlet weak var ivOneBall: UIImageView!
    @IBOutlet weak var ivTwoBall: UIImageView!
    @IBOutlet weak var ivThreeBall: UIImageView!
    @IBOutlet weak var ivOneStrike: UIImageView!
    @IBOutlet weak var ivTwoStrike: UIImageView!
    @IBOutlet weak var ivOneOut: UIImageView!
    @IBOutlet weak var ivTwoOut: UIImageView!
    
    //팀명 정의(공격, 수비)
    @IBOutlet weak var lblAttackTeamName: UILabel!
    @IBOutlet weak var lblDefenseTeamName: UILabel!
    
    //포지션 정의
    @IBOutlet weak var btnPositionSP: UIButton!
    @IBOutlet weak var btnPositionC: UIButton!
    @IBOutlet weak var btnPosition1B: UIButton!
    @IBOutlet weak var btnPosition2B: UIButton!
    @IBOutlet weak var btnPositionSS: UIButton!
    @IBOutlet weak var btnPosition3B: UIButton!
    @IBOutlet weak var btnPositionLF: UIButton!
    @IBOutlet weak var btnPositionCF: UIButton!
    @IBOutlet weak var btnPositionRF: UIButton!
    
    //타석기록지(투수기록) 정의
    @IBOutlet weak var ivPitcherRecord1: UIImageView!
    @IBOutlet weak var ivPitcherRecord2: UIImageView!
    @IBOutlet weak var ivPitcherRecord3: UIImageView!
    @IBOutlet weak var ivPitcherRecord4: UIImageView!
    @IBOutlet weak var ivPitcherRecord5: UIImageView!
    @IBOutlet weak var ivPitcherRecord6: UIImageView!
    @IBOutlet weak var ivPitcherRecord7: UIImageView!
    @IBOutlet weak var ivPitcherRecord8: UIImageView!
    @IBOutlet weak var ivPitcherRecord9: UIImageView!
    @IBOutlet weak var ivPitcherRecord10: UIImageView!
    @IBOutlet weak var ivPitcherRecord11: UIImageView!
    @IBOutlet weak var ivPitcherRecord12: UIImageView!
    @IBOutlet weak var ivPitcherRecord13: UIImageView!
    @IBOutlet weak var ivPitcherRecord14: UIImageView!
    @IBOutlet weak var ivPitcherRecord15: UIImageView!
    @IBOutlet weak var ivPitcherRecord16: UIImageView!
    
    //타석기록지(타자기록) 정의
    @IBOutlet weak var ivBatterRecord1: UIImageView!
    @IBOutlet weak var ivBatterRecord2: UIImageView!
    @IBOutlet weak var ivBatterRecord3: UIImageView!
    @IBOutlet weak var ivBatterRecord4: UIImageView!
    @IBOutlet weak var ivBatterRecord5: UIImageView!
    @IBOutlet weak var lblBatterRecord1: UILabel!
    @IBOutlet weak var lblBatterRecord2: UILabel!
    @IBOutlet weak var lblBatterRecord3: UILabel!
    @IBOutlet weak var lblBatterRecord4: UILabel!
    
    //수비수를 선택해주세요 라벨
    @IBOutlet weak var lblPositionMessage: UILabel!
    
    //주자 버튼 정의
    @IBOutlet weak var btnRunner1: UIButton!
    @IBOutlet weak var btnRunner2: UIButton!
    @IBOutlet weak var btnRunner3: UIButton!
    @IBOutlet weak var btnRunnerH_1: UIButton!
    @IBOutlet weak var btnRunner1_2: UIButton!
    @IBOutlet weak var btnRunner2_3: UIButton!
    @IBOutlet weak var btnRunner3_H: UIButton!
    
    //타자 정보 정의
    @IBOutlet weak var lblBatterNumber: UILabel!
    @IBOutlet weak var lblBatterName: UILabel!
    @IBOutlet weak var lblBatterMemberNumber: UILabel!
    @IBOutlet weak var lblBatterTimeAtBat: UILabel!
    @IBOutlet weak var lblBatterHitCount: UILabel!
    @IBOutlet weak var lblNextBatterName: UILabel!
    @IBOutlet weak var lblNextBatterMemberNumber: UILabel!
    
    //투수 정보 정의
    @IBOutlet weak var lblPitcherName: UILabel!
    @IBOutlet weak var lblPitcherMemberNumber: UILabel!
    @IBOutlet weak var lblPitcherTotalCount: UILabel!
    @IBOutlet weak var lblPitcherHitCount: UILabel!
    @IBOutlet weak var lblPitcherBaseOnBallsCount: UILabel!
    @IBOutlet weak var lblPitcherStrikeOutCount: UILabel!
    
    //야구공
    @IBOutlet weak var ivBall: UIImageView!
    
    //기록지 TableView
    @IBOutlet weak var recordTableView: UITableView!
    
    //투구 버튼
    @IBOutlet weak var btnPitcher: UIButton!
    
    //Done(완료) 버튼
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //기록 초기화
        self.getTeams()
        for index in 0...self.teams.count - 1 {
            self.teams[index].inningInfo = []
        }
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.teams)
        userDefaults.set(encodedData, forKey: "Teams")
        userDefaults.synchronize()
        
        self.getTeams()
        self.positionImgSet(isOn: false)
        self.recordTableView.scrollsToTop = false
        //현재 이닝 표시
        self.currentInningLabel = self.lblDS1ST
        
        //야구공
        self.ivBall.isHidden = true
        
//        let temp : Set<Lineup> = Set(self.visitedTeam.lineupInfo).subtracting(Set(self.visitedTeam.mainLineupInfo))
//        let temp1 : Set<Lineup> = Set(self.visitedTeam.lineupInfo).intersection(Set(self.visitedTeam.mainLineupInfo))
//        let arr : [Lineup] = Array(temp)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //팀 정보 설정
    func getTeams() {
        let userDefaults = UserDefaults.standard
        if (UserDefaults.standard.object(forKey: "Teams") != nil){
            let decoded  = userDefaults.object(forKey: "Teams") as! Data
            self.teams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [TeamInfo]
            
            self.homeTeam = self.teams.first(where : { $0.kind == "H" })!
            self.visitedTeam = self.teams.first(where : { $0.kind == "V" })!
            
        }
        self.baseInformationLoad()
    }
    
    func baseInformationLoad() {
        
        self.lblAttackTeamName.text = self.visitedTeam.name
        self.lblDefenseTeamName.text = self.homeTeam.name
        
        //공격팀 정보 셋팅
        //맨 처음은 원정팀 1번타자
        self.currentLineup = self.visitedTeam.mainLineupInfo[0]
        
        //현재 공격팀 정보를 넣는다.
        self.currentTeam = self.visitedTeam
        
        //포지션별 등번호 셋팅(첫 시작은 HomeTeam 수비)
        //홈팀
        self.positionMemberNumberSet(kind: "H")
        
        //        데이터 초기화
        //        for index in 0...self.teams.count - 1 {
        //            self.teams[index].inningInfo = []
        //        }
        //
        //        let userDefaults = UserDefaults.standard
        //        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.teams)
        //
        //        userDefaults.set(encodedData, forKey: "Teams")
        //        userDefaults.synchronize()
        //
        //        return
        
        
        //이닝 정의
        //1회 - 15회. 각 타격 기록지 3개씩 투수 기록지 1나씩 셋팅
        for i in 1...15 {
            let homeTeamInningInfo = InningInfo()
            let visitedTeamInningInfo = InningInfo()
            homeTeamInningInfo.number = i
            homeTeamInningInfo.kind = "BT"
            visitedTeamInningInfo.number = i
            visitedTeamInningInfo.kind = "ST"
            
            for j in 1...3 {
                let vHRecord : HRecordInfo = HRecordInfo()
                let hHRecord : HRecordInfo = HRecordInfo()
                
                vHRecord.number = String(j)
                visitedTeamInningInfo.hRecord.append(vHRecord)
                homeTeamInningInfo.hRecord.append(hHRecord)
            }
            
            let vPRecord : PRecordInfo = PRecordInfo()
            let hPRecord : PRecordInfo = PRecordInfo()
            
            visitedTeamInningInfo.pRecord.append(vPRecord)
            homeTeamInningInfo.pRecord.append(hPRecord)
            
            self.homeTeam.inningInfo.append(homeTeamInningInfo)
            self.visitedTeam.inningInfo.append(visitedTeamInningInfo)
        }
        
        //원정팀 이닝정보 정의
        //맨 처음은 1회
        self.currentInningInfo = self.visitedTeam.inningInfo[0]
        
        //이닝에 속한 기록지 정보 기본 셋팅
        for i in 0...2 {
            self.visitedTeam.inningInfo[0].hRecord[2 - i].number = self.visitedTeam.mainLineupInfo[i].number
            self.visitedTeam.inningInfo[0].hRecord[2 - i].name = self.visitedTeam.mainLineupInfo[i].name
            self.visitedTeam.inningInfo[0].hRecord[2 - i].memberNumber = self.visitedTeam.mainLineupInfo[i].memberNumber
        }
        
        //현재 기록지 선택
        self.currentHrecord = self.visitedTeam.inningInfo[0].hRecord[recordCount]
        
        //투수 정의
        //포지션 이름이 SP가 투수임.
        let homeTeamPitcherLineup = self.homeTeam.mainLineupInfo.first(where: { $0.positionName == "SP" })
        self.currentPLineup = homeTeamPitcherLineup!
        self.homeTeam.inningInfo[0].pRecord[0].name = (homeTeamPitcherLineup?.name)!
        self.homeTeam.inningInfo[0].pRecord[0].memberNumber = (homeTeamPitcherLineup?.memberNumber)!
        
        //전광판 Load
        self.lblDSVisitedTeamName.text = self.visitedTeam.name
        self.lblDSHomeTeamName.text = self.homeTeam.name
        
        self.isFirstBatter = true
        
        self.setBatterInfo()
        self.setPitcherInfo()
    }
    
    //화면 하단 타자 정보
    func setBatterInfo() {
        
        //현재 타자 정보
        self.lblBatterNumber.text = self.currentLineup.number
        self.lblBatterName.text = self.currentLineup.name
        self.lblBatterMemberNumber.text = self.currentLineup.memberNumber + "번"
        self.lblBatterTimeAtBat.text = String(self.currentLineup.timeAtBat)
        self.lblBatterHitCount.text = String(self.currentLineup.hittingCount)
        
        //다음 타자 정보
        if self.currentInningInfo.kind == "ST" {
            var nextIndex = self.visitedTeam.mainLineupInfo.index(where: { $0 == self.currentLineup })! + 1
            
            if nextIndex > 8 {
                nextIndex = 0
            }
            
            self.lblNextBatterName.text = self.visitedTeam.mainLineupInfo[nextIndex].name
            self.lblNextBatterMemberNumber.text = self.visitedTeam.mainLineupInfo[nextIndex].memberNumber + "번"
        }
        else {
            var nextIndex = self.homeTeam.mainLineupInfo.index(where: { $0 == self.currentLineup })! + 1
            
            if nextIndex > 8 {
                nextIndex = 0
            }
            self.lblNextBatterName.text = self.homeTeam.mainLineupInfo[nextIndex].name
            self.lblNextBatterMemberNumber.text = self.homeTeam.mainLineupInfo[nextIndex].memberNumber + "번"
        }
    }
    
    //화면 하단 투수 정보
    func setPitcherInfo() {
        self.lblPitcherName.text = self.currentPLineup.name
        self.lblPitcherMemberNumber.text = self.currentPLineup.memberNumber
        self.lblPitcherTotalCount.text = String(self.currentPLineup.pitcherTotalCount)
        self.lblPitcherHitCount.text = String(self.currentPLineup.pitcherHittingCount)
        self.lblPitcherBaseOnBallsCount.text = String(self.currentPLineup.pitcherBaseOnBallsCount)
        self.lblPitcherStrikeOutCount.text = String(self.currentPLineup.pitcherStrikeOutCount)
    }
    
    //포지션 번호 설정
    func positionMemberNumberSet(kind : String) {
        
        self.btnPositionSP.setTitle(getMemberNumberByPositionName(kind: kind, positionName: "SP"), for: .normal)
        self.btnPositionC.setTitle(getMemberNumberByPositionName(kind: kind, positionName: "C"), for: .normal)
        self.btnPosition1B.setTitle(getMemberNumberByPositionName(kind: kind, positionName: "1B"), for: .normal)
        self.btnPosition2B.setTitle(getMemberNumberByPositionName(kind: kind, positionName: "2B"), for: .normal)
        self.btnPositionSS.setTitle(getMemberNumberByPositionName(kind: kind, positionName: "SS"), for: .normal)
        self.btnPosition3B.setTitle(getMemberNumberByPositionName(kind: kind, positionName: "3B"), for: .normal)
        self.btnPositionLF.setTitle(getMemberNumberByPositionName(kind: kind, positionName: "LF"), for: .normal)
        self.btnPositionCF.setTitle(getMemberNumberByPositionName(kind: kind, positionName: "CF"), for: .normal)
        self.btnPositionRF.setTitle(getMemberNumberByPositionName(kind: kind, positionName: "RF"), for: .normal)
        
    }
    
    //포지션 번호 반환
    func getMemberNumberByPositionName(kind : String, positionName : String) -> String {
        var result : String = ""
        if kind == "H" {
            result = (self.homeTeam.mainLineupInfo.first(where : { $0.positionName == positionName })?.memberNumber)!
        }
        else {
            result = (self.visitedTeam.mainLineupInfo.first(where : { $0.positionName == positionName })?.memberNumber)!
        }
        
        return result
    }
    
    //포지션 이미지 설정
    func positionImgSet(isOn : Bool){
        
        var imgName : String = ""
        
        if isOn {
            imgName = "PV_position_on_btn.png"
        }
        else {
            imgName = "PV_position_off_btn.png"
        }
        self.btnPositionSP.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnPositionC.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnPosition1B.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnPosition2B.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnPositionSS.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnPosition3B.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnPositionLF.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnPositionCF.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnPositionRF.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        
    }
    //포지션 이미지 설정2-투수,포수
    func positionImgSet2(isOn : Bool){
        
        var imgName : String = ""
        
        if isOn {
            imgName = "PV_position_on_btn.png"
        }
        else {
            imgName = "PV_position_off_btn.png"
        }
        self.btnPositionSP.isEnabled = true
        self.btnPositionC.isEnabled = true
        self.btnPositionSP.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnPositionC.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.btnPosition1B.isEnabled = false
        self.btnPosition2B.isEnabled = false
        self.btnPosition3B.isEnabled = false
        self.btnPositionCF.isEnabled = false
        self.btnPositionLF.isEnabled = false
        self.btnPositionRF.isEnabled = false
        self.btnPositionSS.isEnabled = false
        
    }
    func positionImgSet3(isEnabled : Bool){
        
        if isEnabled==true {
            self.btnPositionSP.isEnabled = true
            self.btnPositionC.isEnabled = true
            self.btnPosition1B.isEnabled = true
            self.btnPosition2B.isEnabled = true
            self.btnPosition3B.isEnabled = true
            self.btnPositionCF.isEnabled = true
            self.btnPositionLF.isEnabled = true
            self.btnPositionRF.isEnabled = true
            self.btnPositionSS.isEnabled = true
        }
        else {
            self.btnPositionSP.isEnabled = false
            self.btnPositionC.isEnabled = false
            self.btnPosition1B.isEnabled = false
            self.btnPosition2B.isEnabled = false
            self.btnPosition3B.isEnabled = false
            self.btnPositionCF.isEnabled = false
            self.btnPositionLF.isEnabled = false
            self.btnPositionRF.isEnabled = false
            self.btnPositionSS.isEnabled = false
        }
    }
    //포지션 이미지 설정
    func positionImgSet4(isOn : Bool){
        
        var imgName : String = ""
        
        if isOn {
            imgName = "PV_position_on_btn.png"
        }
        else {
            imgName = "PV_position_off_btn.png"
        }
        switch sendd {
        case "1":
            self.btnPositionSP.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        case "2":
            self.btnPositionC.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        case "3":
            self.btnPosition1B.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        case "4":
            self.btnPosition2B.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        case "5":
            self.btnPositionSS.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        case "6":
            self.btnPosition3B.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        case "7":
            self.btnPositionLF.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        case "8":
            self.btnPositionCF.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        case "9":
            self.btnPositionRF.setBackgroundImage(UIImage(named: imgName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        default:
            return
        }
    }
    
    //투구 팝업
    @IBAction func clickPitcher(_ sender: AnyObject) {
        
        let pitchingMenuViewController = storyboard?.instantiateViewController(withIdentifier: "pitchingmenu") as! PitchingMenuViewController
        pitchingMenuViewController.pitcherCompleteDelegate = self;
        pitchingMenuViewController.batterCompleteDelegate = self;
        pitchingMenuViewController.preferredContentSize = CGSize(width: 320, height: 380)
        pitchingMenuViewController.hRecord = self.currentHrecord
        pitchingMenuViewController.pRecord = self.currentPrecord
        pitchingMenuViewController.pitcherScoreBoardInfo = self.pitcherScoreBoardInfo
        pitchingMenuViewController.isRunner1 = self.isOneRunner
        pitchingMenuViewController.modalPresentationStyle = .popover
        
        if let popoverController = pitchingMenuViewController.popoverPresentationController {
            popoverController.sourceView = sender as! UIView
            popoverController.sourceRect = sender.bounds
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
        }
        present(pitchingMenuViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func clickCancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //투수 포지션 Click
    @IBAction func clickPositionSP(_ sender: AnyObject) {
        
        //아웃카운트 체크
        if self.pitcherScoreBoardInfo.outCount == 3 {
            self.checkThreeOut()
            return
        }

        
        
        self.setPositionClickInfo(homeRecordText: PositionNumber.SP.rawValue)
        
        if self.positionClickState == "S" {
            self.setPaperRecording(recordingByThing: .Batter)
            self.ballAnimation(positionButton: self.btnPositionSP)
            positionImgSet3(isEnabled: false)
            positionImgSet(isOn : false)
        }else if self.positionClickState == "U" {
            sendd = PositionNumber.SP.rawValue
            ballXY = PositionNumber.SP.rawValue
            self.ballAnimation(positionButton: self.btnPositionSP)
            self.ivBall.alpha = 1
            positionImgSet(isOn: true)
            positionImgSet4(isOn: false)
            self.btnPosition1B.isEnabled = true
            self.btnPosition2B.isEnabled = true
            self.btnPosition3B.isEnabled = true
            self.btnPositionCF.isEnabled = true
            self.btnPositionLF.isEnabled = true
            self.btnPositionRF.isEnabled = true
            self.btnPositionSS.isEnabled = true
            if runnerPosition1 == .OneRunner{
                oneHalfRunnerHRecord.oneRecordText = "\(PositionNumber.SP.rawValue)"
                oneRunnerHRecord.oneRecordText = "\(PositionNumber.SP.rawValue)"
            }else if runnerPosition1 == .TwoRunner{
                twoHalfRunnerHRecord.twoRecordText = "\(PositionNumber.SP.rawValue)"
                twoRunnerHRecord.twoRecordText = "\(PositionNumber.SP.rawValue)"
            }else
                if runnerPosition1 == .ThreeRunner{
                    threeHalfRunnerHRecord.threeRecordText = "\(PositionNumber.SP.rawValue)"
                    threeRunnerHRecord.threeRecordText = "\(PositionNumber.SP.rawValue)"
                }else{}
            
        }else if self.positionClickState == "F" {
            sendd = PositionNumber.SP.rawValue
//            self.addActionRunnerState = AddActionRunnerState.StealAction
            self.runnerOut(sender: sender)
        }
        else {
            //메인 메뉴를 띄워야 한다
            self.changeDefenderPlayer(sender : sender)
        }
    }
    
    @IBAction func clickPositionC(_ sender: AnyObject) {
        
        //아웃카운트 체크
        if self.pitcherScoreBoardInfo.outCount == 3 {
            self.checkThreeOut()
            return
        }
        
        self.setPositionClickInfo(homeRecordText: PositionNumber.C.rawValue)
        
        if self.positionClickState == "S" {
            print("S로 진입")
            self.setPaperRecording(recordingByThing: .Batter)
            self.ballAnimation(positionButton: self.btnPositionC)
            positionImgSet3(isEnabled: false)
            positionImgSet(isOn : false)
        }
        else if self.positionClickState == "U" {
            print("U로 진입")
            self.ballAnimation(positionButton: self.btnPositionC)
            self.ivBall.alpha = 1
            positionImgSet(isOn: true)
            positionImgSet4(isOn: false)
            self.btnPosition1B.isEnabled = true
            self.btnPosition2B.isEnabled = true
            self.btnPosition3B.isEnabled = true
            self.btnPositionCF.isEnabled = true
            self.btnPositionLF.isEnabled = true
            self.btnPositionRF.isEnabled = true
            self.btnPositionSS.isEnabled = true
            ballXY = PositionNumber.C.rawValue
            if runnerPosition1 == .OneRunner{
                oneRunnerHRecord.oneRecordText = "\(PositionNumber.C.rawValue)"
            }
            else if runnerPosition1 == .TwoRunner{
                twoRunnerHRecord.twoRecordText = "\(PositionNumber.C.rawValue)"
            }
            else if runnerPosition1 == .ThreeRunner{
                    threeRunnerHRecord.threeRecordText = "\(PositionNumber.C.rawValue)"
            }
            else{}
            print("ivBall : \(ivBall.isHidden)")
        }
        else if self.positionClickState == "F" {
            print("F로 진입")
            sendd = PositionNumber.C.rawValue
//            self.addActionRunnerState = AddActionRunnerState.StealAction
            self.runnerOut(sender: sender)
        }
        else {
            //메인 메뉴를 띄워야 한다
            self.changeDefenderPlayer(sender : sender)
        }
    }
    
    //타격 완료시 정보 설정
    func setPaperRecording(recordingByThing : RecordingByThing) {
        
        let paperRecording : PaperRecording = PaperRecording(currentInningInfo : self.currentInningInfo, currentLineup : self.currentLineup, currentHrecord : self.currentHrecord, ivBatterRecord1 : self.ivBatterRecord1, ivBatterRecord2 : self.ivBatterRecord2, ivBatterRecord3 : self.ivBatterRecord3, ivBatterRecord4 : self.ivBatterRecord4, ivBatterRecord5 : self.ivBatterRecord5, lblBatterRecord1 : self.lblBatterRecord1, lblBatterRecord2 : self.lblBatterRecord2, lblBatterRecord3 : self.lblBatterRecord3, lblBatterRecord4 : self.lblBatterRecord4, lblPositionMessage : self.lblPositionMessage)
        
        //기록지 작성
        paperRecording.setHittingDefine()
        
        //애니메이션 실행
        self.runnerAnimation(recordState: self.currentHrecord.hittingRecord)
        
        //        self.runnerAnimation(recordState: self.currentHrecord.hittingRecord)
        
        //타격완료(투구 정보란 입력)
        if recordingByThing == .Batter {
            self.currentHrecord.pitcherRecord.append(RecordState.PitchingEnd)
            self.currentHrecord.pitcherRecordImage.append(RecordState.PitchingEnd.rawValue)
            self.PitcherCompletedPopover()
            
        }
        
        //투구 정보 초기화
        self.reSetPitcherStrikeBall()
        
    }
    
    //주자 추가 기록 완료시 정보 설정
    func setRunnerPaperRecording(runnerPosition : RunnerPosition, record : HRecordInfo) {
        
        var runnerHRecord : HRecordInfo = HRecordInfo()
        
        if runnerPosition == RunnerPosition.OneRunner {
            //연속 진루 일 경우 루에 따라 이미지 변경
            if record.oneRecord == RecordState.AdvanceArrow {
                record.oneRecord = RecordState.TwoAdvanceArrows
                record.oneRecordImage = RecordState.TwoAdvanceArrows.rawValue
            }
            self.oneRunnerHRecord = record
            runnerHRecord = self.oneRunnerHRecord
        }
        else if runnerPosition == RunnerPosition.TwoRunner {
            //연속 진루 일 경우 루에 따라 이미지 변경
            if record.twoRecord == RecordState.AdvanceArrow {
                record.twoRecord = RecordState.ThreeAdvanceArrows
                record.twoRecordImage = RecordState.ThreeAdvanceArrows.rawValue
            }
            self.twoRunnerHRecord = record
            runnerHRecord = self.twoRunnerHRecord
        }
        else if runnerPosition == RunnerPosition.ThreeRunner {
            //연속 진루 일 경우 루에 따라 이미지 변경
            if record.threeRecord == RecordState.AdvanceArrow {
                record.threeRecord = RecordState.HomeAdvanceArrows
                record.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
            }
            
//            if addActionState == .oneAction {
//                runnerHRecord = self.tempRunnerHRecord
//            }
//            else {
                self.threeRunnerHRecord = record
                runnerHRecord = self.threeRunnerHRecord
//            }
            
        }
        
        if self.currentHrecord.number == record.number {
            let paperRecording : PaperRecording = PaperRecording(currentInningInfo : self.currentInningInfo, currentLineup : self.currentLineup, currentHrecord : runnerHRecord, ivBatterRecord1 : self.ivBatterRecord1, ivBatterRecord2 : self.ivBatterRecord2, ivBatterRecord3 : self.ivBatterRecord3, ivBatterRecord4 : self.ivBatterRecord4, ivBatterRecord5 : self.ivBatterRecord5, lblBatterRecord1 : self.lblBatterRecord1, lblBatterRecord2 : self.lblBatterRecord2, lblBatterRecord3 : self.lblBatterRecord3, lblBatterRecord4 : self.lblBatterRecord4, lblPositionMessage : self.lblPositionMessage)
            
            paperRecording.runnerPosition = runnerPosition
            paperRecording.setRunnerRecordingDefine()
        }
        else {
            
//            let index = self.currentInningInfo.hRecord.index(where: { $0.number == record.number })
//            if index != nil {
//                let indexPath = IndexPath(item: index!, section: 0)
//                self.recordTableView.reloadRows(at: [indexPath], with: .top)
//            }
        }
        
    }
    
    //추가된 주자들 기록지를 새로 고침 한다.
    func setRunnerPaperRecordingByBatter() {
        //안타?
        //첫 타자 패스(메인에서 올라옴)
        if self.isFirstBatter == true {
            return
        }
        
        for index in 0...self.currentInningInfo.hRecord.count - 1 {
            if self.currentInningInfo.hRecord[index].isChanged == true {
                var indexNumber = 0
                if self.currentInningInfo.hRecord.count > 3 {
                    indexNumber = index - 1
                }
                else{
                    indexNumber = index
                }
                
                let indexPath = IndexPath(item: indexNumber, section: 0)
                self.recordTableView.beginUpdates()
                self.recordTableView.reloadRows(at: [indexPath], with: .automatic)
                self.recordTableView.endUpdates()
                
                //                self.currentInningInfo.hRecord[index].isChanged = false
            }
}
/*
        var index : [Int] = [Int]()
        
        if self.recordCount < 0 {
            if let indexValue = self.currentInningInfo.hRecord.index( where : { $0.number == self.threeRunnerHRecord.number } ) {
                index.append(indexValue - 1)
            }
            if let indexValue = self.currentInningInfo.hRecord.index( where : { $0.number == self.twoRunnerHRecord.number } ) {
                index.append(indexValue - 1)
            }
            
            if let indexValue = self.currentInningInfo.hRecord.index( where : { $0.number == self.oneRunnerHRecord.number } ) {
                index.append(indexValue - 1)
            }
        }
        else{
            if let indexValue = self.currentInningInfo.hRecord.index( where : { $0.number == self.threeRunnerHRecord.number } ) {
                index.append(indexValue)
            }
            if let indexValue = self.currentInningInfo.hRecord.index( where : { $0.number == self.twoRunnerHRecord.number } ) {
                index.append(indexValue)
            }
            
            if let indexValue = self.currentInningInfo.hRecord.index( where : { $0.number == self.oneRunnerHRecord.number } ) {
                index.append(indexValue)
            }
        }
        
        */
        /*
         if self.runnerState.rawValue.contains("H") == false {
         if index.count > 0 {
         
         if let indexValue = self.currentInningInfo.hRecord.index( where : { $0.number == self.currentHrecord.number } ) {
         if self.recordCount < 0 {
         index = index.filter { $0 != index.index(of: indexValue - 1) }
         } else {
         index = index.filter { $0 != index.index(of: indexValue) }
         }
         
         }
         }
         }
         */
        /*
         1. Done상태에서
         - 경우 1) 홈럼 -> 1안타 -> Done -> 주자 도루 -> 연속진루 -> Done
         */
        /*
        if index.count > 0 {
            if let indexValue = self.currentInningInfo.hRecord.index( where : { $0.number == self.currentHrecord.number } ) {
                if self.recordCount < 0 {
                    
                    if let findeIndex = index.index(of: indexValue - 1) {
                        index.remove(at: findeIndex)
                    }
                    
                } else {
                    if let findeIndex = index.index(of: indexValue) {
                        index.remove(at: findeIndex)
                    }
                }
            }
        }
        
        if index.count > 0 {
            for number in 0...index.count - 1 {
                let indexNumber = index[number]
                let indexPath = IndexPath(item: indexNumber, section: 0)
                self.recordTableView.beginUpdates()
                self.recordTableView.reloadRows(at: [indexPath], with: .automatic)
                self.recordTableView.endUpdates()
            }
        }
 */
    }
    
    // setRunnerPaperRecordingByBatter호출시 index.removeLast 호출 제외 시키기 : 우선 사용 안함
    func removeIndexInRecordState(recordState : RecordState) -> Bool {
        return true
    }
    
    //주자들 포지션 초기화
    func initializeRunnerPosition() {
        
        self.btnRunner1.frame.origin.x = 613
        self.btnRunner1.frame.origin.y = 619
        self.btnRunner2.frame.origin.x = 743
        self.btnRunner2.frame.origin.y = 387
        self.btnRunner3.frame.origin.x = 613
        self.btnRunner3.frame.origin.y = 272
        
    }
    
    //애미메이션 실행
    func runnerAnimation(recordState : RecordState) {
        
        let runnerAnimation : RunnerAnimation = RunnerAnimation(runner1: self.btnRunner1, runner2: self.btnRunner2, runner3: self.btnRunner3, runnerH_1 : self.btnRunnerH_1, runner1_2 : self.btnRunner1_2, runner2_3 : self.btnRunner2_3, runner3_H : self.btnRunner3_H, currentHRecord: self.currentHrecord, oneRunnerHRecord : self.oneRunnerHRecord, twoRunnerHRecord : self.twoRunnerHRecord, threeRunnerHRecord : self.threeRunnerHRecord, homeRunnerHRecordList: self.homeRunnerHRecordList, runnerState : self.runnerState, addActionState : self.addActionState)
        
        runnerAnimation.completeDelegate = self
        runnerAnimation.RunnerAnimation(recordState: self.currentHrecord.hittingRecord)
        
    }
    
    //애니메이션 완료
    func AnimationComplete(oneRunnerHRecord : HRecordInfo, twoRunnerHRecord : HRecordInfo, threeRunnerHRecord : HRecordInfo, homeRunnerHRecordList : [HRecordInfo], runnerState : RunnerState, addActionState : AddActionState, runnerPosition: RunnerPosition) {
        
        //완료 버튼 보이기
        if runnerState.rawValue.contains("H") == false {
            self.btnDone.isHidden = false
        }
        
        self.oneRunnerHRecord = oneRunnerHRecord
        self.twoRunnerHRecord = twoRunnerHRecord
        self.threeRunnerHRecord = threeRunnerHRecord
        self.homeRunnerHRecordList = homeRunnerHRecordList
        
        self.runnerState = runnerState
        self.addActionState = addActionState
        
        //루상 주자 View
        if self.addActionState == .Default {
            //self.setRunnerView()
            //주자들 기록
            self.setRunnerPaperRecordingByBatter()
        }
        else {
            self.addActionRunnerState = .BatterAction
            //주자들 기록
            self.setRunnerPaperRecordingByBatter()
        }
        
        //홈 기록
        self.recordHomein()
        
        //임시 기록지 초기화
        self.tempRunnerHRecord = HRecordInfo()
        
        
        print("애니메이션 완료후 hRecord : \(self.currentInningInfo.hRecord.count)")
    }
    
    func AddActionAnimationComplete(oneRunnerHRecord : HRecordInfo, twoRunnerHRecord : HRecordInfo, threeRunnerHRecord : HRecordInfo, homeRunnerHRecordList : [HRecordInfo],tempRunnerHRecord : HRecordInfo, oneHalfRunnerHRecord : HRecordInfo, twoHalfRunnerHRecord : HRecordInfo, threeHalfRunnerHRecord : HRecordInfo, runnerState : RunnerState, addActionState : AddActionState, runnerPosition: RunnerPosition) {
        
        self.oneRunnerHRecord = oneRunnerHRecord
        self.twoRunnerHRecord = twoRunnerHRecord
        self.threeRunnerHRecord = threeRunnerHRecord
        self.homeRunnerHRecordList = homeRunnerHRecordList
        self.tempRunnerHRecord = tempRunnerHRecord
        
        self.oneHalfRunnerHRecord = oneHalfRunnerHRecord
        self.twoHalfRunnerHRecord = twoHalfRunnerHRecord
        self.threeHalfRunnerHRecord = threeHalfRunnerHRecord
        
        self.runnerState = runnerState
        self.addActionState = addActionState
        
      //  self.addActionRunnerState = .BatterAction
        
        self.setRunnerPaperRecordingByBatter()
        //홈 기록
        self.recordHomein()
    }
    
    //홈인한 정보 설정
    func recordHomein() {
        
        if self.homeRunnerHRecordList.count > 0 {
            
            for index in 0...self.homeRunnerHRecordList.count - 1 {
                
                //전광판 점수 기록
                if self.currentInningInfo.kind == "ST" {
                    self.lblDSVisitedTeamRuns.text = String(Int(self.lblDSVisitedTeamRuns.text!)! + 1)
                }
                else {
                    self.lblDSHomeTeamRuns.text = String(Int(self.lblDSHomeTeamRuns.text!)! + 1)
                }
                //이닝 전광판
                self.currentInningLabel.text = String(Int(self.currentInningLabel.text!)! + 1)
                
                self.homeRunnerHRecordList[index].centerRecord = RecordState.ScoreRunOne
                self.homeRunnerHRecordList[index].centerRecordImage = RecordState.ScoreRunOne.rawValue
                
                //홈인한 레코드 리플레쉬
                if let indexValue = self.currentInningInfo.hRecord.index( where : { $0.number == self.homeRunnerHRecordList[index].number } ) {
                    
                    var indexNumber = indexValue
                    
                    if self.recordCount < 0 {
                        //상태가 Done 전이라면 아직 TableView에 추가 되지 않았기 때문에 -1을 한다
                        if self.actionPopState == .BeforCompleteHoldRunner || self.actionPopState == .RunnerStop{
                            indexNumber = indexNumber - 1
                        }
                    }
                    print("//홈인한 레코드 리플레쉬 : \(indexNumber)")
                    let indexPath = IndexPath(item: indexNumber, section: 0)
                    self.recordTableView.beginUpdates()
                    self.recordTableView.reloadRows(at: [indexPath], with: .automatic)
                    self.recordTableView.endUpdates()
                }
            }
        }
        
        //타점정보
        self.currentLineup.runBattedIn += self.homeRunnerHRecordList.count
        
        //홈인 기록 다 하고 나면 초기화
        self.homeRunnerHRecordList.removeAll()
        
        if self.runnerState == .Default {
            if self.addActionRunnerState != .StealAction{
                self.actionPopState = .Default
                self.clickDone((Any).self)
            }else{
                ballInitailize()
                //11111111
            }
        }
    }
    //도루상태 업
    func getStealState(rState : RecordState) -> RecordState {
        switch rState {
        case .StealImage:
            return .DoubleStealImage
        case .DoubleStealImage:
            return .TripleStealImage
        default:
            return .StealImage
        }
    }
    //각 루에 도착한 주자들의 추가 기록
    func HoldRunnerCompletePopover(runnerPosition : RunnerPosition, record : HRecordInfo, addActionRunnerState : AddActionRunnerState, recordState : RecordState) {
        
        //완료 상태
        if self.statusDone == .Default {
            //완료 상태가 Default일 경우에만 주자 완료 상태로 바뀐다
            self.statusDone = .RunnerDone
        }
        
        positionImgSet3(isEnabled: false)
        var finalRecordState = recordState
    
        if finalRecordState == .ThroughPass{
            self.positionImgSet(isOn: true)
            self.btnPositionSP.isEnabled = true
            self.btnPositionC.isEnabled = true
            self.btnPosition1B.isEnabled = true
            self.btnPosition2B.isEnabled = true
            self.btnPositionSS.isEnabled = true
            self.btnPosition3B.isEnabled = true
            self.btnPositionLF.isEnabled = true
            self.btnPositionCF.isEnabled = true
            self.btnPositionRF.isEnabled = true
            switch sendd {
            case "1":
                self.ballAnimation(positionButton: self.btnPositionSP)
                self.btnPositionSP.isEnabled = false
                self.positionImgSet4(isOn: false)
            case "2":
                self.ballAnimation(positionButton: self.btnPositionC)
                self.btnPositionC.isEnabled = false
                self.positionImgSet4(isOn: false)
            case "3":
                self.ballAnimation(positionButton: self.btnPosition1B)
                self.btnPosition1B.isEnabled = false
                self.positionImgSet4(isOn: false)
            case "4":
                self.ballAnimation(positionButton: self.btnPosition2B)
                self.btnPosition2B.isEnabled = false
                self.positionImgSet4(isOn: false)
            case "5":
                self.ballAnimation(positionButton: self.btnPositionSS)
                self.btnPositionSS.isEnabled = false
                self.positionImgSet4(isOn: false)
            case "6":
                self.ballAnimation(positionButton: self.btnPosition3B)
                self.btnPosition3B.isEnabled = false
                self.positionImgSet4(isOn: false)
            case "7":
                self.ballAnimation(positionButton: self.btnPositionLF)
                self.btnPositionLF.isEnabled = false
                self.positionImgSet4(isOn: false)
            case "8":
                self.ballAnimation(positionButton: self.btnPositionCF)
                self.btnPositionCF.isEnabled = false
                self.positionImgSet4(isOn: false)
            case "9":
                self.ballAnimation(positionButton: self.btnPositionRF)
                self.btnPositionRF.isEnabled = false
                self.positionImgSet4(isOn: false)
            default:
                break
            }
            if record.threeRecord == .StealError{
                record.threeRecordText += "-\(sendd)"
            }else if record.twoRecord == .StealError{
                record.twoRecordText += "-\(sendd)"
            }else if record.oneRecord == .StealError{
                record.oneRecordText += "-\(sendd)"
            }else{}
            ballXY = sendd
//            tagOutRecord = record.oneRecordText
        }
        else if finalRecordState == .TagOut{
            positionImgSet3(isEnabled: false)
            switch sendd {
            case "1":
                self.ballAnimation(positionButton: self.btnPositionSP)
            case "2":
                self.ballAnimation(positionButton: self.btnPositionC)
            case "3":
                self.ballAnimation(positionButton: self.btnPosition1B)
            case "4":
                self.ballAnimation(positionButton: self.btnPosition2B)
            case "5":
                self.ballAnimation(positionButton: self.btnPositionSS)
            case "6":
                self.ballAnimation(positionButton: self.btnPosition3B)
            case "7":
                self.ballAnimation(positionButton: self.btnPositionLF)
            case "8":
                self.ballAnimation(positionButton: self.btnPositionCF)
            case "9":
                self.ballAnimation(positionButton: self.btnPositionRF)
            default:
                break
            }
            if record.threeRecord == .StealError{
                record.threeRecordText += "-\(sendd)"
                switch pitcherScoreBoardInfo.outCount {
                case 0:
                    record.centerRecord = RecordState.OutCountOne
                    record.centerRecordImage = RecordState.OutCountOne.rawValue
                case 1:
                    record.centerRecord = RecordState.OutCountTwo
                    record.centerRecordImage = RecordState.OutCountTwo.rawValue
                case 2:
                    record.centerRecord = RecordState.OutCountThree
                    record.centerRecordImage = RecordState.OutCountThree.rawValue
                default: break
                    
                }
            }else if record.twoRecord == .StealError{
                record.twoRecordText += "-\(sendd)"
                switch pitcherScoreBoardInfo.outCount {
                case 0:
                    record.centerRecord = RecordState.OutCountOne
                    record.centerRecordImage = RecordState.OutCountOne.rawValue
                case 1:
                    record.centerRecord = RecordState.OutCountTwo
                    record.centerRecordImage = RecordState.OutCountTwo.rawValue
                case 2:
                    record.centerRecord = RecordState.OutCountThree
                    record.centerRecordImage = RecordState.OutCountThree.rawValue
                default: break
                    
                }
            }else if record.oneRecord == .StealError{
                record.oneRecordText += "-\(sendd)"
                switch pitcherScoreBoardInfo.outCount {
                case 0:
                    record.centerRecord = RecordState.OutCountOne
                    record.centerRecordImage = RecordState.OutCountOne.rawValue
                case 1:
                    record.centerRecord = RecordState.OutCountTwo
                    record.centerRecordImage = RecordState.OutCountTwo.rawValue
                case 2:
                    record.centerRecord = RecordState.OutCountThree
                    record.centerRecordImage = RecordState.OutCountThree.rawValue
                default: break
                    
                }
            }else{}
            self.pitcherScoreBoardInfo.outCount += 1
            self.pitcherDisplayChange(isReset: false)
            print(self.pitcherScoreBoardInfo.outCount)
//            positionImgSet2(isOn: true)
        }
        
        //도루 상태업
        if finalRecordState == .StealImage || finalRecordState == .TagOut || finalRecordState == .AdvanceArrow || finalRecordState == .NotAdvance{
            if finalRecordState == .StealImage {
                if self.stealState == .oneSteal {
                    finalRecordState = getStealState(rState: .StealImage)
                    self.stealState = .twoSteal
                }
                else if self.stealState == .twoSteal {
                    finalRecordState = getStealState(rState: .DoubleStealImage)
                    self.stealState = .Default
                }
                else if self.stealState == .Default {
                    finalRecordState = getStealState(rState: .Default)
                    self.stealState = .oneSteal
                }
                
                //도루정보
                let findLineup : Lineup = self.currentTeam.mainLineupInfo.first(where : { $0.memberNumber == record.memberNumber })!
                findLineup.stolenBases += 1
            }
            
            self.actionPopState = .BeforCompleteHoldRunner
            self.btnPitcher.isHidden = true
            self.btnDone.isHidden = true
            self.lblPositionMessage.isHidden = false
            self.positionImgSet(isOn: false)
            if self.runnerState.rawValue.contains("H") == true {
                self.lblPositionMessage.text = "추가기록을 입력 해주세요."
            }
            else{
                self.lblPositionMessage.text = "대기상태의\n주자기록을 입력 해주세요."
            }
            //
            
            let holdRunnerAnimation : HoldRunnerAnimation = HoldRunnerAnimation(runner1: self.btnRunner1, runner2: self.btnRunner2, runner3: self.btnRunner3, runnerH_1 : self.btnRunnerH_1, runner1_2 : self.btnRunner1_2, runner2_3 : self.btnRunner2_3, runner3_H : self.btnRunner3_H, currentHRecord: self.currentHrecord, oneRunnerHRecord : self.oneRunnerHRecord, twoRunnerHRecord : self.twoRunnerHRecord, threeRunnerHRecord : self.threeRunnerHRecord, homeRunnerHRecordList: self.homeRunnerHRecordList, tempRunnerHRecord : self.tempRunnerHRecord, oneHalfRunnerHRecord : self.oneHalfRunnerHRecord, twoHalfRunnerHRecord : self.twoHalfRunnerHRecord, threeHalfRunnerHRecord : self.threeHalfRunnerHRecord, runnerState : self.runnerState, runnerPosition : runnerPosition, recordState : finalRecordState, addActionState : self.addActionState)
            
            holdRunnerAnimation.completeDelegate = self
            self.addActionRunnerState = addActionRunnerState
            holdRunnerAnimation.RunnerAnimation()
                if runnerState != .RunnerState1 || runnerState != .RunnerState2 || runnerState != .RunnerState3 || runnerState != .RunnerState4 || runnerState != .RunnerState5 || runnerState != .RunnerState6 || runnerState != .RunnerState7{
                    UIView.animate(withDuration: 1.0, animations: ({
                        self.ivBall.alpha  = 0;
                    }))
                }
            //주자 추가 기록 완료시 기록지에 기록
            setRunnerPaperRecording(runnerPosition: runnerPosition, record : record)
            
    //        self.recordHomein()
    }
        else if finalRecordState == .StealError {
            runnerPosition1 = runnerPosition
            self.hRecord = record
//            self.statusDone = .RunnerDone		//  "타자완료"
//            
//            
//            
//            //타격 종료 일 경우 주자들의 추가 입력 가능하게 변경한다.
//            self.actionPopState = .RunnerStop		//"미완성상태"
//            self.addActionRunnerState = AddActionRunnerState.StealAction		//"타자에의한"
            self.setFailRecord()
        }
        
        if addActionRunnerState == .runnerAction || addActionRunnerState == .StealAction{
            self.addActionRunnerState = addActionRunnerState
        }
    }
    
    //중가에 멈춰서 추가 기록된 주자들 기록
    func BaseRunnerCompletePopover(runnerPosition : RunnerPosition, record : HRecordInfo, addActionRunnerState : AddActionRunnerState, recordState : RecordState) {
        
        let baseRunnerAnimation : BaseRunnerAnimation = BaseRunnerAnimation(runner1: self.btnRunner1, runner2: self.btnRunner2, runner3: self.btnRunner3, runnerH_1 : self.btnRunnerH_1, runner1_2 : self.btnRunner1_2, runner2_3 : self.btnRunner2_3, runner3_H : self.btnRunner3_H, currentHRecord: self.currentHrecord, oneRunnerHRecord : self.oneRunnerHRecord, twoRunnerHRecord : self.twoRunnerHRecord, threeRunnerHRecord : self.threeRunnerHRecord, homeRunnerHRecordList: self.homeRunnerHRecordList, tempRunnerHRecord : self.tempRunnerHRecord, oneHalfRunnerHRecord : self.oneHalfRunnerHRecord, twoHalfRunnerHRecord : self.twoHalfRunnerHRecord, threeHalfRunnerHRecord : self.threeHalfRunnerHRecord, runnerState : self.runnerState, runnerPosition : runnerPosition, recordState : recordState, addActionState : self.addActionState)
        
        baseRunnerAnimation.completeDelegate = self
        self.addActionRunnerState = addActionRunnerState
        baseRunnerAnimation.RunnerAnimation(hittingRecord: self.currentHrecord.hittingRecord)
        
        //주자 추가 기록 완료시 기록지에 기록
        setRunnerPaperRecording(runnerPosition: runnerPosition, record : record)
        
        self.recordHomein()
        
    }
    
    //선수 교체 완료
    func ChangeRunnerCompletePopover(runnerPosition : RunnerPosition, record : HRecordInfo, addActionRunnerState : AddActionRunnerState) {
        
        
    }
    
    //주자 메인 메뉴 완료
    func MainRunnerMenuCompletePopover(runnerPosition : RunnerPosition, record : HRecordInfo, addActionRunnerState : AddActionRunnerState) {
        
        
    }
    
    //1루 주자 추가 기록
    @IBAction func clickRunner1(_ sender: AnyObject) {
        
        //추가 기록
        if self.actionPopState == .BeforCompleteHoldRunner || self.actionPopState == .RunnerStop {
            //연속진루
            let runnerRecordMenuViewController = storyboard?.instantiateViewController(withIdentifier: "runnermenu") as! RunnerRecordMenuViewController
            runnerRecordMenuViewController.runnerCompleteDelegate = self;
            runnerRecordMenuViewController.hRecord = self.oneRunnerHRecord;
            runnerRecordMenuViewController.addActionRunnerSate = self.addActionRunnerState
            runnerRecordMenuViewController.isRunning = self.isTwoRunner
            runnerRecordMenuViewController.runnerState = self.runnerState
            runnerRecordMenuViewController.runnerPosition = RunnerPosition.OneRunner
            runnerRecordMenuViewController.preferredContentSize = CGSize(width: 300, height: 280)
            runnerRecordMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = runnerRecordMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(runnerRecordMenuViewController, animated: true, completion: nil)
        }
        else if self.actionPopState == .CompleteHoldRunner {
            //주자메인메뉴(도루, 폭투등)
            let runnerMenuViewController = storyboard?.instantiateViewController(withIdentifier: "mainrunnermenu") as! RunnerMenuViewController
            runnerMenuViewController.changeRunnerCompleteDelegate = self
            runnerMenuViewController.mainRunnerMenuCompleteDelegate = self
            runnerMenuViewController.holdRunnerComplete = self
            runnerMenuViewController.hRecord = self.oneRunnerHRecord;
            runnerMenuViewController.currentHRecord = self.currentHrecord
            runnerMenuViewController.runnerPosition = RunnerPosition.OneRunner
            runnerMenuViewController.currentInningInfo = self.currentInningInfo
            runnerMenuViewController.currentLineup = self.currentLineup
            runnerMenuViewController.addActionRunnerState = self.addActionRunnerState
            if self.currentInningInfo.kind == "ST" {
                runnerMenuViewController.teamKind = self.visitedTeam.kind
            }
            else {
                runnerMenuViewController.teamKind = self.homeTeam.kind
            }
            runnerMenuViewController.preferredContentSize = CGSize(width: 200, height: 208)
            runnerMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = runnerMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(runnerMenuViewController, animated: true, completion: nil)
        }
    }
    
    //2루 주자 추가 기록
    @IBAction func clickRunner2(_ sender: AnyObject) {
        //추가 기록
        if self.actionPopState == .BeforCompleteHoldRunner || self.actionPopState == .RunnerStop {
            let runnerRecordMenuViewController = storyboard?.instantiateViewController(withIdentifier: "runnermenu") as! RunnerRecordMenuViewController
            runnerRecordMenuViewController.runnerCompleteDelegate = self;
            runnerRecordMenuViewController.hRecord = self.twoRunnerHRecord;
            runnerRecordMenuViewController.addActionRunnerSate = self.addActionRunnerState
            runnerRecordMenuViewController.isRunning = self.isThreeRunner
            runnerRecordMenuViewController.runnerState = self.runnerState
            runnerRecordMenuViewController.runnerPosition = RunnerPosition.TwoRunner
            runnerRecordMenuViewController.preferredContentSize = CGSize(width: 300, height: 280)
            runnerRecordMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = runnerRecordMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(runnerRecordMenuViewController, animated: true, completion: nil)
        }
        else if self.actionPopState == .CompleteHoldRunner{
            //도루, 폭투등
            let runnerMenuViewController = storyboard?.instantiateViewController(withIdentifier: "mainrunnermenu") as! RunnerMenuViewController
            runnerMenuViewController.changeRunnerCompleteDelegate = self
            runnerMenuViewController.mainRunnerMenuCompleteDelegate = self
            runnerMenuViewController.holdRunnerComplete = self
            runnerMenuViewController.hRecord = self.twoRunnerHRecord;
            runnerMenuViewController.currentHRecord = self.currentHrecord
            runnerMenuViewController.runnerPosition = RunnerPosition.TwoRunner
            runnerMenuViewController.currentInningInfo = self.currentInningInfo
            runnerMenuViewController.currentLineup = self.currentLineup
            if self.currentInningInfo.kind == "ST" {
                runnerMenuViewController.teamKind = self.visitedTeam.kind
            }
            else {
                runnerMenuViewController.teamKind = self.homeTeam.kind
            }
            runnerMenuViewController.preferredContentSize = CGSize(width: 200, height: 208)
            runnerMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = runnerMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(runnerMenuViewController, animated: true, completion: nil)
        }
    }
    
    //3루 주자 추가 기록
    @IBAction func clickRunner3(_ sender: AnyObject) {
        //추가 기록
        if self.actionPopState == .BeforCompleteHoldRunner || self.actionPopState == .RunnerStop {
            let runnerRecordMenuViewController = storyboard?.instantiateViewController(withIdentifier: "runnermenu") as! RunnerRecordMenuViewController
            runnerRecordMenuViewController.addActionRunnerSate = self.addActionRunnerState
            runnerRecordMenuViewController.runnerState = self.runnerState
            runnerRecordMenuViewController.runnerCompleteDelegate = self;
            runnerRecordMenuViewController.hRecord = self.threeRunnerHRecord;
            runnerRecordMenuViewController.isRunning = false//?
            runnerRecordMenuViewController.runnerPosition = RunnerPosition.ThreeRunner
            runnerRecordMenuViewController.preferredContentSize = CGSize(width: 300, height: 280)
            runnerRecordMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = runnerRecordMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(runnerRecordMenuViewController, animated: true, completion: nil)
        }
        else if self.actionPopState == .CompleteHoldRunner {
            //주자 교체
            let runnerMenuViewController = storyboard?.instantiateViewController(withIdentifier: "mainrunnermenu") as! RunnerMenuViewController
            runnerMenuViewController.changeRunnerCompleteDelegate = self
            runnerMenuViewController.mainRunnerMenuCompleteDelegate = self
            runnerMenuViewController.holdRunnerComplete = self
            runnerMenuViewController.currentHRecord = self.currentHrecord
            runnerMenuViewController.hRecord = self.threeRunnerHRecord;
            runnerMenuViewController.runnerPosition = RunnerPosition.ThreeRunner
            runnerMenuViewController.currentInningInfo = self.currentInningInfo
            runnerMenuViewController.currentLineup = self.currentLineup
            if self.currentInningInfo.kind == "ST" {
                runnerMenuViewController.teamKind = self.visitedTeam.kind
            }
            else {
                runnerMenuViewController.teamKind = self.homeTeam.kind
            }
            runnerMenuViewController.preferredContentSize = CGSize(width: 200, height: 208)
            runnerMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = runnerMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(runnerMenuViewController, animated: true, completion: nil)
        }
        
    }
    
    func setPositionClickInfo(homeRecordText : String) {
        self.currentHrecord.homeRecordText = homeRecordText
        self.ivBall.isHidden = false
    }
    
    //1루수 포지션 Click
    @IBAction func clickPosition1B(_ sender: AnyObject) {
        //아웃카운트 체크
        if self.pitcherScoreBoardInfo.outCount == 3 {
            self.checkThreeOut()
            return
        }
        
        self.setPositionClickInfo(homeRecordText: PositionNumber.OneBase.rawValue)
        
        if self.positionClickState == "S" {
            self.setPaperRecording(recordingByThing: .Batter)
            self.ballAnimation(positionButton: self.btnPosition1B)
            positionImgSet3(isEnabled: false)
            positionImgSet(isOn : false)
        }
        else if self.positionClickState == "F"{
            sendd = PositionNumber.OneBase.rawValue
//            self.addActionRunnerState = AddActionRunnerState.StealAction
            self.runnerOut(sender: sender)
        }
        else{
            //메인 메뉴를 띄워야 한다
            self.changeDefenderPlayer(sender : sender)
        }
    }
    
    //2루수 포지션 Click
    @IBAction func clickPosition2B(_ sender: AnyObject) {
        
        //아웃카운트 체크
        if self.pitcherScoreBoardInfo.outCount == 3 {
            self.checkThreeOut()
            return
        }
        
        self.setPositionClickInfo(homeRecordText: PositionNumber.TwoBase.rawValue)
        
        if self.positionClickState == "S" {
            self.setPaperRecording(recordingByThing: .Batter)
            self.ballAnimation(positionButton: self.btnPosition2B)
            positionImgSet3(isEnabled: false)
            positionImgSet(isOn : false)
        }
        else if self.positionClickState == "F"{
            sendd = PositionNumber.TwoBase.rawValue
//            self.addActionRunnerState = AddActionRunnerState.StealAction
            self.runnerOut(sender: sender)
        }
        else {
            //메인 메뉴를 띄워야 한다
            self.changeDefenderPlayer(sender : sender)
        }
    }
    
    //유격수 포지션 Click
    @IBAction func clickPositionSS(_ sender: AnyObject) {
        
        //아웃카운트 체크
        if self.pitcherScoreBoardInfo.outCount == 3 {
            self.checkThreeOut()
            return
        }
        
        self.setPositionClickInfo(homeRecordText: PositionNumber.SS.rawValue)
        
        if self.positionClickState == "S" {
            self.setPaperRecording(recordingByThing: .Batter)
            self.ballAnimation(positionButton: self.btnPositionSS)
            positionImgSet3(isEnabled: false)
            positionImgSet(isOn : false)
        }
        else if self.positionClickState == "F"{
            //            self.setPaperRecording(recordingByThing: .Pitcher)
            //            self.ballAnimation(positionButton: self.btnPosition1B)
            sendd = PositionNumber.SS.rawValue
//            self.addActionRunnerState = AddActionRunnerState.StealAction
            self.runnerOut(sender: sender)
        }

        else {
            //메인 메뉴를 띄워야 한다
            self.changeDefenderPlayer(sender : sender)
        }
    }
    
    //3루수 포지션 Click
    @IBAction func clickPosition3B(_ sender: AnyObject) {
        
        //아웃카운트 체크
        if self.pitcherScoreBoardInfo.outCount == 3 {
            self.checkThreeOut()
            return
        }
        
        self.setPositionClickInfo(homeRecordText: PositionNumber.ThreeBase.rawValue)
        
        if self.positionClickState == "S" {
            self.setPaperRecording(recordingByThing: .Batter)
            self.ballAnimation(positionButton: self.btnPosition3B)
            positionImgSet3(isEnabled: false)
            positionImgSet(isOn : false)
        }
        else if self.positionClickState == "F"{
            //            self.setPaperRecording(recordingByThing: .Pitcher)
            //            self.ballAnimation(positionButton: self.btnPosition1B)
            sendd = PositionNumber.ThreeBase.rawValue
//            self.addActionRunnerState = AddActionRunnerState.StealAction
            self.runnerOut(sender: sender)
        }

        else {
            //메인 메뉴를 띄워야 한다
            self.changeDefenderPlayer(sender : sender)
        }
    }
    
    //좌익수 포지션 Click
    @IBAction func clickPositionLF(_ sender: AnyObject) {
        
        //아웃카운트 체크
        if self.pitcherScoreBoardInfo.outCount == 3 {
            self.checkThreeOut()
            return
        }
        
        self.setPositionClickInfo(homeRecordText: PositionNumber.LF.rawValue)
        
        if self.positionClickState == "S" {
            self.setPaperRecording(recordingByThing: .Batter)
            self.ballAnimation(positionButton: self.btnPositionLF)
            positionImgSet3(isEnabled: false)
            positionImgSet(isOn : false)
        }
        else if self.positionClickState == "F"{
            //            self.setPaperRecording(recordingByThing: .Pitcher)
            //            self.ballAnimation(positionButton: self.btnPosition1B)
            sendd = PositionNumber.LF.rawValue
//            self.addActionRunnerState = AddActionRunnerState.StealAction
            self.runnerOut(sender: sender)
        }

        else {
            //메인 메뉴를 띄워야 한다
            self.changeDefenderPlayer(sender : sender)
        }
    }
    
    //중견수 포지션 Click
    @IBAction func clickPositionCF(_ sender: AnyObject) {
        
        //아웃카운트 체크
        if self.pitcherScoreBoardInfo.outCount == 3 {
            self.checkThreeOut()
            return
        }
        
        self.setPositionClickInfo(homeRecordText: PositionNumber.CF.rawValue)
        
        if self.positionClickState == "S" {
            self.setPaperRecording(recordingByThing: .Batter)
            self.ballAnimation(positionButton: self.btnPositionCF)
            positionImgSet3(isEnabled: false)
            positionImgSet(isOn : false)
        }
        else if self.positionClickState == "F"{
            //            self.setPaperRecording(recordingByThing: .Pitcher)
            //            self.ballAnimation(positionButton: self.btnPosition1B)
            sendd = PositionNumber.CF.rawValue
//            self.addActionRunnerState = AddActionRunnerState.StealAction
            self.runnerOut(sender: sender)
        }

        else {
            //메인 메뉴를 띄워야 한다
            self.changeDefenderPlayer(sender : sender)
        }
    }
    
    //우익수 포지션 Click
    @IBAction func clickPositionRF(_ sender: AnyObject) {
        
        //아웃카운트 체크
        if self.pitcherScoreBoardInfo.outCount == 3 {
            self.checkThreeOut()
            return
        }
        
        self.setPositionClickInfo(homeRecordText: PositionNumber.RF.rawValue)
        
        if self.positionClickState == "S" {
            self.setPaperRecording(recordingByThing: .Batter)
            self.ballAnimation(positionButton: self.btnPositionRF)
            positionImgSet3(isEnabled: false)
            positionImgSet(isOn : false)
        }
        else if self.positionClickState == "F"{
            //            self.setPaperRecording(recordingByThing: .Pitcher)
            //            self.ballAnimation(positionButton: self.btnPosition1B)
            sendd = PositionNumber.RF.rawValue
//            self.addActionRunnerState = AddActionRunnerState.StealAction
            self.runnerOut(sender: sender)
//            self.ballAnimation(positionButton: self.btnPositionRF)
        }

        else {
            //메인 메뉴를 띄워야 한다
            self.changeDefenderPlayer(sender : sender)
        }
    }
    
    @IBAction func clickRunnerH_1(_ sender: AnyObject) {
        
        if self.addActionRunnerState == .BatterAction {
            let basemanRunnerRecordMenuViewController = storyboard?.instantiateViewController(withIdentifier: "baserunnermenu") as! BasemanRunnerRecordMenuViewController
            basemanRunnerRecordMenuViewController.runnerCompleteDelegate = self;
            basemanRunnerRecordMenuViewController.hRecord = self.oneRunnerHRecord;
            basemanRunnerRecordMenuViewController.currentHRecord = self.currentHrecord
            basemanRunnerRecordMenuViewController.runnerPosition = RunnerPosition.Default
            basemanRunnerRecordMenuViewController.preferredContentSize = CGSize(width: 300, height: 280)
            basemanRunnerRecordMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = basemanRunnerRecordMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(basemanRunnerRecordMenuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func clickRunner1_2(_ sender: AnyObject) {
        //추가 기록
        
        if self.addActionRunnerState == .BatterAction {
            let basemanRunnerRecordMenuViewController = storyboard?.instantiateViewController(withIdentifier: "baserunnermenu") as! BasemanRunnerRecordMenuViewController
            basemanRunnerRecordMenuViewController.runnerCompleteDelegate = self;
            basemanRunnerRecordMenuViewController.hRecord = self.oneRunnerHRecord;
            basemanRunnerRecordMenuViewController.currentHRecord = self.currentHrecord
            basemanRunnerRecordMenuViewController.runnerPosition = RunnerPosition.OneRunner
            basemanRunnerRecordMenuViewController.runnerState = self.runnerState
            
            basemanRunnerRecordMenuViewController.preferredContentSize = CGSize(width: 300, height: 280)
            basemanRunnerRecordMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = basemanRunnerRecordMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(basemanRunnerRecordMenuViewController, animated: true, completion: nil)
        }
        else if self.addActionRunnerState == .StealAction || self.addActionRunnerState == .runnerAction{
            //도루, 실패 팝업
            let pinchRunnerRecordMenuViewController = storyboard?.instantiateViewController(withIdentifier: "pinchrunnermenu") as! PinchRunnerRecordMenuViewController
            
            pinchRunnerRecordMenuViewController.addActionRunnerState = self.addActionRunnerState;
            pinchRunnerRecordMenuViewController.holdrunnerCompleteDelegate = self;
            pinchRunnerRecordMenuViewController.hRecord = self.oneHalfRunnerHRecord;
            pinchRunnerRecordMenuViewController.currentHRecord = self.currentHrecord
            pinchRunnerRecordMenuViewController.runnerPosition = RunnerPosition.OneRunner
            pinchRunnerRecordMenuViewController.runnerState = self.runnerState
            pinchRunnerRecordMenuViewController.preferredContentSize = CGSize(width: 300, height: 465)
            pinchRunnerRecordMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = pinchRunnerRecordMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as? UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(pinchRunnerRecordMenuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func clickRunner2_3(_ sender: AnyObject) {
        //추가 기록
        if self.addActionRunnerState == .BatterAction {
            let basemanRunnerRecordMenuViewController = storyboard?.instantiateViewController(withIdentifier: "baserunnermenu") as! BasemanRunnerRecordMenuViewController
            basemanRunnerRecordMenuViewController.runnerCompleteDelegate = self;
            basemanRunnerRecordMenuViewController.hRecord = self.twoRunnerHRecord;
            basemanRunnerRecordMenuViewController.currentHRecord = self.currentHrecord
            basemanRunnerRecordMenuViewController.runnerPosition = RunnerPosition.TwoRunner
            basemanRunnerRecordMenuViewController.runnerState = self.runnerState
            basemanRunnerRecordMenuViewController.preferredContentSize = CGSize(width: 300, height: 280)
            basemanRunnerRecordMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = basemanRunnerRecordMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(basemanRunnerRecordMenuViewController, animated: true, completion: nil)
        }else if self.addActionRunnerState == .StealAction || self.addActionRunnerState == .runnerAction{
            //도루, 실패 팝업 (폭투에 의한, 스틸에 의한,...)
            let pinchRunnerRecordMenuViewController = storyboard?.instantiateViewController(withIdentifier: "pinchrunnermenu") as! PinchRunnerRecordMenuViewController
            
            pinchRunnerRecordMenuViewController.addActionRunnerState = self.addActionRunnerState;
            pinchRunnerRecordMenuViewController.holdrunnerCompleteDelegate = self;
            pinchRunnerRecordMenuViewController.hRecord = self.twoHalfRunnerHRecord;
            pinchRunnerRecordMenuViewController.currentHRecord = self.currentHrecord
            pinchRunnerRecordMenuViewController.runnerPosition = RunnerPosition.TwoRunner
            pinchRunnerRecordMenuViewController.runnerState = self.runnerState
            pinchRunnerRecordMenuViewController.preferredContentSize = CGSize(width: 300, height: 465)
            pinchRunnerRecordMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = pinchRunnerRecordMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(pinchRunnerRecordMenuViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func clickRunner3_H(_ sender: AnyObject) {
        //추가 기록
        if self.addActionRunnerState == .BatterAction {
            let basemanRunnerRecordMenuViewController = storyboard?.instantiateViewController(withIdentifier: "baserunnermenu") as! BasemanRunnerRecordMenuViewController
            basemanRunnerRecordMenuViewController.runnerCompleteDelegate = self;
            if self.addActionState == .oneAction && self.tempRunnerHRecord.number != "" {
                basemanRunnerRecordMenuViewController.hRecord = self.tempRunnerHRecord;
            }
            else {
                basemanRunnerRecordMenuViewController.hRecord = self.threeRunnerHRecord;
            }
            basemanRunnerRecordMenuViewController.currentHRecord = self.currentHrecord
            basemanRunnerRecordMenuViewController.runnerPosition = RunnerPosition.ThreeRunner
            basemanRunnerRecordMenuViewController.runnerState = self.runnerState
            basemanRunnerRecordMenuViewController.preferredContentSize = CGSize(width: 300, height: 280)
            basemanRunnerRecordMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = basemanRunnerRecordMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as? UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(basemanRunnerRecordMenuViewController, animated: true, completion: nil)
        }else if self.addActionRunnerState == .StealAction || self.addActionRunnerState == .runnerAction{
            //도루, 실패 팝업
            let pinchRunnerRecordMenuViewController = storyboard?.instantiateViewController(withIdentifier: "pinchrunnermenu") as! PinchRunnerRecordMenuViewController
            
            pinchRunnerRecordMenuViewController.addActionRunnerState = self.addActionRunnerState;
            pinchRunnerRecordMenuViewController.holdrunnerCompleteDelegate = self;
            pinchRunnerRecordMenuViewController.hRecord = self.threeHalfRunnerHRecord;
            pinchRunnerRecordMenuViewController.currentHRecord = self.currentHrecord
            pinchRunnerRecordMenuViewController.runnerPosition = RunnerPosition.ThreeRunner
            pinchRunnerRecordMenuViewController.runnerState = self.runnerState
            pinchRunnerRecordMenuViewController.preferredContentSize = CGSize(width: 300, height: 465)
            pinchRunnerRecordMenuViewController.modalPresentationStyle = .popover
            
            if let popoverController = pinchRunnerRecordMenuViewController.popoverPresentationController {
                popoverController.sourceView = sender as? UIView
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            present(pinchRunnerRecordMenuViewController, animated: true, completion: nil)
        }
    }
    
    
    //투구 완료시 설정
    func PitcherCompletedPopover() {
        //투구 완료
        
        //팝업 상태
        self.actionPopState = .RunnerStop
        
        //완료 상태
        self.statusDone = .BatterDone
        
        //이미지 설정
        self.setPitcherImageview()
        self.setBatterInfo()
        
        //현재 투수 투구 정보 및 전광판 정보 설정
        self.setPitcherScoreBoard()
    }
    
    func setBatterRecordByPitcher(recordState : RecordState) {
        //타격과 같은 효과
        self.btnPitcher.isHidden = true
        self.btnDone.isHidden = false
        
        //투구 정보 스트라이크 초기화, 아웃 카운트 증가
        self.reSetPitcherStrikeBall()
        
        //타격 정보 설정
//        self.currentHrecord.hittingRecord = recordState
        self.currentHrecord.homeRecord = recordState
        self.currentHrecord.homeRecordImage = recordState.rawValue
        self.setPaperRecording(recordingByThing: .Pitcher)
        
    }
    
    func setPitcherScoreBoard() {
        
        
        if self.pitcherScoreBoardInfo.orderCount != 1{
            //총 투구수는 무조건 올라 간다.
            self.currentPLineup.pitcherTotalCount += 1
            self.lblPitcherTotalCount.text = String(self.currentPLineup.pitcherTotalCount)
        }
        
        //스트라이크 3개면 삼진 아웃
        if self.pitcherScoreBoardInfo.strikeCount == 3 {
            
            self.currentLineup.strikeOut += 1
            self.currentPLineup.pitcherStrikeOutCount += 1
            self.pitcherScoreBoardInfo.outCount += 1
            
            //스트라이트 3개로 구분함
            self.currentHrecord.hittingRecord = RecordState.StrikeOut
            self.setBatterRecordByPitcher(recordState: self.currentHrecord.hittingRecord)
            
//            self.currentHrecord.centerRecord = RecordState.OutCountOne
//            self.currentHrecord.centerRecordImage = RecordState.OutCountOne.rawValue
//            
//            self.hRecord.centerRecord = RecordState.OutCountOne
//            self.hRecord.centerRecordImage = RecordState.OutCountOne.rawValue
            
            
            switch pitcherScoreBoardInfo.outCount {
            case 1:
                self.currentHrecord.centerRecord = RecordState.OutCountOne
                self.currentHrecord.centerRecordImage = RecordState.OutCountOne.rawValue
            case 2:
                self.currentHrecord.centerRecord = RecordState.OutCountTwo
                self.currentHrecord.centerRecordImage = RecordState.OutCountTwo.rawValue
            case 3:
                self.currentHrecord.centerRecord = RecordState.OutCountThree
                self.currentHrecord.centerRecordImage = RecordState.OutCountThree.rawValue
            default: break
                
            }
            
            
            
            
//            switch pitcherScoreBoardInfo.outCount {
//            case 0:
//                self.hRecord.centerRecord = RecordState.OutCountOne
//                self.hRecord.centerRecordImage = RecordState.OutCountOne.rawValue
//            case 1:
//                self.hRecord.centerRecord = RecordState.OutCountTwo
//                self.hRecord.centerRecordImage = RecordState.OutCountTwo.rawValue
//            case 2:
//                self.hRecord.centerRecord = RecordState.OutCountThree
//                self.hRecord.centerRecordImage = RecordState.OutCountThree.rawValue
//            default: break
//                
//            }
            
            
            //완료
            //            self.completeCycle()
        }
        
        
        
        
        
        //볼 4개면 볼넷
        if self.pitcherScoreBoardInfo.ballCount == 4 && self.currentHrecord.hittingRecord != .IntentionalBall {
            
            self.currentPLineup.pitcherBaseOnBallsCount += 1
            self.currentLineup.baseOnBalls += 1
            self.actionPopState = .BeforCompleteHoldRunner
            
            
            //볼 4개로 구분함
            self.currentHrecord.hittingRecord = RecordState.FourBall
            self.setBatterRecordByPitcher(recordState: self.currentHrecord.hittingRecord)
            
            //볼넷 정보
            //            self.currentLineup.baseOnBalls += 1
            
            
//            self.oneRunnerHRecord = self.currentHrecord
            
            //완료
            //            self.completeCycle()
        }
        //타격방해
        if self.pitcherScoreBoardInfo.orderCount == 1{
            self.actionPopState = .BeforCompleteHoldRunner
            
            self.setBatterRecordByPitcher(recordState: self.currentHrecord.hittingRecord)
            
            //            self.oneRunnerHRecord = self.currentHrecord
        }
        
        
        
        
        
        
        //사구
        if self.pitcherScoreBoardInfo.ballCount == 5 {
            self.currentPLineup.pitcherBaseOnBallsCount += 1//현재투수 볼카운트
            self.actionPopState = .BeforCompleteHoldRunner
            self.setBatterRecordByPitcher(recordState: self.currentHrecord.hittingRecord)
            //            self.setBatterRecordByPitcher(recordState: RecordState.HitByPitch)//완료후 이미지
            
            //            self.oneRunnerHRecord = self.currentHrecord
            
            //사구 정보
            //            self.currentLineup.hitByPitch += 1
        }
        
        //고의 4구
        if self.currentHrecord.hittingRecord == .IntentionalBall {
            self.actionPopState = .BeforCompleteHoldRunner
            
            self.setBatterRecordByPitcher(recordState: self.currentHrecord.hittingRecord)
        }
        
        if self.currentHrecord.hittingRecord == .FourBall ||
            self.currentHrecord.hittingRecord == .IntentionalBall ||
            self.currentHrecord.hittingRecord == .HitByPitch ||
            self.currentHrecord.hittingRecord == .NotOut ||
            self.currentHrecord.hittingRecord == .Balk {
            
            self.oneRunnerHRecord = self.currentHrecord
        }
        
        //투구시에는 전광판 변경
        self.pitcherDisplayChange(isReset: false)
        
    }
    
    func reSetPitcherStrikeBall() {
        //투구 정보 스트라이크 초기화, 아웃 카운트 증가
        self.pitcherScoreBoardInfo.strikeCount = 0
        self.pitcherScoreBoardInfo.ballCount = 0
        self.pitcherScoreBoardInfo.orderCount = 0
    }
    
    func BatterCompletedPopover() {
        //타격 완료
        
        //완료 상태
        self.statusDone = .BatterDone
        
        //아웃카운트 체크
        //if self.pitcherScoreBoardInfo.outCount == 3 {
        //    self.checkThreeOut()
        //    return
        //}
        
        //타격 종료 일 경우 주자들의 추가 입력 가능하게 변경한다.
        self.actionPopState = .RunnerStop
        self.addActionRunnerState = AddActionRunnerState.BatterAction
        self.setBatterRecord()
    }
    
    func setFailRecord() {
        self.btnPitcher.isHidden = true
        self.btnDone.isHidden = true
        self.lblPositionMessage.isHidden = false
//        self.btnRunner1.isEnabled = false
//        self.btnRunner2.isEnabled = false
//        self.btnRunner3.isEnabled = false
        positionImgSet2(isOn: true)
//        self.positionImgSet(isOn: true)
        //포지션 클릭 상태(타격 메뉴 이후 타구 방향 선택)
        
        lblPositionMessage.text = "액션을 취할\n수비수를 선택해주세요."
        self.positionClickState = "U"
        self.btnRunner1.isEnabled = false
        self.btnRunner1_2.isEnabled = false
        self.btnRunner2.isEnabled = false
        self.btnRunner2_3.isEnabled = false
        self.btnRunner3.isEnabled = false
        self.btnRunner3_H.isEnabled = false
        
    }
    
    
    
    
    func setBatterRecord() {
        
        self.btnPitcher.isHidden = true
        self.btnDone.isHidden = true
        self.lblPositionMessage.isHidden = false
        self.positionImgSet(isOn: true)
        
        //포지션 클릭 상태(타격 메뉴 이후 타구 방향 선택)
        self.positionClickState = "S"
        
        //        //총 투구수는 무조건 올라 간다.
        //        self.currentPLineup.pitcherTotalCount += 1
        //        self.lblPitcherTotalCount.text = String(self.currentPLineup.pitcherTotalCount)
    }
    
    func setRunnerInitialize() {
        
        self.btnRunner1.isHidden = true
        self.btnRunner2.isHidden = true
        self.btnRunner3.isHidden = true
        self.isOneRunner = false
        self.isTwoRunner = false
        self.isThreeRunner = false
    }
    
    func setPitcherImageview() {
        let imageName : String = self.currentHrecord.pitcherRecordImage[self.currentHrecord.pitcherRecord.count - 1]
        let image: UIImage = UIImage(named: imageName)!
        
        switch self.currentHrecord.pitcherRecord.count {
        case 1:
            self.ivPitcherRecord1.image = image
        case 2:
            self.ivPitcherRecord2.image = image
        case 3:
            self.ivPitcherRecord3.image = image
        case 4:
            self.ivPitcherRecord4.image = image
        case 5:
            self.ivPitcherRecord5.image = image
        case 6:
            self.ivPitcherRecord6.image = image
        case 7:
            self.ivPitcherRecord7.image = image
        case 8:
            self.ivPitcherRecord8.image = image
        case 9:
            self.ivPitcherRecord9.image = image
        case 10:
            self.ivPitcherRecord10.image = image
        case 11:
            self.ivPitcherRecord11.image = image
        case 12:
            self.ivPitcherRecord12.image = image
        case 13:
            self.ivPitcherRecord13.image = image
        case 14:
            self.ivPitcherRecord14.image = image
        case 15:
            self.ivPitcherRecord15.image = image
        case 16:
            self.ivPitcherRecord16.image = image
        default:
            return
        }
    }
    
    func pitcherDisplayChange(isReset : Bool) {
        
        var imageName : String = ""
        
        if isReset == true {
            
            imageName = "RV_bcount_off_img.png"
            let image: UIImage = UIImage(named: imageName)!
            
            self.ivOneBall.image = image
            self.ivTwoBall.image = image
            self.ivThreeBall.image = image
            self.ivOneStrike.image = image
            self.ivTwoStrike.image = image
            
            if self.pitcherScoreBoardInfo.outCount == 0 {
                self.ivOneOut.image = image
                self.ivTwoOut.image = image
            }
        }
        else {
            imageName = "RV_bcount_o_img.png"
            let image: UIImage = UIImage(named: imageName)!
            
            if self.pitcherScoreBoardInfo.strikeCount == 1 {
                self.ivOneStrike.image = image
            }
            else if self.pitcherScoreBoardInfo.strikeCount == 2 {
                self.ivTwoStrike.image = image
            }
            
            if self.pitcherScoreBoardInfo.outCount == 1 {
                self.ivOneOut.image = image
            }
            else if self.pitcherScoreBoardInfo.outCount == 2 {
                self.ivOneOut.image = image
                self.ivTwoOut.image = image
            }
            
            imageName = "RV_bcount_b_img.png"
            let image1: UIImage = UIImage(named: imageName)!
            
            if self.pitcherScoreBoardInfo.ballCount == 1 {
                self.ivOneBall.image = image1
            }
            else if self.pitcherScoreBoardInfo.ballCount == 2 {
                self.ivTwoBall.image = image1
            }
            else if self.pitcherScoreBoardInfo.ballCount == 3 {
                self.ivThreeBall.image = image1
            }
            
        }
        
        
    }
    
    func displayLabelColorChange() {
        
        //기존 이닝 색상 변경
        currentInningLabel.textColor = UIColor.white
        
        if self.currentInningInfo.kind == "ST" {
            self.lblDSVisitedTeamName.textColor = UIColor.yellow
            self.lblDSHomeTeamName.textColor = UIColor.white
            
            switch self.currentInningInfo.number {
            case 1:
                currentInningLabel = self.lblDS1ST
            case 2:
                currentInningLabel = self.lblDS2ST
            case 3:
                currentInningLabel = self.lblDS3ST
            case 4:
                currentInningLabel = self.lblDS4ST
            case 5:
                currentInningLabel = self.lblDS5ST
            case 6:
                currentInningLabel = self.lblDS6ST
            case 7:
                currentInningLabel = self.lblDS7ST
            case 8:
                currentInningLabel = self.lblDS8ST
            case 9:
                currentInningLabel = self.lblDS9ST
            default:
                currentInningLabel = self.lblDS1ST
            }
        }
        else {
            self.lblDSVisitedTeamName.textColor = UIColor.white
            self.lblDSHomeTeamName.textColor = UIColor.yellow
            
            switch self.currentInningInfo.number {
            case 1:
                currentInningLabel = self.lblDS1BT
            case 2:
                currentInningLabel = self.lblDS2BT
            case 3:
                currentInningLabel = self.lblDS3BT
            case 4:
                currentInningLabel = self.lblDS4BT
            case 5:
                currentInningLabel = self.lblDS5BT
            case 6:
                currentInningLabel = self.lblDS6BT
            case 7:
                currentInningLabel = self.lblDS7BT
            case 8:
                currentInningLabel = self.lblDS8BT
            case 9:
                currentInningLabel = self.lblDS9BT
            default:
                currentInningLabel = self.lblDS1BT
            }
        }
        //현재 이닝으로 색상 변경
        currentInningLabel.textColor = UIColor.yellow
    }
    
    func setBatBaseInformation() {
        
        if self.isOffenceDefenceChange == true {
            //공수 교대 일 경우(공격은 홈팀, 수비는 원정팀)
            //이닝 변경 일 경우(공격은 원정팀, 수비는 홈팀)
            
            //아웃 카운트 초기화
            self.pitcherScoreBoardInfo = PitcherScoreBoardInfo()
            
            //기록지 카운트 초기화
            recordCount = 2
            
            //주자들 초기화
            self.setRunnerInitialize()
            
            var inningNumber : Int = 0
            inningNumber = self.currentInningInfo.number
            
            //이닝 변경은 무조건 원정팀
            if self.isInningChange == true {
                
                //이닝정보 셋팅
                self.currentInningInfo = self.visitedTeam.inningInfo.first(where : { $0.number == inningNumber + 1 })!
                let beforeInningIndex = self.currentInningInfo.number - 2
                let lastMemberNumber = self.visitedTeam.inningInfo[beforeInningIndex].hRecord[0].memberNumber
                var lastIndex = self.visitedTeam.mainLineupInfo.index(where : { $0.memberNumber == lastMemberNumber })! + 1
                
                if lastIndex > 8 {
                    lastIndex = 0
                }
                self.currentLineup = self.visitedTeam.mainLineupInfo[lastIndex]
                
                //이닝에 속한 기록지 기본 셋팅
                for i in 0...2 {
                    self.currentInningInfo.hRecord[2 - i].number = self.visitedTeam.mainLineupInfo[lastIndex + i].number
                    self.currentInningInfo.hRecord[2 - i].name = self.visitedTeam.mainLineupInfo[lastIndex + i].name
                    self.currentInningInfo.hRecord[2 - i].memberNumber = self.visitedTeam.mainLineupInfo[lastIndex + i].memberNumber
                }
                
                //수부팀 정보 셋팅
                let pitcherLineup = self.homeTeam.mainLineupInfo.first(where: { $0.positionName == "SP" })
                self.currentPLineup = pitcherLineup!
                self.homeTeam.inningInfo[inningNumber + 1].pRecord[0].name = (pitcherLineup?.name)!
                self.homeTeam.inningInfo[inningNumber + 1].pRecord[0].memberNumber = (pitcherLineup?.memberNumber)!
                
                
                self.isInningChange = false
            }
            else {
                //공수 교대일 경우에는 무조건 홈팀
                //공수 교대만 된 경우(홈팀의 해당 이닝 선택)
                self.currentInningInfo = self.homeTeam.inningInfo.first(where : { $0.number == inningNumber })!
                
                if self.currentInningInfo.number == 1 {
                    self.currentLineup = self.homeTeam.mainLineupInfo[0]
                    
                    for i in 0...2 {
                        self.currentInningInfo.hRecord[2 - i].number = self.homeTeam.mainLineupInfo[i].number
                        self.currentInningInfo.hRecord[2 - i].name = self.homeTeam.mainLineupInfo[i].name
                        self.currentInningInfo.hRecord[2 - i].memberNumber = self.homeTeam.mainLineupInfo[i].memberNumber
                    }
                }
                else {
                    
                    let lastMemberNumber = self.homeTeam.inningInfo[inningNumber - 2].hRecord[0].memberNumber
                    var lastIndex = self.homeTeam.mainLineupInfo.index(where : { $0.memberNumber == lastMemberNumber })! + 1
                    
                    if lastIndex > 8 {
                        lastIndex = 0
                    }
                    self.currentLineup = self.homeTeam.mainLineupInfo[lastIndex]
                    
                    for i in 0...2 {
                        self.currentInningInfo.hRecord[2 - i].number = self.homeTeam.mainLineupInfo[lastIndex + i].number
                        self.currentInningInfo.hRecord[2 - i].name = self.homeTeam.mainLineupInfo[lastIndex + i].name
                        self.currentInningInfo.hRecord[2 - i].memberNumber = self.homeTeam.mainLineupInfo[lastIndex + i].memberNumber
                    }
                    
                }
                
                //수부팀 정보 셋팅
                let pitcherLineup = self.visitedTeam.mainLineupInfo.first(where: { $0.positionName == "SP" })
                self.currentPLineup = pitcherLineup!
                self.visitedTeam.inningInfo[inningNumber + 1].pRecord[0].name = (pitcherLineup?.name)!
                self.visitedTeam.inningInfo[inningNumber + 1].pRecord[0].memberNumber = (pitcherLineup?.memberNumber)!
            }
            
            self.currentHrecord = self.currentInningInfo.hRecord[recordCount]
            self.isOffenceDefenceChange = false
            self.displayLabelColorChange()
            
            self.runnerState = .Default
        }
        else {
            //다음 타자일 경우
            
            //같은 팀이 계속 진행중..
            //라인업 변경
            if self.currentInningInfo.kind == "ST" {
                var nextIndex = self.visitedTeam.mainLineupInfo.index(where: { $0 == self.currentLineup })! + 1
                
                if nextIndex > 8 {
                    nextIndex = 0
                }
                self.currentLineup = self.visitedTeam.mainLineupInfo[nextIndex]
            }
            else {
                var nextIndex = self.homeTeam.mainLineupInfo.index(where: { $0 == self.currentLineup })! + 1
                
                if nextIndex > 8 {
                    nextIndex = 0
                }
                self.currentLineup = self.homeTeam.mainLineupInfo[nextIndex]
            }
            
            //이닝에 속한 기록지 기본 셋팅
            if self.recordCount < 1 {
                //4개부터 추가
                self.currentHrecord = HRecordInfo()
                self.currentHrecord.number = self.currentLineup.number
                self.currentHrecord.name = self.currentLineup.name
                self.currentHrecord.memberNumber = self.currentLineup.memberNumber
                self.currentInningInfo.hRecord.insert(self.currentHrecord, at: 0)
                self.homeTeam.inningInfo.append(currentInningInfo)
            }
            else {
                //3개까지는 이미 만들어져 있음. 다음 Record 선택
                self.currentHrecord = self.currentInningInfo.hRecord[self.recordCount - 1]
            }
            
            //현재 뿌려지는 기록 수(다음 라인업을 위해 -1을 한다)
            self.recordCount -= 1
            
        }
    }
    
    func setScoreDisplay() {
        
        
        
    }
    
    func completeCycle() {
        //포지션 클릭 상태(타격 메뉴 이후 타구 방향 선택)
        self.positionClickState = "M"
        self.btnPitcher.isHidden = false
        self.btnDone.isHidden = true
        self.positionImgSet(isOn: false)
        
        //3아웃이면 공수 교대
        if self.pitcherScoreBoardInfo.outCount == 3 {
            self.isOffenceDefenceChange = true
            
            //말 공격이 끝나면 이닝 변경
            if self.currentInningInfo.kind == "BT" {
                self.isInningChange = true
            }
            
            //잔루 정보
            if self.oneRunnerHRecord.memberNumber != "" {
                let findOneLineup : Lineup = self.currentTeam.mainLineupInfo.first(where : { $0.memberNumber == self.oneRunnerHRecord.memberNumber })!
                findOneLineup.leftOnBase += 1
            }
            if self.twoRunnerHRecord.memberNumber != "" {
                let findOneLineup : Lineup = self.currentTeam.mainLineupInfo.first(where : { $0.memberNumber == self.twoRunnerHRecord.memberNumber })!
                findOneLineup.leftOnBase += 1
            }
            if self.threeRunnerHRecord.memberNumber != "" {
                let findOneLineup : Lineup = self.currentTeam.mainLineupInfo.first(where : { $0.memberNumber == self.threeRunnerHRecord.memberNumber })!
                findOneLineup.leftOnBase += 1
            }
        }
        
        //공수 교대 일때 기록지 TableView를 초기화 한다.
        //TableView에는 안보이지만 모델에는 라이업이 추가 되어 있어서 공수 교대일 경우에는 기본정보를 먼저 셋팅 한 후 초기화 한다(순서가 다르다)
        if self.isOffenceDefenceChange == true {
            if self.isInningChange == true {
                let alert = UIAlertController(title: "확인", message: "이닝 변경.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "확인", message: "공수 교대.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            //기본 정보 셋팅
            self.setBatBaseInformation()
            self.recordTableView.reloadData()
            self.isFirstBatter = true
        }
        else {
            //공수 교대 아닐 경우에는 기록지 TableView를 추가 기록한다.
            if self.recordCount > -1 {
                let indexPath = IndexPath(item: self.recordCount, section: 0)
                self.recordTableView.reloadRows(at: [indexPath], with: .top)
            }
            else {
                self.recordTableView.beginUpdates()
                self.recordTableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
                self.recordTableView.endUpdates()
            }
            
            //기본 정보 셋팅
            self.setBatBaseInformation()
            
            self.isFirstBatter = false
        }
        
        //전광판 셋팅
        self.bottomRecordClear()
        
        //타자 정보 셋팅
        self.setBatterInfo()
        
        //투수 정보 셋팅
        self.setPitcherInfo()
        
        //투구 전광판 셋팅(볼, 스트라이크, 아웃)
        self.pitcherDisplayChange(isReset: true)
        
        //공격팀, 수비팀 Label 변경 및 수비 포지션 등번호 설정
        if self.currentInningInfo.kind == "ST" {
            self.lblAttackTeamName.text = self.visitedTeam.name
            self.lblDefenseTeamName.text = self.homeTeam.name
            self.positionMemberNumberSet(kind: "H")
            
            //현재 공격팀
            self.currentTeam = TeamInfo()
            self.currentTeam = self.visitedTeam
        }
        else {
            self.lblAttackTeamName.text = self.homeTeam.name
            self.lblDefenseTeamName.text = self.visitedTeam.name
            self.positionMemberNumberSet(kind: "V")
            
            //현재 공격팀
            self.currentTeam = TeamInfo()
            self.currentTeam = self.homeTeam
        }
        
        
    }
    
    @IBAction func clickDone(_ sender: Any) {
        positionClickState = ""//포지션 초기화
        positionImgSet3(isEnabled: true)
        if self.statusDone == .BatterDone {
            print("타자완료버튼후1 : \(self.currentInningInfo.hRecord.count)")
            
            //타자 완료일 경우
            //기록 완료시에 주자들의 추가 입력이 메인 팝업으로 변경
            self.actionPopState = .CompleteHoldRunner
            self.lblPositionMessage.text = ""
            self.addActionRunnerState = .Default
            self.stealState = .Default
            print("타자완료버튼21 : \(self.currentInningInfo.hRecord.count)")
            ivBall.alpha  = 1;
            self.ballInitailize()
            
            self.statusDone = .Default
            print("타자완료버튼후3 : \(self.currentInningInfo.hRecord.count)")
            //다음 타석 정의
            self.completeCycle()
            
        } else if self.statusDone == .RunnerDone {
            //주자 완료일 경우
            if self.actionPopState == .BeforCompleteHoldRunner || self.actionPopState == .Default {
                self.btnDone.isHidden = true
                self.btnPitcher.isHidden = false
                self.actionPopState = .CompleteHoldRunner
                self.lblPositionMessage.text = ""
                self.addActionRunnerState = .Default
                self.stealState = .Default
                self.statusDone = .Default
                print("주자완료버튼후 : \(self.currentInningInfo.hRecord.count)")
                ivBall.alpha  = 1;
                ballInitailize()
                //다음 타석 정의
                if pitcherScoreBoardInfo.outCount == 3{
                    self.completeCycle()
                }
//
                return
            }
        }
        
        //타자 기록 통계
        self.batterRecordingStatistics()
        
        //change check 모두 False
        for index in 0...self.currentInningInfo.hRecord.count - 1 {
            self.currentInningInfo.hRecord[index].isChanged = false
        }
    }
    //타자 기록 통계 정보
    func batterRecordingStatistics() {
        switch self.currentHrecord.hittingRecord {
        case .StrikeOut:
            //삼진
            self.currentLineup.strikeOut += 1
        case .FourBall:
            //볼넷
            self.currentLineup.baseOnBalls += 1
        case .HitByPitch:
            //사구
            self.currentLineup.hitByPitch += 1
        case .IntentionalBall:
            //고의4구
            self.currentLineup.intentionalBaseOnBalls += 1
        default:
            break
        }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var recordNumber : Int = self.currentInningInfo.hRecord.count
        
        if self.recordCount < 0 {
            if self.actionPopState == .CompleteHoldRunner {
                
            }
            else {
                recordNumber = recordNumber - 1
            }
            /*
             if self.actionPopState == .Default {
             //            if self.runnerState.rawValue.contains("H") == false {
             //                return self.currentInningInfo.hRecord.count
             //                return recordNumber
             }
             else {
             recordNumber = recordNumber - 1
             //                return self.currentInningInfo.hRecord.count - 1
             }
             */
        }
        
        return recordNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Cell IndexPath.row : " + String(indexPath.row))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordTableViewCell
        var rowNumber = indexPath.row
        if tableView.numberOfRows(inSection: 0) != self.currentInningInfo.hRecord.count {
            rowNumber += 1
        }
        
        //        print("row count :" + String(tableView.numberOfRows(inSection: 0)) + "    model count : " + String(self.currentInningInfo.hRecord.count))
        
        cell.lblMemberNumber.text = self.currentInningInfo.hRecord[rowNumber].memberNumber
        
        cell.lblLocationNumber.text = ""
        if self.currentInningInfo.hRecord[rowNumber].runnerLocation != "" {
            cell.lblLocationNumber.text = self.currentInningInfo.hRecord[rowNumber].runnerLocation
        }
        
        cell.ivRecord1.image = nil
        cell.lblRecord1Text.text = ""
        if self.currentInningInfo.hRecord[rowNumber].homeRecordImage != "" {
            let image: UIImage = UIImage(named: self.currentInningInfo.hRecord[rowNumber].homeRecordImage)!
            cell.ivRecord1.image = image
            cell.lblRecord1Text.text = self.currentInningInfo.hRecord[rowNumber].homeRecordText
        }
        
        cell.ivRecord2.image = nil
        cell.lblRecord2Text.text = ""
        if self.currentInningInfo.hRecord[rowNumber].oneRecordImage != "" {
            let image: UIImage = UIImage(named: self.currentInningInfo.hRecord[rowNumber].oneRecordImage)!
            cell.ivRecord2.image = image
            cell.lblRecord2Text.text = self.currentInningInfo.hRecord[rowNumber].oneRecordText
        }
        
        cell.ivRecord3.image = nil
        cell.lblRecord3Text.text = ""
        if self.currentInningInfo.hRecord[rowNumber].twoRecordImage != "" {
            let image: UIImage = UIImage(named: self.currentInningInfo.hRecord[rowNumber].twoRecordImage)!
            cell.ivRecord3.image = image
            cell.lblRecord3Text.text = self.currentInningInfo.hRecord[rowNumber].twoRecordText
        }
        
        cell.ivRecord4.image = nil
        cell.lblRecord4Text.text = ""
        if self.currentInningInfo.hRecord[rowNumber].threeRecordImage != "" {
            let image: UIImage = UIImage(named: self.currentInningInfo.hRecord[rowNumber].threeRecordImage)!
            cell.ivRecord4.image = image
            cell.lblRecord4Text.text = self.currentInningInfo.hRecord[rowNumber].threeRecordText
        }
        
        cell.ivRecord5.image = nil
        if self.currentInningInfo.hRecord[rowNumber].centerRecordImage != "" {
            let centerimage: UIImage = UIImage(named: self.currentInningInfo.hRecord[rowNumber].centerRecordImage)!
            cell.ivRecord5.image = centerimage
            
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true;
    }
    
    func ballAnimation(positionButton : UIButton) {
        if self.positionClickState == "S" || self.positionClickState == "F"{
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/1, animations: {
                    self.ivBall.frame.origin.x = positionButton.frame.origin.x
                    self.ivBall.frame.origin.y = positionButton.frame.origin.y
//                    self.ballY = "\(positionButton)"
                    print("\(positionButton)")
//                    self.ballX = String(describing: positionButton.frame.origin.x)
//                    self.ballY = String(describing: positionButton.frame.origin.y)
//                    print(String(describing: positionButton.frame.origin.x))
                })
                
            }, completion: {finished in})
        }else{
            self.positionClickState = "F"
            self.ivBall.frame.origin.x = positionButton.frame.origin.x
            self.ivBall.frame.origin.y = positionButton.frame.origin.y
//            self.ivBall.isHidden = false
        }
        
    }
    
    func ballInitailize() {
        
        self.ivBall.isHidden = true
        self.ivBall.frame.origin.x = 628
        self.ivBall.frame.origin.y = 590
        
    }
    
    
    // MARK: - 하단 기록지 clear
    func bottomRecordClear() {
        self.ivPitcherRecord1.image = nil
        self.ivPitcherRecord2.image = nil
        self.ivPitcherRecord3.image = nil
        self.ivPitcherRecord4.image = nil
        self.ivPitcherRecord5.image = nil
        self.ivPitcherRecord6.image = nil
        self.ivPitcherRecord7.image = nil
        self.ivPitcherRecord8.image = nil
        self.ivPitcherRecord9.image = nil
        self.ivPitcherRecord10.image = nil
        self.ivPitcherRecord11.image = nil
        self.ivPitcherRecord12.image = nil
        self.ivPitcherRecord13.image = nil
        self.ivPitcherRecord14.image = nil
        self.ivPitcherRecord15.image = nil
        self.ivPitcherRecord16.image = nil
        self.ivBatterRecord1.image = nil
        self.ivBatterRecord2.image = nil
        self.ivBatterRecord3.image = nil
        self.ivBatterRecord4.image = nil
        self.ivBatterRecord5.image = nil
        self.lblBatterRecord1.text = ""
        self.lblBatterRecord2.text = ""
        self.lblBatterRecord3.text = ""
        self.lblBatterRecord4.text = ""
        
        //        imageView.removeFromSuperview()  // this removes it from your view hierarchy
        //        imageView = nil;
    }
    
    @IBAction func tmpRecordComplete(_ sender: Any) {
        
        
        
        
        let alertController = UIAlertController(title: "경기 종료", message: "기록확인 화면으로 넘어갑니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        let DestructiveAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
            //
            print("취소")
            
        }
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            //
            print("확인")
            let statsCompletionViewController = self.storyboard?.instantiateViewController(withIdentifier: "StatsDataLoadingVC") as! StatsCompletionViewController
            statsCompletionViewController.visitedTeam = self.visitedTeam
            statsCompletionViewController.homeTeam = self.homeTeam
            statsCompletionViewController.mainLineupInfo = self.visitedTeam.mainLineupInfo
            statsCompletionViewController.visitedTeam.mainLineupInfo = self.visitedTeam.mainLineupInfo
            statsCompletionViewController.homeTeam.mainLineupInfo = self.homeTeam.mainLineupInfo
            
//            statsCompletionViewController.vPRecord = self.vPRecord
//            statsCompletionViewController.hPRecord = self.hPRecord
//            statsCompletionViewController.lblDS1ST.text = self.lblDS1ST.text
            
            
            
            
            if let popoverController = statsCompletionViewController.popoverPresentationController {
                popoverController.sourceView = sender as! UIView
                popoverController.sourceRect = (sender as AnyObject).bounds
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
            self.present(statsCompletionViewController, animated: true, completion: nil)

        }
        
        alertController.addAction(DestructiveAction)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        

        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.teams)
        
        userDefaults.set(encodedData, forKey: "Teams")
        userDefaults.synchronize()
        
        
    }
   
    func runnerOut(sender : AnyObject){
        let defenderAddRunMenuViewController = storyboard?.instantiateViewController(withIdentifier: "defenderAddRunMenu") as! DefenderAddRunMenuViewController
        defenderAddRunMenuViewController.preferredContentSize = CGSize(width: 320, height: 300)
        defenderAddRunMenuViewController.modalPresentationStyle = .popover
        switch self.runnerPosition1 {
        case .OneRunner:
            if self.oneHalfRunnerHRecord.name != ""{
                if self.oneHalfRunnerHRecord.oneRecordImage == ""{
                    defenderAddRunMenuViewController.hRecord = self.oneHalfRunnerHRecord
                }else{
                    defenderAddRunMenuViewController.hRecord = self.oneRunnerHRecord
                }
            }else{
                defenderAddRunMenuViewController.hRecord = self.oneRunnerHRecord
            }
            if defenderAddRunMenuViewController.hRecord.oneRecord == .StealError{
                defenderAddRunMenuViewController.hRecord.oneRecordImage = RecordState.TwoAdvanceArrows.rawValue
            }
        case .TwoRunner:
            if self.twoHalfRunnerHRecord.name != ""{
                if self.twoHalfRunnerHRecord.twoRecordImage == ""{
                    defenderAddRunMenuViewController.hRecord = self.twoHalfRunnerHRecord
                }else{
                    defenderAddRunMenuViewController.hRecord = self.twoRunnerHRecord
                }
            }else{
                defenderAddRunMenuViewController.hRecord = self.twoRunnerHRecord
            }
            if defenderAddRunMenuViewController.hRecord.twoRecord == .StealError{
                defenderAddRunMenuViewController.hRecord.twoRecordImage = RecordState.ThreeAdvanceArrows.rawValue
            }
        case .ThreeRunner:
            if self.threeHalfRunnerHRecord.name != ""{
                if self.threeHalfRunnerHRecord.centerRecordImage == "" {
                    defenderAddRunMenuViewController.hRecord = self.threeHalfRunnerHRecord
                }else{
                defenderAddRunMenuViewController.hRecord = self.threeRunnerHRecord
                }
            }else{
                defenderAddRunMenuViewController.hRecord = self.threeRunnerHRecord
            }
            if defenderAddRunMenuViewController.hRecord.threeRecord == .StealError{
                defenderAddRunMenuViewController.hRecord.threeRecordImage = RecordState.HomeAdvanceArrows.rawValue
            }
        default:
            return
        }
        
        defenderAddRunMenuViewController.addActionRunnerState = self.addActionRunnerState
        defenderAddRunMenuViewController.holdRunnerComplete = self
        defenderAddRunMenuViewController.runnerPosition = self.runnerPosition1
        defenderAddRunMenuViewController.sendd = sendd
        defenderAddRunMenuViewController.ballXY = ballXY
        if let popoverController = defenderAddRunMenuViewController.popoverPresentationController {
            popoverController.sourceView = sender as? UIView
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
        }
        present(defenderAddRunMenuViewController, animated: true, completion: nil)
    }
    
    //수비수 교체
    func changeDefenderPlayer(sender : AnyObject) {
        
        print(sender.tag)
        //        if kind == "H" {
        //            result = (self.homeTeam.mainLineupInfo.first(where : { $0.positionNumber == positionName })?.memberNumber)!
        //        }
        //        else {
        //            result = (self.visitedTeam.mainLineupInfo.first(where : { $0.positionNumber == positionName })?.memberNumber)!
        //        }
        
        let fielderMenuViewController = storyboard?.instantiateViewController(withIdentifier: "changePlayersMenu") as! ChangeMenuViewController
        fielderMenuViewController.preferredContentSize = CGSize(width: 200, height: 300)
        fielderMenuViewController.modalPresentationStyle = .popover
        
        if let popoverController = fielderMenuViewController.popoverPresentationController {
            popoverController.sourceView = sender as? UIView
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
        }
        present(fielderMenuViewController, animated: true, completion: nil)
    }
    
    func checkThreeOut() {
        //
        self.clickDone(self.btnDone)
    }
}

extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
