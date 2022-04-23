//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/23.
//

import Foundation
import SpriteKit

class Trash: SKSpriteNode { }

enum CollisionType: UInt32 {
    case trash = 1
    case trashCan = 2
    case obstacle = 4
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

class TrashNode: SKSpriteNode {
    var type: TrashType
    
    init(type: TrashType) {
        self.type = type
        
        let texture = SKTexture(imageNamed: type.imageName)
        let textureSize = texture.size()
        
        super.init(texture: texture, color: .white, size: textureSize)
        
        size.width = size.width / 2.0
        size.height = size.height / 2.0
        
        name = "trash-\(type.rawValue)"
        
        
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody?.allowsRotation = true
        physicsBody?.restitution = 0.5
        physicsBody?.friction = 0.1

        physicsBody?.categoryBitMask = CollisionType.trash.rawValue
        physicsBody?.collisionBitMask = CollisionType.trash.rawValue | CollisionType.trashCan.rawValue | CollisionType.obstacle.rawValue
        physicsBody?.contactTestBitMask = CollisionType.trashCan.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 움직임 제어
    
//    func configureMovement(_ moveStraight: Bool) {
//        let path = UIBezierPath()
//        path.move(to: .zero)
//        //위에서 아래로 이동.
//        path.addLine(to: CGPoint(x: 0, y: 5000))
//
//        //움직임을 정의
//        let movement = SKAction.follow(path.cgPath, speed: 10)
//        //행동에 대한 순서 정의
//        let sequence = SKAction.sequence([movement, . removeFromParent()])
//        // 해당 시퀀스 실행.
//        run(sequence)
//    }
}
