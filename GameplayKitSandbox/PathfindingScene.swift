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
        case target = 1
        case ball = 2
    }

    override func createSceneContents() {
        physicsWorld.contactDelegate = self

        createTarget()
        createBlocks()
    }

    func createTarget() {
        targetNode = SKSpriteNode(color: SKColor.cyan, size: CGSize(width: 50.0, height: 20.0))
        targetNode.userData = [ "vx": 0.4 ]
        targetNode.position = CGPoint(x: targetNode.frame.height / 2, y: frame.maxY - targetNode.frame.height / 2)
        targetNode.physicsBody = SKPhysicsBody(rectangleOf: targetNode.size)
        targetNode.physicsBody?.isDynamic = false
        targetNode.physicsBody?.categoryBitMask = ContactCategory.target.rawValue
        targetNode.physicsBody?.contactTestBitMask = ContactCategory.ball.rawValue
        addChild(targetNode)
    }

    func createBall() {
        let radius: CGFloat = 10.0
        let ball = SKShapeNode(circleOfRadius: 10.0)
        ball.fillColor = SKColor.yellow
        ball.position = CGPoint(x: center.x, y: 0.0)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = ContactCategory.ball.rawValue
        ball.physicsBody?.contactTestBitMask = ContactCategory.target.rawValue
        addChild(ball)

        /*
        let dx = targetNode.position.x - ball.position.x
        let dy = targetNode.position.y - ball.position.y
        ball.physicsBody?.applyForce(CGVectorMake(dx, dy))
        */

        let obstacles = SKNode.obstacles(fromNodePhysicsBodies: blocks)
        let graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: 10.0)

        let startNode = GKGraphNode2D(point: vector_float2(x: Float(ball.position.x), y: Float(ball.position.y)))
        let toNode = GKGraphNode2D(point: vector_float2(x: Float(targetNode.position.x), y: Float(targetNode.position.y + targetNode.frame.height / 2)))

        graph.connectUsingObstacles(node: startNode)
        graph.connectUsingObstacles(node: toNode)

        if let nodes = graph.findPath(from: startNode, to: toNode) as? [GKGraphNode2D] {
            let path = CGMutablePath()
            path.move(to: ball.position)
            for node in nodes {
                path.addLine(to: CGPoint(x: CGFloat(node.position.x), y: CGFloat(node.position.y)))
            }
            let action = SKAction.follow(path
                , asOffset: false, orientToPath: false, duration: 0.8)
            ball.run(action)

            let pathNode = SKShapeNode(path: path)
            pathNode.strokeColor = SKColor.red
            addChild(pathNode)
        }
    }

    func createBlocks() {
        blocks = [SKSpriteNode]()
        for _ in 0..<10 {
            let block = SKSpriteNode(color: SKColor.magenta, size: CGSize(width: 30.0, height: 30.0))
            let x = GKRandomDistribution(lowestValue: 50, highestValue: Int(frame.width) - 50).nextInt()
            let y = GKRandomDistribution(lowestValue: 50, highestValue: Int(frame.height) - 50).nextInt()
            block.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
            block.physicsBody = SKPhysicsBody(rectangleOf: block.size)
            block.physicsBody?.isDynamic = false
            addChild(block)
            blocks.append(block)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        targetNode.position.x += targetNode.userData!["vx"] as! CGFloat

        if targetNode.position.x > frame.width - targetNode.frame.height / 2 {
            targetNode.userData!["vx"] = targetNode.userData!["vx"] as! CGFloat * -1.0
        }

        if targetNode.position.x < targetNode.frame.height / 2 {
            targetNode.userData!["vx"] = targetNode.userData!["vx"] as! CGFloat * -1.0
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        createBall()
    }

    // MARK: - SKPhysicsContactDelegate

    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody: SKPhysicsBody
        let secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if firstBody.categoryBitMask & ContactCategory.target.rawValue > 0 && secondBody.categoryBitMask & ContactCategory.ball.rawValue > 0 {
            secondBody.node?.removeFromParent()
        }
    }
}
