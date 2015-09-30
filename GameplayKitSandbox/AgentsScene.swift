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
        targetNode = AgentNode(color: SKColor.magentaColor(), radius: 30.0, position: center)
        addChild(targetNode)

        let goal = GKGoal(toWander: 10.0)
        let behavier = GKBehavior(goal: goal, weight: 100.0)
        targetNode.agent.behavior = behavier
        agentSystem.addComponent(targetNode.agent)
    }

    func createBullet() {
        let x = GKRandomDistribution(lowestValue: 0, highestValue: Int(CGRectGetMaxX(frame))).nextInt()
        let y = GKRandomDistribution(lowestValue: 0, highestValue: Int(CGRectGetMaxY(frame))).nextInt()
        let position = CGPointMake(CGFloat(x), CGFloat(y))

        let bullet = AgentNode(color: SKColor.cyanColor(), radius: 10.0, position: position)
        addChild(bullet)

        let goal = GKGoal(toSeekAgent: targetNode.agent)
        let behavier = GKBehavior(goal: goal, weight: 100.0)
        bullet.agent.behavior = behavier
        agentSystem.addComponent(bullet.agent)
    }

    override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        agentSystem.updateWithDeltaTime(deltaTime)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        createBullet()
    }
}
