//
//  AttackComponent.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/21.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit
import GLKit

class AttackComponent: GKComponent {
    func attack() {
        if let entity = entity {
            if let visualComponent = entity.component(ofType: VisualComponent.self) {
                let action = SKAction.rotate(byAngle: CGFloat(GLKMathDegreesToRadians(360.0)), duration: 0.3)
                visualComponent.sprite.run(action)
            }
        }
    }
}
