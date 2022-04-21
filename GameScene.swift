//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import SwiftUI
import SpriteKit
import CoreMotion


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


class Trash: SKSpriteNode { }


class GameScene: SKScene { //An object that organizes all of the active SpriteKit content.
    
    
    let gameManager = GameManager.shared
    
    var trashes = ["trash-1", "trash-2", "trash-3", "trash-4", "trash-5", "trash-6"]
    
    
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
    
    //Tells you when the scene is presented by a view.
    override func didMove(to view: SKView) {
        
        // 외부 프레임에 물리적 테두리 부여를 해야 화면 밖으로 안날라감.
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)))
        
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
        
        
        let trashCan = SKSpriteNode(imageNamed: "trashCan")
        trashCan.size = CGSize(width: 100, height: 100)
        trashCan.position = CGPoint(x: frame.minX + 100, y: frame.maxY - 100)
        trashCan.name = "trashCan"
        self.addChild(trashCan)
        trashCan.physicsBody = SKPhysicsBody(circleOfRadius: trashCan.frame.width / 2.0)
        trashCan.physicsBody?.allowsRotation = false
        trashCan.physicsBody?.restitution = 0
        trashCan.physicsBody?.friction = 0
        trashCan.physicsBody?.affectedByGravity = false
        trashCan.physicsBody?.mass = 1000000
        
        
        
        
        
        let trash = SKSpriteNode(imageNamed: "ballBlue")
        let trashRadius = trash.frame.width / 5.0
        
        
        
        //게임시작
        gameManager.startGame()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: gameManager.interval, repeats: true, block: {  inTimer  in
            
            if self.gameManager.nowPlaying {
                
                self.gameManager.increaseTrashCount()
                
                
                let trashType = self.trashes.randomElement()!
                let trash = Trash(imageNamed: trashType)
                
                
                trash.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                trash.name = trashType
                self.addChild(trash)
                
                trash.physicsBody = SKPhysicsBody(circleOfRadius: trashRadius)
                trash.physicsBody?.allowsRotation = true
                trash.physicsBody?.restitution = 0.5
                trash.physicsBody?.friction = 0.1
                
                
            }
        })
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionManager?.accelerometerData {
            
            // 가로모드에서는 x, y 뒤집어주어야함.
            // 전체 물리공간의 중력을 벡터값으로 수정. 중력의 크기도 바꿀 수 있음.
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -30, dy: accelerometerData.acceleration.x * 30)
        }
    }

    //Tells this object that one or more new touches occurred in a view or window
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
}
