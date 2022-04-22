//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/23.
//

import Foundation
import SpriteKit


class TrashCanNode: SKSpriteNode {
    var type: TrashType
    
    init(type: TrashType, point: CGPoint) {
        self.type = type
        
        
        let texture = SKTexture(imageNamed: "trashCan")
        
        super.init(texture: texture, color: .white, size: texture.size())
        self.position = point
        self.size = CGSize(width: 100, height: 100)
        self.name = "trashCan-\(self.type.rawValue)"
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.frame.width / 2.0)
        
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 1000000
        self.physicsBody?.categoryBitMask = CollisionType.trashCan.rawValue
        self.physicsBody?.collisionBitMask = CollisionType.trash.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
