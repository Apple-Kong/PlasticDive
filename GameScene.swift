//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import SwiftUI
import SpriteKit
import CoreMotion





class Trash: SKSpriteNode { }

enum CollisionType: UInt32 {
    case trash = 1
    case trashCan = 2
}

enum TrashType: Int, CaseIterable {
    case PETE = 1
    case HDPE
    case PVC
    case LDPE
    case PP
    case PS
    case OTHER
    
    var imageName: String {
        "trash-\(self.rawValue)"
    }
}

enum TrashCanPoint {
    case topLeft
    case top
    case topRight
    case bottomLeft
    case bottom
    case bottomRight
}







class GameScene: SKScene { //An object that organizes all of the active SpriteKit content.
    
    //MARK: - Properties
    let gameManager = GameManager.shared
    
   
    
    
    var motionManager: CMMotionManager?
    let scoreLabel = SKLabelNode(fontNamed:  "HelveticaNeue-Thin")
    var matchedBalls = Set<Trash>()
    var timer = Timer()
    
    
    
    
    var score = 0 {
        didSet {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formattedScore = formatter.string(from: score as NSNumber) ?? "0"
            scoreLabel.text = "SCORE: \(formattedScore)"
        }
    }
    
    //MARK: - LifeCycle
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
        if let accelerometerData = motionManager?.accelerometerData {
            
            // 가로모드에서는 x, y 뒤집어주어야함.
            // 전체 물리공간의 중력을 벡터값으로 수정. 중력의 크기도 바꿀 수 있음.
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -30, dy: accelerometerData.acceleration.x * 30)
        }
        
        let activeTrashes = children.compactMap { $0 as? TrashNode}
        
        for trash in activeTrashes {
            guard frame.intersects(trash.frame) else { continue }
            
            
        }
        
    }
    
    

    //Tells this object that one or more new touches occurred in a view or window
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("DEBUG: touchesBegan method called...")
        //첫번째 탭의 위치 알아오기
        //UITouch : An object representing the location, size, movement, and force of a touch occurring on the screen.
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        //SKSpriteNode is an onscreen graphical element
        let box = SKSpriteNode(color: SKColor.red, size: CGSize(width: 50, height: 50))
        box.position = location
        //물리적 크기 설정
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        
        
        //게임씬에 추가.
        addChild(box)
    }
    
    //Tells you when the scene is presented by a view.
    override func didMove(to view: SKView) {
        
        // 외부 프레임에 물리적 테두리 부여를 해야 화면 밖으로 안날라감.
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)))
        physicsWorld.contactDelegate = self
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.alpha = 0.2
        background.zPosition = -1
        addChild(background)
        
        scoreLabel.fontSize = 40
        scoreLabel.position = CGPoint(x: 20, y: 20)
        scoreLabel.text = "SCORE: 0"
        scoreLabel.zPosition = 100
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        
        
        for type in TrashType.allCases {
            
            
            
        }
        // add trash can on scene
        let trashCan = TrashCanNode(type: TrashType.PETE, point: CGPoint(x: frame.minX + 100, y: frame.minY + 100))
        self.addChild(trashCan)
        
        let trashCan2 = TrashCanNode(type: TrashType.HDPE, point: CGPoint(x: frame.minX + 100, y: frame.maxY - 100))
        self.addChild(trashCan2)
        
        let trashCan3 = TrashCanNode(type: TrashType.PVC, point: CGPoint(x: frame.maxX - 100, y: frame.maxY - 100))
        self.addChild(trashCan3)
        
        let trashCan4 = TrashCanNode(type: TrashType.LDPE, point: CGPoint(x: frame.maxX - 100, y: frame.minY + 100))
        self.addChild(trashCan4)
        
        

        //게임시작
        gameManager.startGame()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: gameManager.interval, repeats: true, block: {  inTimer  in
            
            if self.gameManager.nowPlaying {
                
                self.gameManager.increaseTrashCount()
                
                
                let trashType = [1, 2, 3, 4, 5, 6].randomElement()!
                let trash = TrashNode(type: TrashType(rawValue: trashType)!)
                trash.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                self.addChild(trash)
            }
        })
    }
    
    
    //MARK: - Helpers

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
        
        print("DEBUG: contact between \(firstNode.name) and \(secondNode.name)")
        
    }
}
