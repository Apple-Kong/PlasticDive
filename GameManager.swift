//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import Foundation

protocol UIDelegate {
    func nextLevel(level: Int)
    func gameOver()
}

class GameManager {
    static let shared = GameManager()
    
    var uiDelegate: UIDelegate?
    var guiDelegate: GUIDelegate?
    

    
    
//    @Binding var isShowGameOver: Bool
    
    private init() { }
    
    var currentLevel: Int = 1
    var nowPlaying: Bool = false
    private var trashCount: Int = 0
    var score: Int = 0
    var historyScore: Int = 0
    var isFever: Bool = false
    
    
    
    var interval: Double  {
        return 0.5
    }

    var howManyKind: Int {
        return 1 + currentLevel
    }
    
    var numOfTrash: Int {
        if isFever {
            return 5
        } else {
            return 2
        }
    }
    
    func correctTrash() {
        score += 100
    }
    
    
    func startGame() {
        print("DEBUG: GameManger starts game...")
        self.nowPlaying = true
        
    }
    
    func increaseTrashCount() {
        if trashCount == numOfTrash {
            
            if !isFever {
                isFever = true
                trashCount = 0
                return
            }
            
            
            print("DEBUG: increaseTrashCount...")
            if nowPlaying {
                self.nowPlaying = false
                
                print("DEBUG: endGame called...")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.endGame()
                }
            }
        } else {
            trashCount = trashCount + 1
            print("DEBUG: trash count increased")
        }
    }
    
    
    func endGame() {
        print("DEBUG: GameManger ends game...")
        self.nowPlaying = false
        refreash()
        
        if currentLevel == 1 {
            currentLevel = 2
            uiDelegate?.nextLevel(level: 2)
        } else if currentLevel == 2{
            uiDelegate?.gameOver()
            self.resetGame()
        }
    }
    
    func resetGame() {
        currentLevel = 1
        historyScore = score
        score = 0
        guiDelegate?.resetGUI()
        self.refreash()
    }
    
    func refreash() {
        trashCount = 0
        self.isFever = false
    }
}
