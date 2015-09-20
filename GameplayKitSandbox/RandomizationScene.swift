//
//  RandomizationScene.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/20.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class RandomizationScene: ExampleScene {

    let degrees = [Int](0...72).map { $0 * (360 / 72) }
    let examples = [
        [GKARC4RandomSource.self, SKColor.cyanColor(), "ARC4"],
        [GKLinearCongruentialRandomSource.self, SKColor.magentaColor(), "LinearCongruential"],
        [GKMersenneTwisterRandomSource.self, SKColor.yellowColor(), "MersenneTwister"],
    ]

    var distributionIndex = 0 {
        didSet {
            removeAllChildren()
            createSceneContents()
        }
    }
    var distributions = [
        GKRandomDistribution.self,
        GKGaussianDistribution.self,
        GKShuffledDistribution.self,
    ]

    override func createSceneContents() {
        for (i, example) in examples.enumerate() {
            let type = example[0] as! GKRandomSource.Type
            let source = type.sharedRandom()

            let color = example[1] as! UIColor
            let radius = CGRectGetWidth(frame) * (0.4 - CGFloat(i) * 0.05)

            draw(distribution(source), color: color, radius: radius)

            let label = SKLabelNode(text: example[2] as? String)
            label.fontSize = 16.0
            label.fontName = UIFont.boldSystemFontOfSize(UIFont.systemFontSize()).fontName
            let padding: CGFloat = 10.0
            label.position = CGPointMake(padding, CGRectGetMaxY(frame) - CGFloat(i) * label.fontSize - padding)
            label.fontColor = color
            label.horizontalAlignmentMode = .Left
            label.verticalAlignmentMode = .Top
            addChild(label)
        }
    }

    func distribution(source: GKRandomSource) -> GKRandomDistribution {
        return distributions[distributionIndex].init(randomSource: source, lowestValue: 0, highestValue: degrees.count - 1)
    }

    func draw(distribution: GKRandomDistribution, color: SKColor, radius: CGFloat) {
        let center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))

        for _ in 0..<degrees.count {
            let degree = Float(degrees[distribution.nextInt()])
            let radian = CGFloat(GLKMathDegreesToRadians(degree))
            let x = center.x + radius * sin(radian)
            let y = center.y + radius * cos(radian)
            let circle = SKShapeNode(circleOfRadius: 3.0)
            circle.position = CGPointMake(x, y)
            circle.fillColor = color
            circle.strokeColor = SKColor.clearColor()
            addChild(circle)
        }
    }
}
