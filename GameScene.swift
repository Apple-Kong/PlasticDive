//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import SwiftUI
import SpriteKit
import CoreMotion



class GameScene: SKScene { //An object that organizes all of the active SpriteKit content.
    
    //MARK: - Properties
    let gameManager = GameManager.shared
    
   
    
    
    var motionManager: CMMotionManager?
    let scoreLabel = SKLabelNode(fontNamed:  "HelveticaNeue")
    
    var matchedBalls = Set<Trash>()
    var timer = Timer()
    
    
    
    
    var score = 0 {
        didSet {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formattedScore = formatter.string(from: gameManager.score as NSNumber) ?? "0"
            scoreLabel.text = "SCORE: \(formattedScore)"
        }
    }
    
    //MARK: - LifeCycle
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
        if let accelerometerData = motionManager?.accelerometerData {
            // 가로모드에서는 x, y 뒤집어주어야함.
            // 전체 물리공간의 중력을 벡터값으로 수정. 중력의 크기도 바꿀 수 있음.
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 30, dy: accelerometerData.acceleration.y * 20 - 5)
        }
    }
    
    

    //Tells this object that one or more new touches occurred in a view or window
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("DEBUG: touchesBegan method called...")
        //첫번째 탭의 위치 알아오기
        //UITouch : An object representing the location, size, movement, and force of a touch occurring on the screen.
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
        

    }
    
    //Tells you when the scene is presented by a view.
    override func didMove(to view: SKView) {
        
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
        
        let logoNode = SKSpriteNode(imageNamed: "Logo")
        logoNode.size = CGSize(width: 600, height: 400)
        logoNode.position = CGPoint(x: frame.midX, y: frame.maxY - 200)
        logoNode.zPosition = -100
        
        
        self.addChild(logoNode)
        
        
        
        let trashCan2 = TrashCanNode(type: TrashType.HDPE, point: CGPoint(x: frame.minX + 100, y: frame.minY + 100))
        self.addChild(trashCan2)
        
        let trashCan3 = TrashCanNode(type: TrashType.PVC, point: CGPoint(x: frame.maxX - 100, y: frame.minY + 100))
        self.addChild(trashCan3)
        
//        let obstacle1 = ObstacleNode(point: CGPoint(x: frame.midX, y: frame.midY))
//        self.addChild(obstacle1)
        
        
        
        //게임시작
        gameManager.startGame()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: gameManager.interval, repeats: true, block: {  inTimer  in
            
            if self.gameManager.nowPlaying {
                
                self.gameManager.increaseTrashCount()
                
                
                let trashType = [1, 2, 3, 4, 5, 6].randomElement()!
                let trash = TrashNode(type: TrashType(rawValue: trashType)!)
                trash.position = CGPoint(x: self.frame.midX, y: self.frame.maxY)
                self.addChild(trash)
            }
        })
    }
}





//MARK: - SKPhysicsContactDelegate node 간 접촉 event handler
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //접촉이 시작되었을 때 해당 메서드 실행됨
        
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        let sortedNodes = [nodeA, nodeB].sorted { $0.name ?? "" < $1.name ?? ""}
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
//        print("DEBUG: contact between \(firstNode.name) and \(secondNode.name)")
        if let trashName = firstNode.name, let canName = secondNode.name {
            
            if trashName.suffix(1) == canName.suffix(1) {
                print("DEBUG: Goal \(trashName) -  \(canName)")
                self.score += 100
                gameManager.score += 100
            } else {
                print("DEBUG: Fail")
                
//                gameManager.incorrectTrash()
            }
            
            if let particle = SKEmitterNode(fileNamed: "TrashParticle") {
                print("DEBUG: particle added")
                particle.position = firstNode.position
                addChild(particle)
                
                let removeAfterDead = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.removeFromParent()])
                
                particle.run(removeAfterDead)
            }
            // 접촉시 제거
            firstNode.removeFromParent()
            
            
        }
    }
}
