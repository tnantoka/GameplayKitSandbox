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
    func touch(_ node: SKNode, location: CGPoint) {
        if let entity = entity {
            if let visualComponent = entity.component(ofType: VisualComponent.self) {
                if node == visualComponent.sprite {
                    if let attackComponent = entity.component(ofType: AttackComponent.self) {
                        attackComponent.attack()
                    }
                } else {
                    visualComponent.moveTo(location)
                }
            }
        }
    }
}
