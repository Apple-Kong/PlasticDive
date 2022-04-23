//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import Foundation

protocol GUIDelegate {
    func nextLevel()
    func gameOver()
}

class GameManager {
    static let shared = GameManager()
    
    var delegate: GUIDelegate?
    
//    @Binding var isShowGameOver: Bool
    
    private init() { }
    
    private var currentLevel: Int = 1
    var nowPlaying: Bool = false
    private var trashCount: Int = 0
    var heart: Int = 3
    var score: Int = 0
    
    
    
    var interval: Double  {
        return 2 - Double(currentLevel) * 0.2
    }

    var howManyKind: Int {
        return 1 + currentLevel
    }
    
    var numOfTrash: Int {
        return 20 + currentLevel * 3
    }
    
    func correctTrash() {
        score += 100
    }
    
    func incorrectTrash() {
        self.heart -= 1
        if heart < 0 {
            self.endGame()
        }
    }
    
    func startGame() {
        print("DEBUG: GameManger starts game...")
        self.nowPlaying = true
        
    }
    
    func increaseTrashCount() {
        if trashCount >= numOfTrash {
            endGame()
        } else {
            trashCount = trashCount + 1
        }
    }
    
    
    func endGame() {
        print("DEBUG: GameManger ends game...")
        
        self.nowPlaying = false
        refreash()
        delegate?.gameOver()
    }
    
    func refreash() {
        trashCount = 0
        heart = 3
        score = 0
    }
}
