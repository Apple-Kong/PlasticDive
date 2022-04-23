//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import SwiftUI
import SpriteKit
import CoreMotion
import AVFoundation


protocol GUIDelegate {
    func resetGUI()
}

class GameScene: SKScene, GUIDelegate { //An object that organizes all of the active SpriteKit content.
    
    //MARK: - Properties
    let gameManager = GameManager.shared
    var motionManager: CMMotionManager?
    
    let scoreLabel = SKLabelNode(fontNamed:  "HelveticaNeue")
    let feverLabel = SKLabelNode(fontNamed: "HelveticaNeue")
    
    var timer = Timer()
    
    let correctSound = SKAction.playSoundFileNamed("correctSound", waitForCompletion: false)
    let wrongSound = SKAction.playSoundFileNamed("wrongSound", waitForCompletion: false)
    
    
    var score = 0 {
        didSet {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formattedScore = formatter.string(from: gameManager.score as NSNumber) ?? "0"
            scoreLabel.text = "SCORE: \(formattedScore)"
        }
    }
    
    let bluebin = TrashCanNode(type: CanType.bluebin)
    let microwave = TrashCanNode(type: CanType.microwave)
    
    //MARK: - Initializer
    override init(size: CGSize) {
        super.init(size: size)
        
        gameManager.guiDelegate = self
    }
    override init() {
        super.init()
        
        gameManager.guiDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    //MARK: - LifeCycle
   
    func resetGUI() {
        print("DEBUG: reset GUI called")
        gameManager.score = 0
        score = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        // if not playing game then remove all trash
        if !gameManager.nowPlaying {
            feverLabel.isHidden = true
            for node in children {
                if let trash = node as? TrashNode {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        trash.removeFromParent()
                        
                    }
                }
            }
        } else {
            if gameManager.isFever {
                feverLabel.isHidden = false
            }
        }
        
        switch gameManager.currentLevel {
        case 1:
            self.bluebin.texture = SKTexture(imageNamed: "bluebin")
            self.bluebin.type = .bluebin
            self.microwave.texture = SKTexture(imageNamed: "no-bluebin")
            self.microwave.type = .no_bluebin

        case 2:
            self.bluebin.texture = SKTexture(imageNamed: "microwave")
            self.bluebin.type = .microwave
            self.microwave.texture = SKTexture(imageNamed: "no-microwave")
            self.microwave.type = .no_microwave
        default:
            print("DEBUG: Invalid current level")
        }
        
        
        if let accelerometerData = motionManager?.accelerometerData {
            // 가로모드에서는 x, y 뒤집어주어야함.
            // 전체 물리공간의 중력을 벡터값으로 수정. 중력의 크기도 바꿀 수 있음.
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 30, dy: accelerometerData.acceleration.y - 5)
        }
    }
    
    
    //Tells you when the scene is presented by a view.
    override func didMove(to view: SKView) {
        
        let backgroundSound = SKAudioNode(fileNamed: "bgm")
        self.addChild(backgroundSound)
        
        
        // 외부 프레임에 물리적 테두리 부여를 해야 화면 밖으로 안날라감.
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -100, right: 0)))
        physicsWorld.contactDelegate = self
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
//        let background = SKSpriteNode(imageNamed: "background")
        backgroundColor = .white
//        background.position = CGPoint(x: frame.midX, y: frame.midY)
//        background.alpha = 0.2
//        background.zPosition = -1
//        addChild(background)
        
        scoreLabel.fontSize = 28
        scoreLabel.position = CGPoint(x: frame.maxX - 100, y: frame.maxY - 50)
        scoreLabel.text = "SCORE: 0"
        scoreLabel.zPosition = 100
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.fontColor = .black
        addChild(scoreLabel)
        
        
        
        feverLabel.fontSize = 28
        feverLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        feverLabel.text = "FEVER!!!"
        feverLabel.zPosition = 101
        feverLabel.horizontalAlignmentMode = .center
        feverLabel.fontColor = .black
        feverLabel.isHidden = true
        addChild(feverLabel)
        
        let logoNode = SKSpriteNode(imageNamed: "Logo")
        logoNode.size = CGSize(width: 600, height: 400)
        logoNode.position = CGPoint(x: frame.midX, y: frame.maxY - 200)
        logoNode.zPosition = -100
        
        
        self.addChild(logoNode)
        
        
        self.bluebin.position = CGPoint(x: frame.minX + 120, y: frame.minY + 100)
        self.microwave.position = CGPoint(x: frame.maxX - 120, y: frame.minY + 100)
        
        
        self.addChild(bluebin)
        self.addChild(microwave)
        
        let belt1 = ConveyorBeltNode(point: CGPoint(x: frame.midX + 120, y: frame.midY + 80))
        self.addChild(belt1)
        
        let belt2 = ConveyorBeltNode(point: CGPoint(x: frame.midX - 90, y: frame.midY - 130))
        self.addChild(belt2)
        
        
        
        
        //게임시작
