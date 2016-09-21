//
//  VisualComponent.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/21.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class VisualComponent: GKComponent {
    let sprite: SKSpriteNode

    var position = CGPoint.zero {
        didSet {
            sprite.position = position
        }
    }

    init(color: SKColor, size: CGSize) {
        sprite = SKSpriteNode(color: color, size: size)
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func moveTo(_ position: CGPoint) {
        let action = SKAction.move(to: position, duration: 0.3)
        sprite.run(action, completion: {
            self.position = position
        }) 
    }

    func moveBy(_ x: CGFloat, _ y: CGFloat) {
        let p = CGPoint(x: position.x + x, y: position.y + y)
        moveTo(p)
    }
}
