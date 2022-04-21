//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import Foundation

class GameManager {
    static let shared = GameManager()
    
    
    private init() { }
    
    private var currentLevel: Int = 1
    var nowPlaying: Bool = false
    private var trashCount: Int = 0
    private var heart: Int = 3
    
    
    
    var interval: Double  {
        return 2 - Double(currentLevel) * 0.2
    }

    var howManyKind: Int {
        return 1 + currentLevel
    }
    
    var numOfTrash: Int {
        return 7 + currentLevel * 3
    }
    
    func startGame() {
        self.nowPlaying = true
        trashCount = 0
    }
    
    func increaseTrashCount() {
        if trashCount >= numOfTrash {
            endGame()
        } else {
            trashCount = trashCount + 1
        }
    }
    
    
    func endGame() {
        self.nowPlaying = false
        trashCount = 0
    }
}
