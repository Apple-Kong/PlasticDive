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
    
    var name: String {
        switch self {
        case .PETE:
            return "1:PETE"
        case .HDPE:
            return "2:HDPE"
        case .PVC:
            return "3:PVC"
        case .LDPE:
            return "4:LDPE"
        case .PP:
            return "5:PP"
        case .PS:
            return "6:PS"
        case .OTHER:
            return "7:OTHER"
        }
    }
    
    var imageName: String {
        "trash-\(self.rawValue)"
    }
    
    var isRecycle: Bool {
        switch self {
        case .PETE, .HDPE, .PP:
            return true
        default:
            return false
        }
    }
    
    var isMicrowave: Bool {
        switch self {
        case .PETE, .HDPE, .LDPE, .PP:
            return true
        default:
            return false
        }
    }
    
    var description: String {
        switch self {
        case .PETE:
            return "It's transparent and light. It is the most recycled and very safe to read. There is a high possibility of bacteria reproducing when reused (water bottles, juice/ion drink bottles)"
        case .HDPE:
            return "It has no chemical emissions and is very safe for toxicity. Microwave is available (milk bottles, toys)"
        case .PVC:
            return "Usually, it is weak against stable substances or heat, so it releases toxic gases, environmental hormones, and dioxins when incinerated. "
        case .LDPE:
            return "It is less rigid and transparent than HDPE. It is recommended to refrain from using it as much as possible because it is safe to use in everyday life but cannot be recycled. (Plastic bags, snack wrappers)"
        case .PP:
            return "It is the lightest and most durable plastic. There is no deformation or hormonal emission at high temperatures. Polypropylene recycling is expensive and, in many cases, it’s hard to get rid of the smell of the product this plastic contained in its first life. (Airtight container, lunch box, cup)"
        case .PS:
            return "Although molding is easy, heat resistance is weak, so environmental hormones and carcinogens are released when heated. (Disposable cups, disposable forks, spoons, take-out coffee lids)"
        case .OTHER:
            return "All other plastics are not recommended for use"
        }
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
        
        size.width = size.width / 2.5
        size.height = size.height / 2.5
        
        name = "trash-\(type.rawValue)"
        
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.2
        physicsBody?.friction = 0
        physicsBody?.mass = 0.2

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