//        gameManager.startGame()
        
        var count = 0
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {  inTimer  in
            
            
            
            
            if self.gameManager.nowPlaying {
                count += 1
                
                if self.gameManager.isFever {
                    self.gameManager.increaseTrashCount()
                    
                    
                    let trashType = [1, 2, 3, 4, 5, 6].randomElement()!
                    let trash = TrashNode(type: TrashType(rawValue: trashType)!)
                    trash.position = CGPoint(x: self.frame.midX, y: self.frame.maxY)
                    self.addChild(trash)
                } else {
                    if count % 3 == 0 {
                        self.gameManager.increaseTrashCount()
                        
                        
                        let trashType = [1, 2, 3, 4, 5, 6].randomElement()!
                        let trash = TrashNode(type: TrashType(rawValue: trashType)!)
                        trash.position = CGPoint(x: self.frame.midX, y: self.frame.maxY)
                        self.addChild(trash)
                    }
                }
                
            }
        })
    }
}





//MARK: - SKPhysicsContactDelegate
extension GameScene: SKPhysicsContactDelegate {
    
   
    
    func didBegin(_ contact: SKPhysicsContact) {
        //접촉이 시작되었을 때 해당 메서드 실행됨
        
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        let sortedNodes = [nodeA, nodeB].sorted { $0.name ?? "" < $1.name ?? ""}
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        if let trashNode = firstNode as? TrashNode {
            
            
            
            if let goalNode = secondNode as? TrashCanNode {
                
                
                switch goalNode.type {
                case .bluebin:
                    if trashNode.type.isRecycle {
                       
                        self.score += 100
                        gameManager.score += 100
                        run(correctSound)
                        firstNode.physicsBody = nil
                        let removeAnimation = SKAction.sequence([SKAction.resize(toWidth: 0, height: 0, duration: 0.3), SKAction.removeFromParent()])
                        firstNode.run(removeAnimation)
                    } else {
                       
                        firstNode.physicsBody = nil
                        run(wrongSound)
                        let removeAnimation = SKAction.sequence([SKAction.applyImpulse(CGVector(dx: 0, dy: 10), duration: 0.1), SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()])
                        firstNode.run(removeAnimation)
                    }
                case .microwave:
                    if trashNode.type.isMicrowave {
                 
                        self.score += 100
                        gameManager.score += 100
                        run(correctSound)
                        firstNode.physicsBody = nil
                        let removeAnimation = SKAction.sequence([SKAction.resize(toWidth: 0, height: 0, duration: 0.3), SKAction.removeFromParent()])
                        firstNode.run(removeAnimation)
                    } else  {
                        firstNode.physicsBody = nil
                        run(wrongSound)
                        let removeAnimation = SKAction.sequence([SKAction.applyImpulse(CGVector(dx: 0, dy: 10), duration: 0.1), SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()])
                        firstNode.run(removeAnimation)
                        
                    }
                case .no_bluebin:
                    if !trashNode.type.isRecycle {
                        self.score += 100
                        gameManager.score += 100
                        run(correctSound)
                        firstNode.physicsBody = nil
                        let removeAnimation = SKAction.sequence([SKAction.resize(toWidth: 0, height: 0, duration: 0.3), SKAction.removeFromParent()])
                        firstNode.run(removeAnimation)
                    } else {
                        
                        firstNode.physicsBody = nil
                        run(wrongSound)
                        let removeAnimation = SKAction.sequence([SKAction.applyImpulse(CGVector(dx: 0, dy: 10), duration: 0.1), SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()])
                        firstNode.run(removeAnimation)
                    }
                case .no_microwave:
                    if !trashNode.type.isMicrowave {
                 
                        self.score += 100
                        gameManager.score += 100
                        run(correctSound)
                        firstNode.physicsBody = nil
                        let removeAnimation = SKAction.sequence([SKAction.resize(toWidth: 0, height: 0, duration: 0.3), SKAction.removeFromParent()])
                        firstNode.run(removeAnimation)
                    } else  {
                     
                        
                        firstNode.physicsBody = nil
                        run(wrongSound)
                        let removeAnimation = SKAction.sequence([SKAction.applyImpulse(CGVector(dx: 0, dy: 10), duration: 0.1), SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()])
                        firstNode.run(removeAnimation)
                        
                    }
                }
            }
        }
    }
}
