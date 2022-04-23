//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/23.
//

import Foundation
import SpriteKit


enum CanType {
    case bluebin
    case microwave
    case no_bluebin
    case no_microwave
}


class TrashCanNode: SKSpriteNode {
    var type: CanType
    
    init(type: CanType) {
        self.type = type
        
        
        let texture = SKTexture(imageNamed: "\(type)")
        
        super.init(texture: texture, color: .white, size: texture.size())
        
        
        size.width = size.width / 3.0
        size.height = size.height / 3.0
        
        self.name = "trashCan-\(type)"
        self.physicsBody = SKPhysicsBody(texture: texture, size: size)
        
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = -10
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


class ConveyorBeltNode: SKSpriteNode {
    
    
    init(point: CGPoint) {

        let texture = SKTexture(imageNamed: "conveyorbelt")
        let textureSize = texture.size()
        
        
        super.init(texture: texture, color: .white, size: textureSize)
        self.position = point
        
        size.width = size.width / 3.0
        size.height = size.height / 3.5
        
        self.name = "conveyorbelt"
        self.physicsBody = SKPhysicsBody(texture: texture, size: size)
        
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 1000000
        self.physicsBody?.categoryBitMask = CollisionType.obstacle.rawValue
        self.physicsBody?.collisionBitMask = CollisionType.trash.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
