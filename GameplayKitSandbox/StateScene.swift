//
//  StateScene.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/22.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class StateScene: ExampleScene {

    var house: GKEntity!

    override func createSceneContents() {
        house = GKEntity()

        var points = [
            CGPointMake(0, 40.0),
            CGPointMake(-40.0, 0),
            CGPointMake(-25.0, 0),
            CGPointMake(-25.0, -40.0),
            CGPointMake(25.0, -40.0),
            CGPointMake(25.0, 0),
            CGPointMake(40.0, 0),
        ]
        let shapeNode = SKShapeNode(points: &points, count: points.count)
        shapeNode.position = center
        addChild(shapeNode)

        let burnableComponent = BurnableComponent(entity: house, shapeNode: shapeNode)
        house.addComponent(burnableComponent)
        burnableComponent.stateMachine.enterState(HouseDryState.self)

        createLabel("Tap: Spark", color: SKColor.orangeColor(), order: 0)
        createLabel("Double Tap: Rain", color: SKColor.lightGrayColor(), order: 1)
    }

    func createSpark() {
        createParticle("spark", position: center, duration: 0.1) {
            if let burnableComponent = self.house.componentForClass(BurnableComponent.self) {
                burnableComponent.stateMachine.enterState(HouseBurningState.self)
            }
        }
    }

    func createRain() {
        createParticle("rain", position: CGPointMake(center.x + 50.0, center.y + 200.0), duration: 2.0) {
            if let burnableComponent = self.house.componentForClass(BurnableComponent.self) {
                burnableComponent.stateMachine.enterState(HouseWetState.self)
            }
        }
    }

    func createParticle(name: String, position: CGPoint, duration: NSTimeInterval, callback: Void -> Void) {
        if let particlePath = NSBundle.mainBundle().pathForResource(name, ofType: "sks") {
            if let particle = NSKeyedUnarchiver.unarchiveObjectWithFile(particlePath) as? SKEmitterNode {
                particle.position = position
                addChild(particle)

                let wait = SKAction.waitForDuration(duration)
                let fadeOut = SKAction.fadeOutWithDuration(1.0)
                let sequence = SKAction.sequence([wait, fadeOut])
                particle.runAction(sequence, completion: callback)
            }
        }
    }

    override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        
        house.updateWithDeltaTime(deltaTime)
    }
}
