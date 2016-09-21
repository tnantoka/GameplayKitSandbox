//
//  RuleScene.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/30.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class RuleScene: ExampleScene, SKPhysicsContactDelegate {

    var powerNode: SKSpriteNode!
    var cleanerNode: SKShapeNode!
    var chargerNode: SKSpriteNode!

    var ruleSystem: GKRuleSystem!
    var power = 100

    var waitingTime: TimeInterval = 0

    enum ContactCategory: UInt32 {
        case cleaner = 1
        case garbage = 2
    }

    override func createSceneContents() {
        physicsWorld.contactDelegate = self

        chargerNode = SKSpriteNode(color: SKColor.yellow, size: CGSize(width: 30.0, height: 30.0))
        chargerNode.position = CGPoint(x: frame.maxX - 15.0, y: frame.maxY - 15.0)
        addChild(chargerNode)

        cleanerNode = SKShapeNode(circleOfRadius: 20.0)
        cleanerNode.fillColor = SKColor.white
        cleanerNode.position = randomPosition()
        addChild(cleanerNode)
        cleanerNode.physicsBody = SKPhysicsBody(circleOfRadius: cleanerNode.frame.width / 2)
        cleanerNode.physicsBody?.affectedByGravity = false
        cleanerNode.physicsBody?.contactTestBitMask = ContactCategory.garbage.rawValue
        cleanerNode.physicsBody?.categoryBitMask = ContactCategory.cleaner.rawValue

        powerNode = SKSpriteNode(color: SKColor.cyan, size: CGSize(width: 50.0, height: 20.0))
        powerNode.position = CGPoint(x: 10.0, y: frame.maxY - powerNode.size.height - 10.0)
        powerNode.anchorPoint = CGPoint.zero
        addChild(powerNode)

        ruleSystem = GKRuleSystem()
        let rules = [
            GKRule(predicate: NSPredicate(format: "$distanceToCharger > 550"), assertingFact: "charge" as NSObjectProtocol, grade: 1.0),
            GKRule(predicate: NSPredicate(format: "$power <= 30"), assertingFact: "charge" as NSObjectProtocol, grade: 1.0),
        ]
        ruleSystem.add(rules)

        createGarbages()
    }

    func createGarbages() {
        let count = GKRandomDistribution.d6().nextInt()
        for _ in 0...count {
            let garbage = SKSpriteNode(color: SKColor.lightGray, size: CGSize(width: 10.0, height: 10.0))
            garbage.position = randomPosition()
            addChild(garbage)
            garbage.physicsBody = SKPhysicsBody(rectangleOf: garbage.frame.size)
            garbage.physicsBody?.affectedByGravity = false
            garbage.physicsBody?.contactTestBitMask = ContactCategory.cleaner.rawValue
            garbage.physicsBody?.categoryBitMask = ContactCategory.garbage.rawValue
        }
    }

    func randomPosition() -> CGPoint {
        let x = GKRandomDistribution(lowestValue: 30, highestValue: Int(frame.maxX) - 30).nextInt()
        let y = GKRandomDistribution(lowestValue: 30, highestValue: Int(frame.maxY) - 30).nextInt()
        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)

        self.updatePowerNode()

        waitingTime += deltaTime
        if waitingTime > 3.0 {

            createGarbages()

            let distance = sqrt(pow(cleanerNode.position.x - chargerNode.position.x, 2) + pow(cleanerNode.position.y - chargerNode.position.y, 2))
            ruleSystem.state["distanceToCharger"] = distance
            ruleSystem.state["power"] = power

            ruleSystem.reset()
            ruleSystem.evaluate()

            let charge = ruleSystem.grade(forFact: "charge" as NSObjectProtocol)
            if charge > 0.0 {
                let action = SKAction.move(to: chargerNode.position, duration: 1.0)
                cleanerNode.run(action, completion: {
                    self.power = 100
                }) 
            } else {
                let action = SKAction.move(to: randomPosition(), duration: 1.0)
                cleanerNode.run(action, completion: {
                    self.power -= 10
                }) 
            }
            waitingTime = 0
        }
    }

    func updatePowerNode() {
        powerNode.size.width = CGFloat(power / 2)
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

        if firstBody.categoryBitMask & ContactCategory.cleaner.rawValue > 0 && secondBody.categoryBitMask & ContactCategory.garbage.rawValue > 0 {
            secondBody.node?.removeFromParent()
        }
    }
}
