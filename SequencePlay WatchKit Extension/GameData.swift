//
//  GameData.swift
//  SequencePlay WatchKit Extension
//
//  Created by Romil Parhwal on 2019-03-14.
//  Copyright © 2019 Romil Parhwal. All rights reserved.
//

import Foundation

class GameData{
    var gameType: Bool
    var name:String
    
    
    init() {
        self.gameType = false
        self.name = ""
    }
    
    func setGameType(_ gameType:Bool){
        self.gameType = gameType
    }
    
    func returnGameType()->Bool{
        return self.gameType
    }
    
    func setName(_ name:String){
        self.name = name
    }
    
    func getName()->String{
        return self.name
    }
}

var sharedInstance: GameData = GameData()
