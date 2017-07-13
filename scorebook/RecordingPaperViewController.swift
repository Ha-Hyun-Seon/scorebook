
//
//  RecordingPaperViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 3. 14..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit

class RecordingPaperViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
//    var visitedTeam : TeamInfo = TeamInfo()
//    var homeTeam : TeamInfo = TeamInfo()
    var currentTeam : TeamInfo = TeamInfo()
    var teamKind = "V"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.scrollView.contentSize = CGSize(width: 3570, height: 798)
        
        getTeams()
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
            let getTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [TeamInfo]
            
            
//            self.homeTeam = getTeams.first(where : { $0.kind == "H" })!
//            self.visitedTeam = getTeams.first(where : { $0.kind == "V" })!
            
            if self.teamKind == "V" {
                self.currentTeam = getTeams.first(where : { $0.kind == "V" })!
            }
            else {
                self.currentTeam = getTeams.first(where : { $0.kind == "H" })!
            }
        }
        
        print(self.currentTeam.inningInfo)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "recordHeaderCell") as! RecordPaperHeaderTableViewCell
        
        headerCell.lblTeamName.text = self.currentTeam.name
        
        // button Action
        headerCell.btnFirstInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnSecondInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnThirdInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnFourthInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnFifthInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnSixthInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnSeventhInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnEighthInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnNinthInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnTenthInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnEleventhInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnTwelfthInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnThirteenthInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnFourteenthInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        headerCell.btnFifteenthInning.addTarget(self, action: #selector(RecordingPaperViewController.modifyInningInfo(sender:)), for: .touchUpInside)
        
        return headerCell
    }
    
    func modifyInningInfo(sender: UIButton!) {
        print(sender.titleLabel?.text ?? "")
        
        let txt = "button label : " + (sender.titleLabel?.text)!
        
        let alert = UIAlertController(title: "확인", message: txt, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.currentTeam.mainLineupInfo.count
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordPaperCell", for: indexPath) as! RecordPaperBodyTableViewCell
        
        let rowNumber = indexPath.row
        
        if self.currentTeam.name != "" && self.currentTeam.mainLineupInfo.count > 0 {
            //1번 - 9번
            let lineup : Lineup = self.currentTeam.mainLineupInfo[rowNumber]
            cell.lblRunnerName.text = lineup.name
            cell.lblAlternativeRunnerFirst.text = ""
            cell.lblAlternativeRunnerSecond.text = ""
            // 1이닝
            let inningImageViewFirst:[UIImageView] = [cell.ivPitcherRecord1, cell.ivPitcherRecord2, cell.ivPitcherRecord3, cell.ivPitcherRecord4, cell.ivPitcherRecord5, cell.ivPitcherRecord6, cell.ivPitcherRecord7, cell.ivPitcherRecord8]
            let inningBatterImageViewFirst:[UIImageView] = [cell.ivBatterRecord1, cell.ivBatterRecord2, cell.ivBatterRecord3, cell.ivBatterRecord4, cell.ivBatterRecord5]
            let inningBatterLabelFirst:[UILabel] = [cell.lblBatterRecord1, cell.lblBatterRecord2, cell.lblBatterRecord3, cell.lblBatterRecord4]
            // 2이닝
            let inningImageViewSecond:[UIImageView] = [cell.ivPitcherRecord21, cell.ivPitcherRecord22, cell.ivPitcherRecord23, cell.ivPitcherRecord24, cell.ivPitcherRecord25, cell.ivPitcherRecord26, cell.ivPitcherRecord27, cell.ivPitcherRecord28]
            let inningBatterImageViewSecond:[UIImageView] = [cell.ivBatterRecord21, cell.ivBatterRecord22, cell.ivBatterRecord23, cell.ivBatterRecord24, cell.ivBatterRecord25]
            let inningBatterLabelSecond:[UILabel] = [cell.lblBatterRecord21, cell.lblBatterRecord22, cell.lblBatterRecord23, cell.lblBatterRecord24]
            // 3이닝
            let inningImageViewThird:[UIImageView] = [cell.ivPitcherRecord31, cell.ivPitcherRecord32, cell.ivPitcherRecord33, cell.ivPitcherRecord34, cell.ivPitcherRecord35, cell.ivPitcherRecord36, cell.ivPitcherRecord37, cell.ivPitcherRecord38]
            let inningBatterImageViewThird:[UIImageView] = [cell.ivBatterRecord31, cell.ivBatterRecord32, cell.ivBatterRecord33, cell.ivBatterRecord34, cell.ivBatterRecord35]
            let inningBatterLabelThird:[UILabel] = [cell.lblBatterRecord31, cell.lblBatterRecord32, cell.lblBatterRecord33, cell.lblBatterRecord34]
            // 4이닝
            let inningImageViewFourth:[UIImageView] = [cell.ivPitcherRecord41, cell.ivPitcherRecord42, cell.ivPitcherRecord43, cell.ivPitcherRecord44, cell.ivPitcherRecord45, cell.ivPitcherRecord46, cell.ivPitcherRecord47, cell.ivPitcherRecord48]
            let inningBatterImageViewFourth:[UIImageView] = [cell.ivBatterRecord41, cell.ivBatterRecord42, cell.ivBatterRecord43, cell.ivBatterRecord44, cell.ivBatterRecord45]
            let inningBatterLabelFourth:[UILabel] = [cell.lblBatterRecord41, cell.lblBatterRecord42, cell.lblBatterRecord43, cell.lblBatterRecord44]
            // 5이닝
            let inningImageViewFifth:[UIImageView] = [cell.ivPitcherRecord51, cell.ivPitcherRecord52, cell.ivPitcherRecord53, cell.ivPitcherRecord54, cell.ivPitcherRecord55, cell.ivPitcherRecord56, cell.ivPitcherRecord57, cell.ivPitcherRecord58]
            let inningBatterImageViewFifth:[UIImageView] = [cell.ivBatterRecord51, cell.ivBatterRecord52, cell.ivBatterRecord53, cell.ivBatterRecord54, cell.ivBatterRecord55]
            let inningBatterLabelFifth:[UILabel] = [cell.lblBatterRecord51, cell.lblBatterRecord52, cell.lblBatterRecord53, cell.lblBatterRecord54]
            // 6이닝
            let inningImageViewSixth:[UIImageView] = [cell.ivPitcherRecord61, cell.ivPitcherRecord62, cell.ivPitcherRecord63, cell.ivPitcherRecord64, cell.ivPitcherRecord65, cell.ivPitcherRecord66, cell.ivPitcherRecord67, cell.ivPitcherRecord68]
            let inningBatterImageViewSixth:[UIImageView] = [cell.ivBatterRecord61, cell.ivBatterRecord62, cell.ivBatterRecord63, cell.ivBatterRecord64, cell.ivBatterRecord65]
            let inningBatterLabelSixth:[UILabel] = [cell.lblBatterRecord61, cell.lblBatterRecord62, cell.lblBatterRecord63, cell.lblBatterRecord64]
            // 7이닝
            let inningImageViewSeventh:[UIImageView] = [cell.ivPitcherRecord71, cell.ivPitcherRecord72, cell.ivPitcherRecord73, cell.ivPitcherRecord74, cell.ivPitcherRecord75, cell.ivPitcherRecord76, cell.ivPitcherRecord77, cell.ivPitcherRecord78]
            let inningBatterImageViewSeventh:[UIImageView] = [cell.ivBatterRecord71, cell.ivBatterRecord72, cell.ivBatterRecord73, cell.ivBatterRecord74, cell.ivBatterRecord75]
            let inningBatterLabelSeventh:[UILabel] = [cell.lblBatterRecord71, cell.lblBatterRecord72, cell.lblBatterRecord73, cell.lblBatterRecord74]
            // 8이닝
            let inningImageViewEighth:[UIImageView] = [cell.ivPitcherRecord81, cell.ivPitcherRecord82, cell.ivPitcherRecord83, cell.ivPitcherRecord84, cell.ivPitcherRecord85, cell.ivPitcherRecord86, cell.ivPitcherRecord87, cell.ivPitcherRecord88]
            let inningBatterImageViewEighth:[UIImageView] = [cell.ivBatterRecord81, cell.ivBatterRecord82, cell.ivBatterRecord83, cell.ivBatterRecord84, cell.ivBatterRecord85]
            let inningBatterLabelEighth:[UILabel] = [cell.lblBatterRecord81, cell.lblBatterRecord82, cell.lblBatterRecord83, cell.lblBatterRecord84]
            // 9이닝
            let inningImageViewNinth:[UIImageView] = [cell.ivPitcherRecord91, cell.ivPitcherRecord92, cell.ivPitcherRecord93, cell.ivPitcherRecord94, cell.ivPitcherRecord95, cell.ivPitcherRecord96, cell.ivPitcherRecord97, cell.ivPitcherRecord98]
            let inningBatterImageViewNinth:[UIImageView] = [cell.ivBatterRecord91, cell.ivBatterRecord92, cell.ivBatterRecord93, cell.ivBatterRecord94, cell.ivBatterRecord95]
            let inningBatterLabelNinth:[UILabel] = [cell.lblBatterRecord91, cell.lblBatterRecord92, cell.lblBatterRecord93, cell.lblBatterRecord94]
            // 10이닝
            let inningImageViewTenth:[UIImageView] = [cell.ivPitcherRecord101, cell.ivPitcherRecord102, cell.ivPitcherRecord103, cell.ivPitcherRecord104, cell.ivPitcherRecord105, cell.ivPitcherRecord106, cell.ivPitcherRecord107, cell.ivPitcherRecord108]
            let inningBatterImageViewTenth:[UIImageView] = [cell.ivBatterRecord101, cell.ivBatterRecord102, cell.ivBatterRecord103, cell.ivBatterRecord104, cell.ivBatterRecord105]
            let inningBatterLabelTenth:[UILabel] = [cell.lblBatterRecord101, cell.lblBatterRecord102, cell.lblBatterRecord103, cell.lblBatterRecord104]
            // 11이닝
            let inningImageViewEleventh:[UIImageView] = [cell.ivPitcherRecord111, cell.ivPitcherRecord112, cell.ivPitcherRecord113, cell.ivPitcherRecord114, cell.ivPitcherRecord115, cell.ivPitcherRecord116, cell.ivPitcherRecord117, cell.ivPitcherRecord118]
            let inningBatterImageViewEleventh:[UIImageView] = [cell.ivBatterRecord111, cell.ivBatterRecord112, cell.ivBatterRecord113, cell.ivBatterRecord114, cell.ivBatterRecord115]
            let inningBatterLabelEleventh:[UILabel] = [cell.lblBatterRecord111, cell.lblBatterRecord112, cell.lblBatterRecord113, cell.lblBatterRecord114]
            // 12이닝
            let inningImageViewTwelfth:[UIImageView] = [cell.ivPitcherRecord121, cell.ivPitcherRecord122, cell.ivPitcherRecord123, cell.ivPitcherRecord124, cell.ivPitcherRecord125, cell.ivPitcherRecord126, cell.ivPitcherRecord127, cell.ivPitcherRecord128]
            let inningBatterImageViewTwelfth:[UIImageView] = [cell.ivBatterRecord121, cell.ivBatterRecord122, cell.ivBatterRecord123, cell.ivBatterRecord124, cell.ivBatterRecord125]
            let inningBatterLabelTwelfth:[UILabel] = [cell.lblBatterRecord121, cell.lblBatterRecord122, cell.lblBatterRecord123, cell.lblBatterRecord124]
            // 13이닝
            let inningImageViewThirteenth:[UIImageView] = [cell.ivPitcherRecord131, cell.ivPitcherRecord132, cell.ivPitcherRecord133, cell.ivPitcherRecord134, cell.ivPitcherRecord135, cell.ivPitcherRecord136, cell.ivPitcherRecord137, cell.ivPitcherRecord138]
            let inningBatterImageViewThirteenth:[UIImageView] = [cell.ivBatterRecord131, cell.ivBatterRecord132, cell.ivBatterRecord133, cell.ivBatterRecord134, cell.ivBatterRecord135]
            let inningBatterLabelThirteenth:[UILabel] = [cell.lblBatterRecord131, cell.lblBatterRecord132, cell.lblBatterRecord133, cell.lblBatterRecord134]
            // 14이닝
            let inningImageViewFourteenth:[UIImageView] = [cell.ivPitcherRecord141, cell.ivPitcherRecord142, cell.ivPitcherRecord143, cell.ivPitcherRecord144, cell.ivPitcherRecord145, cell.ivPitcherRecord146, cell.ivPitcherRecord147, cell.ivPitcherRecord148]
            let inningBatterImageViewFourteenth:[UIImageView] = [cell.ivBatterRecord141, cell.ivBatterRecord142, cell.ivBatterRecord143, cell.ivBatterRecord144, cell.ivBatterRecord145]
            let inningBatterLabelFourteenth:[UILabel] = [cell.lblBatterRecord141, cell.lblBatterRecord142, cell.lblBatterRecord143, cell.lblBatterRecord144]
            // 15이닝
            let inningImageViewFifteenth:[UIImageView] = [cell.ivPitcherRecord151, cell.ivPitcherRecord152, cell.ivPitcherRecord153, cell.ivPitcherRecord154, cell.ivPitcherRecord155, cell.ivPitcherRecord156, cell.ivPitcherRecord157, cell.ivPitcherRecord158]
            let inningBatterImageViewFifteenth:[UIImageView] = [cell.ivBatterRecord151, cell.ivBatterRecord152, cell.ivBatterRecord153, cell.ivBatterRecord154, cell.ivBatterRecord155]
            let inningBatterLabelFifteenth:[UILabel] = [cell.lblBatterRecord151, cell.lblBatterRecord152, cell.lblBatterRecord153, cell.lblBatterRecord154]
            
            //1회
            //        imageName = "RV_bcount_off_img.png"
            //        let image: UIImage = UIImage(named: imageName)!
            //        cell.textLabel?.text = self.currentTeam.inningInfo[0].hRecord[rowNumber].homeRecordImage
            //        cell.textLabel?.text = self.currentTeam.inningInfo[0].hRecord[rowNumber].oneRecordImage
            
            for inningIndex in 0...14 {
                // 초기화
                switch inningIndex {
                case 0:
                    for collectionIndex in 0...inningImageViewFirst.count - 1 {
                        inningImageViewFirst[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewFirst.count - 1 {
                        inningBatterImageViewFirst[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelFirst.count - 1 {
                        inningBatterLabelFirst[collectionIndex].text = ""
                    }
                case 1:
                    for collectionIndex in 0...inningImageViewSecond.count - 1 {
                        inningImageViewSecond[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewSecond.count - 1 {
                        inningBatterImageViewSecond[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelSecond.count - 1 {
                        inningBatterLabelSecond[collectionIndex].text = ""
                    }
                case 2:
                    for collectionIndex in 0...inningImageViewThird.count - 1 {
                        inningImageViewThird[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewThird.count - 1 {
                        inningBatterImageViewThird[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelThird.count - 1 {
                        inningBatterLabelThird[collectionIndex].text = ""
                    }
                case 3:
                    for collectionIndex in 0...inningImageViewFourth.count - 1 {
                        inningImageViewFourth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewFourth.count - 1 {
                        inningBatterImageViewFourth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelFourth.count - 1 {
                        inningBatterLabelFourth[collectionIndex].text = ""
                    }
                case 4:
                    for collectionIndex in 0...inningImageViewFifth.count - 1 {
                        inningImageViewFifth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewFifth.count - 1 {
                        inningBatterImageViewFifth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelFifth.count - 1 {
                        inningBatterLabelFifth[collectionIndex].text = ""
                    }
                case 5:
                    for collectionIndex in 0...inningImageViewSixth.count - 1 {
                        inningImageViewSixth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewSixth.count - 1 {
                        inningBatterImageViewSixth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelSixth.count - 1 {
                        inningBatterLabelSixth[collectionIndex].text = ""
                    }
                case 6:
                    for collectionIndex in 0...inningImageViewSeventh.count - 1 {
                        inningImageViewSeventh[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewSeventh.count - 1 {
                        inningBatterImageViewSeventh[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelSeventh.count - 1 {
                        inningBatterLabelSeventh[collectionIndex].text = ""
                    }
                case 7:
                    for collectionIndex in 0...inningImageViewEighth.count - 1 {
                        inningImageViewEighth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewEighth.count - 1 {
                        inningBatterImageViewEighth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelEighth.count - 1 {
                        inningBatterLabelEighth[collectionIndex].text = ""
                    }
                case 8:
                    for collectionIndex in 0...inningImageViewNinth.count - 1 {
                        inningImageViewNinth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewNinth.count - 1 {
                        inningBatterImageViewNinth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelNinth.count - 1 {
                        inningBatterLabelNinth[collectionIndex].text = ""
                    }
                case 9:
                    for collectionIndex in 0...inningImageViewTenth.count - 1 {
                        inningImageViewTenth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewTenth.count - 1 {
                        inningBatterImageViewTenth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelTenth.count - 1 {
                        inningBatterLabelTenth[collectionIndex].text = ""
                    }
                case 10:
                    for collectionIndex in 0...inningImageViewEleventh.count - 1 {
                        inningImageViewEleventh[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewEleventh.count - 1 {
                        inningBatterImageViewEleventh[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelEleventh.count - 1 {
                        inningBatterLabelEleventh[collectionIndex].text = ""
                    }
                case 11:
                    for collectionIndex in 0...inningImageViewTwelfth.count - 1 {
                        inningImageViewTwelfth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewTwelfth.count - 1 {
                        inningBatterImageViewTwelfth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelTwelfth.count - 1 {
                        inningBatterLabelTwelfth[collectionIndex].text = ""
                    }
                case 12:
                    for collectionIndex in 0...inningImageViewThirteenth.count - 1 {
                        inningImageViewThirteenth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewThirteenth.count - 1 {
                        inningBatterImageViewThirteenth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelThirteenth.count - 1 {
                        inningBatterLabelThirteenth[collectionIndex].text = ""
                    }
                case 13:
                    for collectionIndex in 0...inningImageViewFourteenth.count - 1 {
                        inningImageViewFourteenth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewFourteenth.count - 1 {
                        inningBatterImageViewFourteenth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelFourteenth.count - 1 {
                        inningBatterLabelFourteenth[collectionIndex].text = ""
                    }
                case 14:
                    for collectionIndex in 0...inningImageViewFifteenth.count - 1 {
                        inningImageViewFifteenth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterImageViewFifteenth.count - 1 {
                        inningBatterImageViewFifteenth[collectionIndex].image = nil
                    }
                    for collectionIndex in 0...inningBatterLabelFifteenth.count - 1 {
                        inningBatterLabelFifteenth[collectionIndex].text = ""
                    }
                default:
                    break
                }
                
                if self.currentTeam.inningInfo.count > 0 {
                    
                    // lineup의 이름을 찾기 위해 1차 배열로 다시 다시 정의
                    let arry : [String] = self.currentTeam.inningInfo[inningIndex].hRecord.flatMap { $0.name }
                    let indexOfA = arry.index(of: lineup.name)
                    
                    if indexOfA != nil {
                        
                        let recordFirstMember : HRecordInfo = self.currentTeam.inningInfo[inningIndex].hRecord.first(where : { $0.name == lineup.name })!
                        
                        if recordFirstMember.name != "" && recordFirstMember.name == lineup.name {
                            
                            let recordFirst = self.currentTeam.inningInfo[inningIndex].hRecord
                            var recordFirstCount = recordFirst.count
                            if recordFirstCount > 0 {
                                recordFirstCount = recordFirstCount - 1
                            }
                            
                            for index in 0...recordFirstCount {
                                
                                let hrecord = recordFirst[index].pitcherRecord
                                var hrecordCount = hrecord.count
                                if hrecordCount > 0 {
                                    hrecordCount = hrecordCount - 1
                                }
                                
                                if recordFirst[index].name == lineup.name {
                                    
                                    if recordFirst[index].homeRecordImage != "" {
                                        switch inningIndex {
                                        case 0:
                                            cell.ivBatterRecord1.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 1:
                                            cell.ivBatterRecord21.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 2:
                                            cell.ivBatterRecord31.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 3:
                                            cell.ivBatterRecord41.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 4:
                                            cell.ivBatterRecord51.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 5:
                                            cell.ivBatterRecord61.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 6:
                                            cell.ivBatterRecord71.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 7:
                                            cell.ivBatterRecord81.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 8:
                                            cell.ivBatterRecord91.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 9:
                                            cell.ivBatterRecord101.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 10:
                                            cell.ivBatterRecord111.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 11:
                                            cell.ivBatterRecord121.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 12:
                                            cell.ivBatterRecord131.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 13:
                                            cell.ivBatterRecord141.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        case 14:
                                            cell.ivBatterRecord151.image = UIImage(named: recordFirst[index].homeRecordImage)
                                        default:
                                            break
                                        }
                                    }
                                    if recordFirst[index].oneRecordImage != "" {
                                        switch inningIndex {
                                        case 0:
                                            cell.ivBatterRecord2.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 1:
                                            cell.ivBatterRecord22.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 2:
                                            cell.ivBatterRecord32.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 3:
                                            cell.ivBatterRecord42.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 4:
                                            cell.ivBatterRecord52.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 5:
                                            cell.ivBatterRecord62.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 6:
                                            cell.ivBatterRecord72.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 7:
                                            cell.ivBatterRecord82.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 8:
                                            cell.ivBatterRecord92.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 9:
                                            cell.ivBatterRecord102.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 10:
                                            cell.ivBatterRecord112.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 11:
                                            cell.ivBatterRecord122.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 12:
                                            cell.ivBatterRecord132.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 13:
                                            cell.ivBatterRecord142.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        case 14:
                                            cell.ivBatterRecord152.image = UIImage(named: recordFirst[index].oneRecordImage)
                                        default:
                                            break
                                        }
                                    }
                                    if recordFirst[index].twoRecordImage != "" {
                                        switch inningIndex {
                                        case 0:
                                            cell.ivBatterRecord3.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 1:
                                            cell.ivBatterRecord23.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 2:
                                            cell.ivBatterRecord33.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 3:
                                            cell.ivBatterRecord43.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 4:
                                            cell.ivBatterRecord53.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 5:
                                            cell.ivBatterRecord63.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 6:
                                            cell.ivBatterRecord73.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 7:
                                            cell.ivBatterRecord83.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 8:
                                            cell.ivBatterRecord93.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 9:
                                            cell.ivBatterRecord103.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 10:
                                            cell.ivBatterRecord113.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 11:
                                            cell.ivBatterRecord123.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 12:
                                            cell.ivBatterRecord133.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 13:
                                            cell.ivBatterRecord143.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        case 14:
                                            cell.ivBatterRecord153.image = UIImage(named: recordFirst[index].twoRecordImage)
                                        default:
                                            break
                                        }
                                    }
                                    if recordFirst[index].threeRecordImage != "" {
                                        switch inningIndex {
                                        case 0:
                                            cell.ivBatterRecord4.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 1:
                                            cell.ivBatterRecord24.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 2:
                                            cell.ivBatterRecord34.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 3:
                                            cell.ivBatterRecord44.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 4:
                                            cell.ivBatterRecord54.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 5:
                                            cell.ivBatterRecord64.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 6:
                                            cell.ivBatterRecord74.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 7:
                                            cell.ivBatterRecord84.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 8:
                                            cell.ivBatterRecord94.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 9:
                                            cell.ivBatterRecord104.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 10:
                                            cell.ivBatterRecord114.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 11:
                                            cell.ivBatterRecord124.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 12:
                                            cell.ivBatterRecord134.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 13:
                                            cell.ivBatterRecord144.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        case 14:
                                            cell.ivBatterRecord154.image = UIImage(named: recordFirst[index].threeRecordImage)
                                        default:
                                            break
                                        }
                                    }
                                    if recordFirst[index].centerRecordImage != "" {
                                        switch inningIndex {
                                        case 0:
                                            cell.ivBatterRecord5.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 1:
                                            cell.ivBatterRecord25.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 2:
                                            cell.ivBatterRecord35.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 3:
                                            cell.ivBatterRecord45.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 4:
                                            cell.ivBatterRecord55.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 5:
                                            cell.ivBatterRecord65.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 6:
                                            cell.ivBatterRecord75.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 7:
                                            cell.ivBatterRecord85.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 8:
                                            cell.ivBatterRecord95.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 9:
                                            cell.ivBatterRecord105.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 10:
                                            cell.ivBatterRecord115.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 11:
                                            cell.ivBatterRecord125.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 12:
                                            cell.ivBatterRecord135.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 13:
                                            cell.ivBatterRecord145.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        case 14:
                                            cell.ivBatterRecord155.image = UIImage(named: recordFirst[index].centerRecordImage)
                                        default:
                                            break
                                        }
                                    }
                                    
                                    if recordFirst[index].homeRecordText != "" {
                                        switch inningIndex {
                                        case 0:
                                            cell.lblBatterRecord1.text = recordFirst[index].homeRecordText
                                        case 1:
                                            cell.lblBatterRecord21.text = recordFirst[index].homeRecordText
                                        case 2:
                                            cell.lblBatterRecord31.text = recordFirst[index].homeRecordText
                                        case 3:
                                            cell.lblBatterRecord41.text = recordFirst[index].homeRecordText
                                        case 4:
                                            cell.lblBatterRecord51.text = recordFirst[index].homeRecordText
                                        case 5:
                                            cell.lblBatterRecord61.text = recordFirst[index].homeRecordText
                                        case 6:
                                            cell.lblBatterRecord71.text = recordFirst[index].homeRecordText
                                        case 7:
                                            cell.lblBatterRecord81.text = recordFirst[index].homeRecordText
                                        case 8:
                                            cell.lblBatterRecord91.text = recordFirst[index].homeRecordText
                                        case 9:
                                            cell.lblBatterRecord101.text = recordFirst[index].homeRecordText
                                        case 10:
                                            cell.lblBatterRecord111.text = recordFirst[index].homeRecordText
                                        case 11:
                                            cell.lblBatterRecord121.text = recordFirst[index].homeRecordText
                                        case 12:
                                            cell.lblBatterRecord131.text = recordFirst[index].homeRecordText
                                        case 13:
                                            cell.lblBatterRecord141.text = recordFirst[index].homeRecordText
                                        case 14:
                                            cell.lblBatterRecord151.text = recordFirst[index].homeRecordText
                                        default:
                                            break
                                        }
                                    }
                                    if recordFirst[index].oneRecordText != "" {
                                        switch inningIndex {
                                        case 0:
                                            cell.lblBatterRecord2.text = recordFirst[index].oneRecordText
                                        case 1:
                                            cell.lblBatterRecord22.text = recordFirst[index].oneRecordText
                                        case 2:
                                            cell.lblBatterRecord32.text = recordFirst[index].oneRecordText
                                        case 3:
                                            cell.lblBatterRecord42.text = recordFirst[index].oneRecordText
                                        case 4:
                                            cell.lblBatterRecord52.text = recordFirst[index].oneRecordText
                                        case 5:
                                            cell.lblBatterRecord62.text = recordFirst[index].oneRecordText
                                        case 6:
                                            cell.lblBatterRecord72.text = recordFirst[index].oneRecordText
                                        case 7:
                                            cell.lblBatterRecord82.text = recordFirst[index].oneRecordText
                                        case 8:
                                            cell.lblBatterRecord92.text = recordFirst[index].oneRecordText
                                        case 9:
                                            cell.lblBatterRecord102.text = recordFirst[index].oneRecordText
                                        case 10:
                                            cell.lblBatterRecord112.text = recordFirst[index].oneRecordText
                                        case 11:
                                            cell.lblBatterRecord122.text = recordFirst[index].oneRecordText
                                        case 12:
                                            cell.lblBatterRecord132.text = recordFirst[index].oneRecordText
                                        case 13:
                                            cell.lblBatterRecord142.text = recordFirst[index].oneRecordText
                                        case 14:
                                            cell.lblBatterRecord152.text = recordFirst[index].oneRecordText
                                        default:
                                            break
                                        }
                                    }
                                    if recordFirst[index].twoRecordText != "" {
                                        switch inningIndex {
                                        case 0:
                                            cell.lblBatterRecord3.text = recordFirst[index].twoRecordText
                                        case 1:
                                            cell.lblBatterRecord23.text = recordFirst[index].twoRecordText
                                        case 2:
                                            cell.lblBatterRecord33.text = recordFirst[index].twoRecordText
                                        case 3:
                                            cell.lblBatterRecord43.text = recordFirst[index].twoRecordText
                                        case 4:
                                            cell.lblBatterRecord53.text = recordFirst[index].twoRecordText
                                        case 5:
                                            cell.lblBatterRecord63.text = recordFirst[index].twoRecordText
                                        case 6:
                                            cell.lblBatterRecord73.text = recordFirst[index].twoRecordText
                                        case 7:
                                            cell.lblBatterRecord83.text = recordFirst[index].twoRecordText
                                        case 8:
                                            cell.lblBatterRecord93.text = recordFirst[index].twoRecordText
                                        case 9:
                                            cell.lblBatterRecord103.text = recordFirst[index].twoRecordText
                                        case 10:
                                            cell.lblBatterRecord113.text = recordFirst[index].twoRecordText
                                        case 11:
                                            cell.lblBatterRecord123.text = recordFirst[index].twoRecordText
                                        case 12:
                                            cell.lblBatterRecord133.text = recordFirst[index].twoRecordText
                                        case 13:
                                            cell.lblBatterRecord143.text = recordFirst[index].twoRecordText
                                        case 14:
                                            cell.lblBatterRecord153.text = recordFirst[index].twoRecordText
                                        default:
                                            break
                                        }
                                    }
                                    if recordFirst[index].threeRecordText != "" {
                                        switch inningIndex {
                                        case 0:
                                            cell.lblBatterRecord4.text = recordFirst[index].threeRecordText
                                        case 1:
                                            cell.lblBatterRecord24.text = recordFirst[index].threeRecordText
                                        case 2:
                                            cell.lblBatterRecord34.text = recordFirst[index].threeRecordText
                                        case 3:
                                            cell.lblBatterRecord44.text = recordFirst[index].threeRecordText
                                        case 4:
                                            cell.lblBatterRecord54.text = recordFirst[index].threeRecordText
                                        case 5:
                                            cell.lblBatterRecord64.text = recordFirst[index].threeRecordText
                                        case 6:
                                            cell.lblBatterRecord74.text = recordFirst[index].threeRecordText
                                        case 7:
                                            cell.lblBatterRecord84.text = recordFirst[index].threeRecordText
                                        case 8:
                                            cell.lblBatterRecord94.text = recordFirst[index].threeRecordText
                                        case 9:
                                            cell.lblBatterRecord104.text = recordFirst[index].threeRecordText
                                        case 10:
                                            cell.lblBatterRecord114.text = recordFirst[index].threeRecordText
                                        case 11:
                                            cell.lblBatterRecord124.text = recordFirst[index].threeRecordText
                                        case 12:
                                            cell.lblBatterRecord134.text = recordFirst[index].threeRecordText
                                        case 13:
                                            cell.lblBatterRecord144.text = recordFirst[index].threeRecordText
                                        case 14:
                                            cell.lblBatterRecord154.text = recordFirst[index].threeRecordText
                                        default:
                                            break
                                        }
                                    }
                                    
                                    for rindex in 0...hrecordCount {
                                        
                                        if recordFirst[index].pitcherRecordImage.count > 0 {
                                            
                                            switch inningIndex {
                                            case 0:
                                                inningImageViewFirst[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 1:
                                                inningImageViewSecond[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 2:
                                                inningImageViewThird[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 3:
                                                inningImageViewFourth[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 4:
                                                inningImageViewFifth[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 5:
                                                inningImageViewSixth[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 6:
                                                inningImageViewSeventh[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 7:
                                                inningImageViewEighth[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 8:
                                                inningImageViewNinth[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 9:
                                                inningImageViewTenth[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 10:
                                                inningImageViewEleventh[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 11:
                                                inningImageViewTwelfth[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 12:
                                                inningImageViewThirteenth[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 13:
                                                inningImageViewFourteenth[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            case 14:
                                                inningImageViewFifteenth[rindex].image = UIImage(named: recordFirst[index].pitcherRecordImage[rindex])
                                            default: break
                                                
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
        //        let recordFirst = self.currentTeam.inningInfo[0].hRecord
        //        for index in 0...recordFirst.count {
        //            inningImageViewFirst[index].image = UIImage(named: recordFirst[index].pitcherRecordImage[0])
        //        }
        
        /*
         if self.currentTeam.inningInfo.count > 0 {
         let recordFirst : HRecordInfo = self.currentTeam.inningInfo[0].hRecord.first(where : { $0.name == lineup.name })!
         if recordFirst.name != "" {
         cell.textLabel?.text = recordFirst.homeRecordImage
         }
         
         if recordFirst.pitcherRecordImage[0] != "" {
         cell.ivPitcherRecord1.image = UIImage(named: recordFirst.pitcherRecordImage[0])
         }
         else{
         cell.ivPitcherRecord1.image = nil
         }
         if recordFirst.pitcherRecordImage[1] != "" {
         cell.ivPitcherRecord2.image = UIImage(named: recordFirst.pitcherRecordImage[1])
         }
         else{
         cell.ivPitcherRecord2.image = nil
         }
         if recordFirst.pitcherRecordImage[2] != "" {
         cell.ivPitcherRecord3.image = UIImage(named: recordFirst.pitcherRecordImage[2])
         }
         else{
         cell.ivPitcherRecord3.image = nil
         }
         if recordFirst.pitcherRecordImage[3] != "" {
         cell.ivPitcherRecord4.image = UIImage(named: recordFirst.pitcherRecordImage[3])
         }
         else{
         cell.ivPitcherRecord4.image = nil
         }
         if recordFirst.pitcherRecordImage[4] != "" {
         cell.ivPitcherRecord5.image = UIImage(named: recordFirst.pitcherRecordImage[4])
         }
         else{
         cell.ivPitcherRecord5.image = nil
         }
         if recordFirst.pitcherRecordImage[5] != "" {
         cell.ivPitcherRecord6.image = UIImage(named: recordFirst.pitcherRecordImage[5])
         }
         else{
         cell.ivPitcherRecord6.image = nil
         }
         if recordFirst.pitcherRecordImage[6] != "" {
         cell.ivPitcherRecord7.image = UIImage(named: recordFirst.pitcherRecordImage[6])
         }
         else{
         cell.ivPitcherRecord7.image = nil
         }
         if recordFirst.pitcherRecordImage[7] != "" {
         cell.ivPitcherRecord8.image = UIImage(named: recordFirst.pitcherRecordImage[7])
         }
         else{
         cell.ivPitcherRecord8.image = nil
         }
         
         
         
         //2회
         let record : HRecordInfo = self.homeTeam.inningInfo[1].hRecord.first(where : { $0.name == lineup.name })!
         if record.name != "" {
         cell.textLabel?.text = record.homeRecordImage
         }
         
         
         //3회
         cell.textLabel?.text = self.homeTeam.inningInfo[2].hRecord[0].homeRecordImage
         
         
         
         
         //4회
         cell.textLabel?.text = self.homeTeam.inningInfo[3].hRecord[0].homeRecordImage
         }
         */
        
        return cell
    }
    
}
