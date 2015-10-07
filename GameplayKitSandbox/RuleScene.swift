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

    var waitingTime: NSTimeInterval = 0

    enum ContactCategory: UInt32 {
        case Cleaner = 1
        case Garbage = 2
    }

    override func createSceneContents() {
        physicsWorld.contactDelegate = self

        chargerNode = SKSpriteNode(color: SKColor.yellowColor(), size: CGSizeMake(30.0, 30.0))
        chargerNode.position = CGPointMake(CGRectGetMaxX(frame) - 15.0, CGRectGetMaxY(frame) - 15.0)
        addChild(chargerNode)

        cleanerNode = SKShapeNode(circleOfRadius: 20.0)
        cleanerNode.fillColor = SKColor.whiteColor()
        cleanerNode.position = randomPosition()
        addChild(cleanerNode)
        cleanerNode.physicsBody = SKPhysicsBody(circleOfRadius: CGRectGetWidth(cleanerNode.frame) / 2)
        cleanerNode.physicsBody?.affectedByGravity = false
        cleanerNode.physicsBody?.contactTestBitMask = ContactCategory.Garbage.rawValue
        cleanerNode.physicsBody?.categoryBitMask = ContactCategory.Cleaner.rawValue

        powerNode = SKSpriteNode(color: SKColor.cyanColor(), size: CGSizeMake(50.0, 20.0))
        powerNode.position = CGPointMake(10.0, CGRectGetMaxY(frame) - powerNode.size.height - 10.0)
        powerNode.anchorPoint = CGPointZero
        addChild(powerNode)

        ruleSystem = GKRuleSystem()
        let rules = [
            GKRule(predicate: NSPredicate(format: "$distanceToCharger > 550"), assertingFact: "charge", grade: 1.0),
            GKRule(predicate: NSPredicate(format: "$power <= 30"), assertingFact: "charge", grade: 1.0),
        ]
        ruleSystem.addRulesFromArray(rules)

        createGarbages()
    }

    func createGarbages() {
        let count = GKRandomDistribution.d6().nextInt()
        for _ in 0...count {
            let garbage = SKSpriteNode(color: SKColor.lightGrayColor(), size: CGSizeMake(10.0, 10.0))
            garbage.position = randomPosition()
            addChild(garbage)
            garbage.physicsBody = SKPhysicsBody(rectangleOfSize: garbage.frame.size)
            garbage.physicsBody?.affectedByGravity = false
            garbage.physicsBody?.contactTestBitMask = ContactCategory.Cleaner.rawValue
            garbage.physicsBody?.categoryBitMask = ContactCategory.Garbage.rawValue
        }
    }

    func randomPosition() -> CGPoint {
        let x = GKRandomDistribution(lowestValue: 30, highestValue: Int(CGRectGetMaxX(frame)) - 30).nextInt()
        let y = GKRandomDistribution(lowestValue: 30, highestValue: Int(CGRectGetMaxY(frame)) - 30).nextInt()
        return CGPointMake(CGFloat(x), CGFloat(y))
    }

    override func update(currentTime: NSTimeInterval) {
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

            let charge = ruleSystem.gradeForFact("charge")
            if charge > 0.0 {
                let action = SKAction.moveTo(chargerNode.position, duration: 1.0)
                cleanerNode.runAction(action) {
                    self.power = 100
                }
            } else {
                let action = SKAction.moveTo(randomPosition(), duration: 1.0)
                cleanerNode.runAction(action) {
                    self.power -= 10
                }
            }
            waitingTime = 0
        }
    }

    func updatePowerNode() {
        powerNode.size.width = CGFloat(power / 2)
    }

    // MARK: - SKPhysicsContactDelegate

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

        if firstBody.categoryBitMask & ContactCategory.Cleaner.rawValue > 0 && secondBody.categoryBitMask & ContactCategory.Garbage.rawValue > 0 {
            secondBody.node?.removeFromParent()
        }
    }
}
