//
//  BurnableComponent.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/22.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class BurnableComponent: GKComponent {

    let stateMachine: GKStateMachine
    let shapeNode: SKShapeNode
    var particleNode: SKEmitterNode?

    init(entity: GKEntity, shapeNode: SKShapeNode) {
        let dry = HouseDryState(entity: entity)
        let burning = HouseBurningState(entity: entity)
        let wet = HouseWetState(entity: entity)
        stateMachine = GKStateMachine(states: [dry, burning, wet])
        
        self.shapeNode = shapeNode
        shapeNode.strokeColor = SKColor.clearColor()

        super.init()
    }

    func useDryAppearance() {
        shapeNode.fillColor = SKColor.whiteColor()
        particleNode?.removeFromParent()
    }

    func useBurningAppearance() {
        shapeNode.fillColor = SKColor.orangeColor()
        particleNode?.removeFromParent()
        if let firePath = NSBundle.mainBundle().pathForResource("fire", ofType: "sks") {
            if let fire = NSKeyedUnarchiver.unarchiveObjectWithFile(firePath) as? SKEmitterNode {
                fire.position = CGPointMake(0, -30.0)
                shapeNode.addChild(fire)
                particleNode = fire
            }
        }
    }

    func useWetAppearance() {
        shapeNode.fillColor = SKColor.lightGrayColor()
        particleNode?.removeFromParent()
    }

    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        stateMachine.updateWithDeltaTime(seconds)
    }
}
