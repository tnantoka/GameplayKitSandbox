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

    var position = CGPointZero {
        didSet {
            sprite.position = position
        }
    }

    init(color: SKColor, size: CGSize) {
        sprite = SKSpriteNode(color: color, size: size)
    }

    func moveTo(position: CGPoint) {
        let action = SKAction.moveTo(position, duration: 0.3)
        sprite.runAction(action) {
            self.position = position
        }
    }

    func moveBy(x: CGFloat, _ y: CGFloat) {
        let p = CGPointMake(position.x + x, position.y + y)
        moveTo(p)
    }
}
