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
        shapeNode.strokeColor = SKColor.clear

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func useDryAppearance() {
        shapeNode.fillColor = SKColor.white
        particleNode?.removeFromParent()
    }

    func useBurningAppearance() {
        shapeNode.fillColor = SKColor.orange
        particleNode?.removeFromParent()
        if let firePath = Bundle.main.path(forResource: "fire", ofType: "sks") {
            if let fire = NSKeyedUnarchiver.unarchiveObject(withFile: firePath) as? SKEmitterNode {
                fire.position = CGPoint(x: 0, y: -30.0)
                shapeNode.addChild(fire)
                particleNode = fire
            }
        }
    }

    func useWetAppearance() {
        shapeNode.fillColor = SKColor.lightGray
        particleNode?.removeFromParent()
    }

    override func update(deltaTime seconds: TimeInterval) {
        stateMachine.update(deltaTime: seconds)
    }
}
