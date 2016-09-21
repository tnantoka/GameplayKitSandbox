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
            CGPoint(x: 0, y: 40.0),
            CGPoint(x: -40.0, y: 0),
            CGPoint(x: -25.0, y: 0),
            CGPoint(x: -25.0, y: -40.0),
            CGPoint(x: 25.0, y: -40.0),
            CGPoint(x: 25.0, y: 0),
            CGPoint(x: 40.0, y: 0),
        ]
        let shapeNode = SKShapeNode(points: &points, count: points.count)
        shapeNode.position = center
        addChild(shapeNode)

        let burnableComponent = BurnableComponent(entity: house, shapeNode: shapeNode)
        house.addComponent(burnableComponent)
        burnableComponent.stateMachine.enter(HouseDryState.self)

        createLabel("Tap: Spark", color: SKColor.orange, order: 0)
        createLabel("Double Tap: Rain", color: SKColor.lightGray, order: 1)
    }

    func createSpark() {
        createParticle("spark", position: center, duration: 0.1) {
            if let burnableComponent = self.house.component(ofType: BurnableComponent.self) {
                burnableComponent.stateMachine.enter(HouseBurningState.self)
            }
        }
    }

    func createRain() {
        createParticle("rain", position: CGPoint(x: center.x + 50.0, y: center.y + 200.0), duration: 2.0) {
            if let burnableComponent = self.house.component(ofType: BurnableComponent.self) {
                burnableComponent.stateMachine.enter(HouseWetState.self)
            }
        }
    }

    func createParticle(_ name: String, position: CGPoint, duration: TimeInterval, callback: @escaping (Void) -> Void) {
        if let particlePath = Bundle.main.path(forResource: name, ofType: "sks") {
            if let particle = NSKeyedUnarchiver.unarchiveObject(withFile: particlePath) as? SKEmitterNode {
                particle.position = position
                addChild(particle)

                let wait = SKAction.wait(forDuration: duration)
                let fadeOut = SKAction.fadeOut(withDuration: 1.0)
                let sequence = SKAction.sequence([wait, fadeOut])
                particle.run(sequence, completion: callback)
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        house.update(deltaTime: deltaTime)
    }
}
