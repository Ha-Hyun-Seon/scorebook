//
//  StatsCompletionViewController.swift
//  scorebook
//
//  Created by L2H on 2017. 7. 20..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit

class StatsCompletionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
//경기정보
    @IBOutlet weak var gameDate: UILabel!   //날짜
    @IBOutlet weak var gameStartTime: UILabel!  //시작시간
    @IBOutlet weak var gameEndTime: UILabel!    //종료시간
    
    @IBOutlet weak var gameLeagueName: UILabel! //리그명
    
    @IBOutlet weak var refereeName: UILabel!    //심판
    
    @IBOutlet weak var scorerName: UILabel! //기록원
    
 
    @IBOutlet weak var awayTeamName: UILabel!
    
    @IBOutlet weak var homeTeamName: UILabel!
    
    
   //전광판 원정팀 이닝
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
    @IBOutlet weak var lblDS9BT: UILabel!
    //전광판 원정팀 점수, 안타, 볼넷, 에러 정의
    @IBOutlet weak var lblDSHomeTeamRuns: UILabel!
    @IBOutlet weak var lblDSHomeTeamHits: UILabel!
    @IBOutlet weak var lblDSHomeTeamBaseOnBalls: UILabel!
    @IBOutlet weak var lblDSHomeTeamErrors: UILabel!
    
   //팀선택
    @IBOutlet weak var teamSegmented: UISegmentedControl!
    
   
    //타자테이블뷰
    @IBOutlet weak var batterStatsInfoTableView: UITableView!
    //투수테이블뷰
    @IBOutlet weak var pitcherStatsInfoTableView: UITableView!
    
    
    
    
