//
//  EntitiesScene.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/20.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class EntitiesScene: ExampleScene {

    var player: GKEntity!
    var enemies = [GKEntity]()
    var boss: GKEntity!

    let intelligenceSystem = GKComponentSystem(componentClass: IntelligenceComponent.self)

    override func createSceneContents() {
        createLabel("■ Player: Visual, Attack, Control", color: SKColor.cyanColor(), order: 0)
        createLabel("■ Boss: Visual, Attack, Intelligence", color: SKColor.magentaColor(), order: 2)
        createLabel("■ Enemy: Visual, Intelligence", color: SKColor.yellowColor(), order: 1)

        createPlayer()
        createEnemies()
        createBoss()
    }

    func createPlayer() {
        player = GKEntity()

        let visualComponent = VisualComponent(color: SKColor.cyanColor(), size: CGSizeMake(30.0, 30.0))
        visualComponent.position = center
        player.addComponent(visualComponent)
        addChild(visualComponent.sprite)

        let attackComponent = AttackComponent()
        player.addComponent(attackComponent)

        let controlComponent = ControlComponent()
        player.addComponent(controlComponent)
    }

    func createEnemies() {
        for _ in 0..<20 {
            let enemy = GKEntity()
            enemies.append(enemy)

            let visualComponent = VisualComponent(color: SKColor.yellowColor(), size: CGSizeMake(20.0, 20.0))
            visualComponent.position = randomPosition()
            enemy.addComponent(visualComponent)
            addChild(visualComponent.sprite)

            let intelligenceComponent = IntelligenceComponent()
            enemy.addComponent(intelligenceComponent)
            intelligenceSystem.addComponent(intelligenceComponent)
        }
    }

    func createBoss() {
        boss = GKEntity()

        let visualComponent = VisualComponent(color: SKColor.magentaColor(), size: CGSizeMake(50.0, 50.0))
        visualComponent.position = randomPosition()
        boss.addComponent(visualComponent)
        addChild(visualComponent.sprite)

        let attackComponent = AttackComponent()
        boss.addComponent(attackComponent)

        let intelligenceComponent = IntelligenceComponent()
        boss.addComponent(intelligenceComponent)
        intelligenceSystem.addComponent(intelligenceComponent)
    }

    func randomPosition() -> CGPoint {
        let x = GKRandomDistribution(lowestValue: 50, highestValue: Int(CGRectGetMaxX(frame)) - 50).nextInt()
        let y = GKRandomDistribution(lowestValue: 50, highestValue: Int(CGRectGetMaxY(frame)) - 50).nextInt()
        return CGPointMake(CGFloat(x), CGFloat(y))
    }

    override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)

        player.updateWithDeltaTime(deltaTime)
        intelligenceSystem.updateWithDeltaTime(deltaTime)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        let node = nodeAtPoint(location)
        if let controlComponent = player.componentForClass(ControlComponent.self) {
            controlComponent.touch(node, location: location)
        }
    }
}
