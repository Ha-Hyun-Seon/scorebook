//
//  ChangeFielderMenuViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 2. 6..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit

class ChangeFielderMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var currentTeam : TeamInfo = TeamInfo()
    var selectedLineups = [Lineup]()
    var teamKind = "V"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getTeams()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedLineups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "changeTeamCell", for: indexPath) as! ChangePlayerTableViewCell
        
        cell.lblMemberNumber.text = self.selectedLineups[indexPath.row].memberNumber
        cell.lblMemberName.text = self.selectedLineups[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "changeTeamCell", for: indexPath) as! ChangePlayerTableViewCell
        let txt = self.selectedLineups[indexPath.row].name
        
        let alert = UIAlertController(title: "확인", message: txt, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getTeams(){
        let userDefaults = UserDefaults.standard
        if (UserDefaults.standard.object(forKey: "Teams") != nil){
            let decoded  = userDefaults.object(forKey: "Teams") as! Data
            let getTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [TeamInfo]
            
            if self.teamKind == "V" {
                self.currentTeam = getTeams.first(where : { $0.kind == "V" })!
            }
            else {
                self.currentTeam = getTeams.first(where : { $0.kind == "H" })!
            }
        }
        
        self.selectedLineups = self.currentTeam.lineupInfo
    }
}
