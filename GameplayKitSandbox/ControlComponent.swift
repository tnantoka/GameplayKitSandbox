//
//  ControlComponent.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/22.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class ControlComponent: GKComponent {
    func touch(node: SKNode, location: CGPoint) {
        if let entity = entity {
            if let visualComponent = entity.componentForClass(VisualComponent.self) {
                if node == visualComponent.sprite {
                    if let attackComponent = entity.componentForClass(AttackComponent.self) {
                        attackComponent.attack()
                    }
                } else {
                    visualComponent.moveTo(location)
                }
            }
        }
    }
}