//    
//    //타자정보
//    @IBOutlet weak var userName: UILabel!
//    @IBOutlet weak var battersBox: UILabel!
//    @IBOutlet weak var atBat: UILabel!
//    @IBOutlet weak var score: UILabel!
//    @IBOutlet weak var hits: UILabel!
//    @IBOutlet weak var twoBaseHit: UILabel!
//    @IBOutlet weak var threeBaseHit: UILabel!
//    @IBOutlet weak var homeRun: UILabel!
//    @IBOutlet weak var numberOfBase: UILabel!
//    @IBOutlet weak var runBattedIn: UILabel!
//    @IBOutlet weak var stolenBase: UILabel!
//    @IBOutlet weak var caughtSteal: UILabel!
//    @IBOutlet weak var sacrificeHit: UILabel!
//    @IBOutlet weak var sacrificeFly: UILabel!
//    @IBOutlet weak var fourBalls: UILabel!
//    @IBOutlet weak var intentionalWalk: UILabel!
//    @IBOutlet weak var hitByPitch: UILabel!
//    @IBOutlet weak var strikeOut: UILabel!
//    @IBOutlet weak var doublePlay: UILabel!
//    @IBOutlet weak var leftOnBases: UILabel!
//    
//    
//    //투수정보
//    @IBOutlet weak var pitcheruserName: UILabel!
//    @IBOutlet weak var numberOfPitches: UILabel!
//    @IBOutlet weak var hitters: UILabel!
//    @IBOutlet weak var opponentAtBat: UILabel!
//    @IBOutlet weak var opponentHits: UILabel!
//    @IBOutlet weak var opponenthomeRun: UILabel!
//    @IBOutlet weak var opponentSacrificeHit: UILabel!
//    @IBOutlet weak var opponentSacrificeFly: UILabel!
//    @IBOutlet weak var opponentFourBalls: UILabel!
//    @IBOutlet weak var opponentIntentionalWalk: UILabel!
//    @IBOutlet weak var opponentHitByPitch: UILabel!
//    @IBOutlet weak var opponentStrikeOut: UILabel!
//    @IBOutlet weak var wildPitch: UILabel!
//    @IBOutlet weak var balk: UILabel!
//    @IBOutlet weak var lostPoint: UILabel!
//    @IBOutlet weak var earnedRun: UILabel!
//    @IBOutlet weak var inningCount: UILabel!
//    @IBOutlet weak var outCount: UILabel!
 
    var gameInfo : GameInfo = GameInfo()
    var visitedTeam : TeamInfo = TeamInfo()
    var homeTeam : TeamInfo = TeamInfo()
    var vPRecord : PRecordInfo = PRecordInfo()
    var hPRecord : PRecordInfo = PRecordInfo()
    var mainLineupInfo:[Lineup] = [Lineup]()
    
    @IBAction func clickTeamSegment(_ sender: UISegmentedControl) {
        batterStatsInfoTableView.reloadData()
        pitcherStatsInfoTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamSegmented.selectedSegmentIndex = 0
        
        batterStatsInfoTableView.delegate = self
        batterStatsInfoTableView.dataSource = self
//        batterStatsInfoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "batterStatsInfo")
        
            pitcherStatsInfoTableView.delegate = self
            pitcherStatsInfoTableView.dataSource = self
//            pitcherStatsInfoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "pitcherStatsInfo")
        
        
        
        awayTeamName.text = visitedTeam.name
        homeTeamName.text = homeTeam.name
        print(mainLineupInfo.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var count:Int?
        
        
        if tableView == self.batterStatsInfoTableView{
            count = mainLineupInfo.count
        }
        
        if tableView == self.pitcherStatsInfoTableView{
            
                print("zz\(self.homeTeam.mainLineupInfo.first(where: { $0.positionName == "SP" })?.name)")
           
            count = mainLineupInfo.count
        }
      
        return count!
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
//        let cell:UITableViewCell?
        
        switch teamSegmented.selectedSegmentIndex {
        case 0:
            switch tableView {
            case self.batterStatsInfoTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "batterStatsInfo", for: indexPath) as! StatsCompletionBatterTableViewCell
                let myIndex = self.visitedTeam.mainLineupInfo[indexPath.row]
                cell.batterUserName.text = myIndex.name
                cell.battersBox.text = myIndex.kind
                cell.atBat.text = String(myIndex.timeAtBat)
                cell.score.text = myIndex.name
                cell.hits.text = String(myIndex.hittingCount)
                cell.twoBaseHit.text = String(myIndex.doubleHittingCount)
                cell.threeBaseHit.text = String(myIndex.thirdHittingCount)
                cell.homeRun.text = String(myIndex.homerunCount)
                cell.numberOfBase.text = myIndex.name//루타수
                cell.runBattedIn.text = myIndex.name//타점
                cell.stolenBase.text = myIndex.name//도루
                cell.caughtSteal.text = myIndex.name//도루자
                cell.sacrificeHit.text = myIndex.name//희타
                cell.sacrificeFly.text = myIndex.name//희비
                cell.fourBalls.text = String(myIndex.baseOnBalls)//4구
                cell.intentionalWalk.text = myIndex.name//고의4구
                cell.hitByPitch.text = String(myIndex.hitByPitch)//사구
                cell.strikeOut.text = String(myIndex.strikeOut)//삼진
                cell.doublePlay.text = myIndex.name//병살타
                cell.leftOnBases.text = myIndex.name//잔루
                
                return cell
            case self.pitcherStatsInfoTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "pitcherStatsInfo", for: indexPath) as! StatsCompletionPitcherTableViewCell
                let myIndex = self.visitedTeam.mainLineupInfo[indexPath.row]
//                if myIndex.positionName == "ST"{
                    cell.pitcheruserName.text = myIndex.name
                    //                cell.numberOfPitches.text = String(myIndex.pitcherTotalCountString)
                    cell.hitters.text = String(myIndex.pitcherHittingCount)
                    cell.opponentAtBat.text = myIndex.name
                    cell.opponentHits.text = myIndex.name
                    cell.opponenthomeRun.text = myIndex.name
                    //                cell.opponentSacrificeHit.text = myIndex.pitcherBaseOnBallsCount
                    cell.opponentSacrificeFly.text = myIndex.name
                    cell.opponentFourBalls.text = myIndex.name
                    //                cell.opponentIntentionalWalk.text = myIndex.pitcherStrikeOutCount
                    cell.opponentHitByPitch.text = myIndex.name
                    cell.opponentStrikeOut.text = myIndex.name
                    cell.wildPitch.text = myIndex.name
                    cell.balk.text = myIndex.name
                    cell.lostPoint.text = myIndex.name
                    cell.earnedRun.text = myIndex.name
                    cell.inningCount.text = myIndex.name
                    cell.outCount.text = myIndex.name
//                }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "pitcherStatsInfo", for: indexPath) as! StatsCompletionPitcherTableViewCell
                return cell
            }
            
    
        case 1:
            switch tableView {
            case self.batterStatsInfoTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "batterStatsInfo", for: indexPath) as! StatsCompletionBatterTableViewCell
                let myIndex = self.homeTeam.mainLineupInfo[indexPath.row]
                cell.batterUserName.text = myIndex.name
                cell.battersBox.text = myIndex.kind
                cell.atBat.text = String(myIndex.timeAtBat)
                cell.score.text = myIndex.name
                cell.hits.text = String(myIndex.hittingCount)
                cell.twoBaseHit.text = String(myIndex.doubleHittingCount)
                cell.threeBaseHit.text = String(myIndex.thirdHittingCount)
                cell.homeRun.text = String(myIndex.homerunCount)
                cell.numberOfBase.text = myIndex.name
                cell.runBattedIn.text = myIndex.name
                cell.stolenBase.text = myIndex.name
                cell.caughtSteal.text = myIndex.name
                cell.sacrificeHit.text = myIndex.name
                cell.sacrificeFly.text = myIndex.name
                cell.fourBalls.text = myIndex.name
                cell.intentionalWalk.text = myIndex.name
                cell.hitByPitch.text = myIndex.name
                cell.strikeOut.text = myIndex.name
                cell.doublePlay.text = myIndex.name
                cell.leftOnBases.text = myIndex.name
                
                return cell

            case self.pitcherStatsInfoTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "pitcherStatsInfo", for: indexPath) as! StatsCompletionPitcherTableViewCell
                let myIndex = self.homeTeam.mainLineupInfo[indexPath.row]
                
                
