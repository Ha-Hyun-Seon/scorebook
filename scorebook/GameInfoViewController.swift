//
//  GameInfoViewController.swift
//  scorebook
//
//  Created by Ha Hyunseon on 2017. 1. 12..
//  Copyright © 2017년 Ha Hyunseon. All rights reserved.
//

import UIKit



class GameInfoViewController: UIViewController {
    
    var teams : [TeamInfo] = [TeamInfo]()
    var visitedTeam : TeamInfo = TeamInfo()
    var homeTeam : TeamInfo = TeamInfo()
    var gameInfo = GameInfo()
    
    @IBOutlet weak var lblVisitTeam: UILabel!
    @IBOutlet weak var lblHomeTeam: UILabel!
    @IBOutlet weak var lblGameDate: UILabel!
    @IBOutlet weak var txtfStadiumName: UITextField!
    @IBOutlet weak var txtfWeatherInfo: UITextField!
    @IBOutlet weak var txtfTemperatureInfo: UITextField!
    @IBOutlet weak var txtfHumidityInfo: UITextField!
    @IBOutlet weak var txtfWindDirectionInfo: UITextField!
    @IBOutlet weak var txtfWindSpeedInfo: UITextField!
    @IBOutlet weak var txtfChiefUmpire: UITextField!
    @IBOutlet weak var txtfFirstUmpire: UITextField!
    @IBOutlet weak var txtfSecondUmpire: UITextField!
    @IBOutlet weak var txtfThirdUmpire: UITextField!
    @IBOutlet weak var txtfLeftLineUmpire: UITextField!
    @IBOutlet weak var txtfRightLineUmpire: UITextField!
    @IBOutlet weak var txtfFirstRecorder: UITextField!
    @IBOutlet weak var txtfSecondRecorder: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.r
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTeams()
        getGameInfo()
        settingGameInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.gameInfo.startDate == "" {
            let date: NSDate = NSDate()
            let df : DateFormatter = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            self.lblGameDate.text = df.string(from: date as Date)
        }
        else{
            self.lblGameDate.text = self.gameInfo.startDate
        }
        
        self.gameInfo.stadiumName = self.txtfStadiumName.text!
        self.gameInfo.startDate = self.lblGameDate.text!
        self.gameInfo.weatherInfo = self.txtfWeatherInfo.text!
        self.gameInfo.temperatureInfo = self.txtfTemperatureInfo.text!
        self.gameInfo.humidityInfo = self.txtfHumidityInfo.text!
        self.gameInfo.windDirectionInfo = self.txtfWindDirectionInfo.text!
        self.gameInfo.windSpeedInfo = self.txtfWindSpeedInfo.text!
        self.gameInfo.chiefUmpire = self.txtfChiefUmpire.text!
        self.gameInfo.firstUmpire = self.txtfFirstUmpire.text!
        self.gameInfo.secondUmpire = self.txtfSecondUmpire.text!
        self.gameInfo.thirdUmpire = self.txtfThirdUmpire.text!
        self.gameInfo.leftLineUmpire = self.txtfLeftLineUmpire.text!
        self.gameInfo.rightLineUmpire = self.txtfRightLineUmpire.text!
        self.gameInfo.firstRecorder = self.txtfFirstRecorder.text!
        self.gameInfo.secondRecorder = self.txtfSecondRecorder.text!
        
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.gameInfo)
        userDefaults.set(encodedData, forKey: "Game")
        userDefaults.synchronize()
    }
    
    func settingGameInfo(){
        
        print("game info setting")
        
        self.lblVisitTeam.text = self.visitedTeam.name
        self.lblHomeTeam.text = self.homeTeam.name
        
        // 일시
        if self.gameInfo.startDate == "" {
            let date: NSDate = NSDate()
            let df : DateFormatter = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            self.lblGameDate.text = df.string(from: date as Date)
        }
        else{
            self.lblGameDate.text = self.gameInfo.startDate
        }
        
        self.txtfStadiumName.text = self.gameInfo.stadiumName
        self.lblGameDate.text = self.gameInfo.startDate
        self.txtfWeatherInfo.text = self.gameInfo.weatherInfo
        self.txtfTemperatureInfo.text = self.gameInfo.temperatureInfo
        self.txtfHumidityInfo.text = self.gameInfo.humidityInfo
        self.txtfWindDirectionInfo.text = self.gameInfo.windDirectionInfo
        self.txtfWindSpeedInfo.text = self.gameInfo.windSpeedInfo
        self.txtfChiefUmpire.text = self.gameInfo.chiefUmpire
        self.txtfFirstUmpire.text = self.gameInfo.firstUmpire
        self.txtfSecondUmpire.text = self.gameInfo.secondUmpire
        self.txtfThirdUmpire.text = self.gameInfo.thirdUmpire
        self.txtfLeftLineUmpire.text = self.gameInfo.leftLineUmpire
        self.txtfRightLineUmpire.text = self.gameInfo.rightLineUmpire
        self.txtfFirstRecorder.text = self.gameInfo.firstRecorder
        self.txtfSecondRecorder.text = self.gameInfo.secondRecorder
    }
    
//    func completeGameInfo(){
//        
//        if self.gameInfo.startDate == "" {
//            let date: NSDate = NSDate()
//            let df : DateFormatter = DateFormatter()
//            df.dateFormat = "yyyy-MM-dd"
//            self.lblGameDate.text = df.string(from: date as Date)
//        }
//        else{
//            self.lblGameDate.text = self.gameInfo.startDate
//        }
//        
//        self.gameInfo.stadiumName = self.txtfStadiumName.text!
//        self.gameInfo.startDate = self.lblGameDate.text!
//        self.gameInfo.weatherInfo = self.txtfWeatherInfo.text!
//        self.gameInfo.temperatureInfo = self.txtfTemperatureInfo.text!
//        self.gameInfo.humidityInfo = self.txtfHumidityInfo.text!
//        self.gameInfo.windDirectionInfo = self.txtfWindDirectionInfo.text!
//        self.gameInfo.windSpeedInfo = self.txtfWindSpeedInfo.text!
//        self.gameInfo.chiefUmpire = self.txtfChiefUmpire.text!
//        self.gameInfo.firstUmpire = self.txtfFirstUmpire.text!
//        self.gameInfo.secondUmpire = self.txtfSecondUmpire.text!
//        self.gameInfo.thirdUmpire = self.txtfThirdUmpire.text!
//        self.gameInfo.leftLineUmpire = self.txtfLeftLineUmpire.text!
//        self.gameInfo.rightLineUmpire = self.txtfRightLineUmpire.text!
//        self.gameInfo.firstRecorder = self.txtfFirstRecorder.text!
//        self.gameInfo.secondRecorder = self.txtfSecondRecorder.text!
//        
//        let userDefaults = UserDefaults.standard
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.gameInfo)
//        userDefaults.set(encodedData, forKey: "Game")
//        userDefaults.synchronize()
//    }
    
    func getTeams(){
        
        print("game info teams")
        
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
        
        print("game info game")
        
        let userDefaults = UserDefaults.standard
        let game = userDefaults.data(forKey: "Game")
        self.gameInfo = (NSKeyedUnarchiver.unarchiveObject(with: game!) as? GameInfo)!
        
    }
   
}
