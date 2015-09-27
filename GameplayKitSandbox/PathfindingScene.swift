//
//  PathfindingScene.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/27.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class PathfindingScene: ExampleScene, SKPhysicsContactDelegate {

    var targetNode: SKSpriteNode!
    var blocks: [SKSpriteNode]!

    enum ContactCategory: UInt32 {
        case Target = 1
        case Ball = 2
    }

    override func createSceneContents() {
        physicsWorld.contactDelegate = self

        createTarget()
        createBlocks()
    }

    func createTarget() {
        targetNode = SKSpriteNode(color: SKColor.cyanColor(), size: CGSizeMake(50.0, 20.0))
        targetNode.userData = [ "vx": 0.4 ]
        targetNode.position = CGPointMake(CGRectGetHeight(targetNode.frame) / 2, CGRectGetMaxY(frame) - CGRectGetHeight(targetNode.frame) / 2)
        targetNode.physicsBody = SKPhysicsBody(rectangleOfSize: targetNode.size)
        targetNode.physicsBody?.dynamic = false
        targetNode.physicsBody?.categoryBitMask = ContactCategory.Target.rawValue
        targetNode.physicsBody?.contactTestBitMask = ContactCategory.Ball.rawValue
        addChild(targetNode)
    }

    func createBall() {
        let radius: CGFloat = 10.0
        let ball = SKShapeNode(circleOfRadius: 10.0)
        ball.fillColor = SKColor.yellowColor()
        ball.position = CGPointMake(center.x, 0.0)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = ContactCategory.Ball.rawValue
        ball.physicsBody?.contactTestBitMask = ContactCategory.Target.rawValue
        addChild(ball)

        /*
        let dx = targetNode.position.x - ball.position.x
        let dy = targetNode.position.y - ball.position.y
        ball.physicsBody?.applyForce(CGVectorMake(dx, dy))
        */

        let obstacles = SKNode.obstaclesFromNodePhysicsBodies(blocks)
        let graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: 10.0)

        let startNode = GKGraphNode2D(point: vector_float2(x: Float(ball.position.x), y: Float(ball.position.y)))
        let toNode = GKGraphNode2D(point: vector_float2(x: Float(targetNode.position.x), y: Float(targetNode.position.y + CGRectGetHeight(targetNode.frame) / 2)))

        graph.connectNodeUsingObstacles(startNode)
        graph.connectNodeUsingObstacles(toNode)

        if let nodes = graph.findPathFromNode(startNode, toNode: toNode) as? [GKGraphNode2D] {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, ball.position.x, ball.position.y)
            for node in nodes {
                CGPathAddLineToPoint(path, nil, CGFloat(node.position.x), CGFloat(node.position.y))
            }
            let action = SKAction.followPath(path
                , asOffset: false, orientToPath: false, duration: 0.8)
            ball.runAction(action)

            let pathNode = SKShapeNode(path: path)
            pathNode.strokeColor = SKColor.redColor()
            addChild(pathNode)
        }
    }

    func createBlocks() {
        blocks = [SKSpriteNode]()
        for _ in 0..<10 {
            let block = SKSpriteNode(color: SKColor.magentaColor(), size: CGSizeMake(30.0, 30.0))
            let x = GKRandomDistribution(lowestValue: 50, highestValue: Int(CGRectGetWidth(frame)) - 50).nextInt()
            let y = GKRandomDistribution(lowestValue: 50, highestValue: Int(CGRectGetHeight(frame)) - 50).nextInt()
            block.position = CGPointMake(CGFloat(x), CGFloat(y))
            block.physicsBody = SKPhysicsBody(rectangleOfSize: block.size)
            block.physicsBody?.dynamic = false
            addChild(block)
            blocks.append(block)
        }
    }

    override func update(currentTime: NSTimeInterval) {
        targetNode.position.x += targetNode.userData!["vx"] as! CGFloat

        if targetNode.position.x > CGRectGetWidth(frame) - CGRectGetHeight(targetNode.frame) / 2 {
            targetNode.userData!["vx"] = targetNode.userData!["vx"] as! CGFloat * -1.0
        }

        if targetNode.position.x < CGRectGetHeight(targetNode.frame) / 2 {
            targetNode.userData!["vx"] = targetNode.userData!["vx"] as! CGFloat * -1.0
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        createBall()
    }

    // MARK: SKPhysicsContactDelegate

    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody: SKPhysicsBody
        let secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if firstBody.categoryBitMask & ContactCategory.Target.rawValue > 0 && secondBody.categoryBitMask & ContactCategory.Ball.rawValue > 0 {
            secondBody.node?.removeFromParent()
        }
    }
}
