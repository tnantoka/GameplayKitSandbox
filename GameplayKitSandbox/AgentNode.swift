//
//  AgentNode.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/29.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GLKit
import GameplayKit

class AgentNode: SKNode, GKAgentDelegate {

    let agent: GKAgent2D

    init(color: SKColor, radius: CGFloat, position: CGPoint) {
        var points = [CGPoint]()

        for degree in [0.0, 120.0, 240.0] as [Float] {
            let radian = CGFloat(GLKMathDegreesToRadians(degree))
            let x = cos(radian) * radius
            let y = sin(radian) * radius
            points.append(CGPoint(x: x, y: y))
        }

        let shape = SKShapeNode(points: &points, count: points.count)
        shape.fillColor = color
        shape.strokeColor = SKColor.clear

        let circle = SKShapeNode(circleOfRadius: 2.0)
        circle.strokeColor = SKColor.clear
        circle.fillColor = SKColor.yellow
        circle.position = CGPoint(x: points[0].x, y: points[0].y)

        agent = GKAgent2D()
        agent.position = vector_float2(x: Float(position.x), y: Float(position.y))
        agent.radius = Float(radius)
        agent.maxSpeed = 50.0
        agent.maxAcceleration = 20.0

        super.init()
        self.position = position

        addChild(shape)
        addChild(circle)

        agent.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - GKAgentDelegate

    func agentWillUpdate(_ agent: GKAgent) {
    }

    func agentDidUpdate(_ agent: GKAgent) {
        guard let agent = agent as? GKAgent2D else { return }
        self.position = CGPoint(x: CGFloat(agent.position.x), y: CGFloat(agent.position.y))
        self.zRotation = CGFloat(agent.rotation)

    }
}
