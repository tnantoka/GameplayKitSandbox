//
//  ExampleScene.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/20.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import SpriteKit

class ExampleScene: SKScene {

    var contentCreated = false

    var center: CGPoint {
        return CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
    }

    var prevUpdateTime: NSTimeInterval = -1;
    var deltaTime: NSTimeInterval = 0

    override init(size: CGSize) {
        super.init(size: size)
        userInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToView(view: SKView) {
        if !contentCreated {
            createSceneContents()
            contentCreated = true
        }
    }

    func createSceneContents() {
    }

    override func update(currentTime: NSTimeInterval) {
        if (prevUpdateTime < 0) {
            prevUpdateTime = currentTime
        }
        deltaTime = currentTime - prevUpdateTime
        prevUpdateTime = currentTime
    }

    func createLabel(text: String, color: SKColor, order: Int) {
        let label = SKLabelNode(text: text)
        label.fontSize = 14.0
        label.fontName = UIFont.boldSystemFontOfSize(UIFont.systemFontSize()).fontName
        let padding: CGFloat = 10.0
        label.position = CGPointMake(padding, CGRectGetMaxY(frame) - CGFloat(order) * label.fontSize - padding)
        label.fontColor = color
        label.horizontalAlignmentMode = .Left
        label.verticalAlignmentMode = .Top
        addChild(label)
    }
}
