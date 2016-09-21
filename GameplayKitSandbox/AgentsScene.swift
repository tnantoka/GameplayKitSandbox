//
//  AgentsScene.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/29.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class AgentsScene: ExampleScene {

    var targetNode: AgentNode!
    var agentSystem = GKComponentSystem(componentClass: GKAgent2D.self)

    override func createSceneContents() {
        targetNode = AgentNode(color: SKColor.magenta, radius: 30.0, position: center)
        addChild(targetNode)

        let goal = GKGoal(toWander: 10.0)
        let behavier = GKBehavior(goal: goal, weight: 100.0)
        targetNode.agent.behavior = behavier
        agentSystem.addComponent(targetNode.agent)
    }

    func createBullet() {
        let x = GKRandomDistribution(lowestValue: 0, highestValue: Int(frame.maxX)).nextInt()
        let y = GKRandomDistribution(lowestValue: 0, highestValue: Int(frame.maxY)).nextInt()
        let position = CGPoint(x: CGFloat(x), y: CGFloat(y))

        let bullet = AgentNode(color: SKColor.cyan, radius: 10.0, position: position)
        addChild(bullet)

        let goal = GKGoal(toSeekAgent: targetNode.agent)
        let behavier = GKBehavior(goal: goal, weight: 100.0)
        bullet.agent.behavior = behavier
        agentSystem.addComponent(bullet.agent)
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        agentSystem.update(deltaTime: deltaTime)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        createBullet()
    }
}
