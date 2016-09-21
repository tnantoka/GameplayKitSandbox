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
        createLabel("■ Player: Visual, Attack, Control", color: SKColor.cyan, order: 0)
        createLabel("■ Boss: Visual, Attack, Intelligence", color: SKColor.magenta, order: 2)
        createLabel("■ Enemy: Visual, Intelligence", color: SKColor.yellow, order: 1)

        createPlayer()
        createEnemies()
        createBoss()
    }

    func createPlayer() {
        player = GKEntity()

        let visualComponent = VisualComponent(color: SKColor.cyan, size: CGSize(width: 30.0, height: 30.0))
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

            let visualComponent = VisualComponent(color: SKColor.yellow, size: CGSize(width: 20.0, height: 20.0))
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

        let visualComponent = VisualComponent(color: SKColor.magenta, size: CGSize(width: 50.0, height: 50.0))
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
        let x = GKRandomDistribution(lowestValue: 50, highestValue: Int(frame.maxX) - 50).nextInt()
        let y = GKRandomDistribution(lowestValue: 50, highestValue: Int(frame.maxY) - 50).nextInt()
        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)

        player.update(deltaTime: deltaTime)
        intelligenceSystem.update(deltaTime: deltaTime)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        if let controlComponent = player.component(ofType: ControlComponent.self) {
            controlComponent.touch(node, location: location)
        }
    }
}