//                if myIndex.positionName == "ST"{
                    cell.pitcheruserName.text = myIndex.name
                    //                cell.numberOfPitches.text = String(myIndex.pitcherTotalCountString)
                    cell.hitters.text = String(myIndex.pitcherHittingCount)
                    cell.opponentAtBat.text = myIndex.name
                    cell.opponentHits.text = myIndex.name
                    cell.opponenthomeRun.text = myIndex.name
                    //                cell.opponentSacrificeHit.text = myIndex.pitcherBaseOnBallsCount
                    cell.opponentSacrificeFly.text = myIndex.name
                    cell.opponentFourBalls.text = myIndex.name
                    //                cell.opponentIntentionalWalk.text = myIndex.pitcherStrikeOutCount
                    cell.opponentHitByPitch.text = myIndex.name
                    cell.opponentStrikeOut.text = myIndex.name
                    cell.wildPitch.text = myIndex.name
                    cell.balk.text = myIndex.name
                    cell.lostPoint.text = myIndex.name
                    cell.earnedRun.text = myIndex.name
                    cell.inningCount.text = myIndex.name
                    cell.outCount.text = myIndex.name
//                }
                
                
                
                
                
                
                
                
                
                
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "pitcherStatsInfo", for: indexPath) as! StatsCompletionPitcherTableViewCell
                return cell
            }
            
        
            
            
            
        default:
            let cell : StatsCompletionBatterTableViewCell = batterStatsInfoTableView.dequeueReusableCell(withIdentifier: "batterStatsInfo", for: indexPath) as! StatsCompletionBatterTableViewCell
            return cell
        }
        
        
        
        
        
        
        
        
        
//        
//        
//        //원정팀
//        if teamSegmented.selectedSegmentIndex == 0{
//            if tableView == self.batterStatsInfoTableView{
//                cell = batterStatsInfoTableView.dequeueReusableCell(withIdentifier: "batterStatsInfo", for: indexPath) as! StatsCompletionBatterTableViewCell
//
////                cell = batterStatsInfoTableView.dequeueReusableCell(withIdentifier: "batterStatsInfo", for: indexPath)
//                
//                let myIndex = visitedTeam.mainLineupInfo[indexPath.row]
//                print("***** \(myIndex)")
//              
//                cell.batterUserName.text = myIndex.name //선수이름
////                cell!.detailTextLabel?.text = String(myIndex.timeAtBat)   //타석
////                cell!.detailTextLabel?.text = "1"//String(myIndex.timeAtBat)  //타수
//            }
//            
//            if tableView == self.pitcherStatsInfoTableView{
//                let myIndex = visitedTeam.mainLineupInfo[indexPath.row]
//                let myCell: StatsCompletionPitcherTableViewCell = pitcherStatsInfoTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! StatsCompletionPitcherTableViewCell
//
//                myCell.pitcheruserName.text = myIndex.name
//                
//                
                
                
                
                
                
//                cell = tableView.dequeueReusableCell(withIdentifier: "pitcherStatsInfo", for: indexPath)
//                
//                cell!.textLabel?.text = myIndex.name
//                cell!.detailTextLabel?.text = "1"
                
//            }
//        }
        //홈팀
//        else{
//            if tableView == self.batterStatsInfoTableView{
//                
//                cell = tableView.dequeueReusableCell(withIdentifier: "batterStatsInfo", for: indexPath)
//                
//                let myIndex = homeTeam.mainLineupInfo[indexPath.row]
//                print("***** \(myIndex)")
//                
//                cell!.textLabel?.text = myIndex.name //선수이름
//                cell!.detailTextLabel?.text = String(myIndex.timeAtBat)   //타석
//                cell!.detailTextLabel?.text = "1"//String(myIndex.timeAtBat)  //타수
//                
//                
//            }
//            
//            if tableView == self.pitcherStatsInfoTableView{
//                cell = tableView.dequeueReusableCell(withIdentifier: "pitcherStatsInfo", for: indexPath)
//                let myIndex = homeTeam.mainLineupInfo[indexPath.row]
//                cell!.textLabel?.text = myIndex.name
//                cell!.detailTextLabel?.text = "1"
//                
//            }
//            return cell!
//        }
        

    }
    
    
    
    @IBAction func clickCancel(_ sender: UIButton) {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    //보드 정보
    func record(){
        
    }
}
