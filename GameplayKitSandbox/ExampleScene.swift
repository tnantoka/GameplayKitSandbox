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
        return CGPoint(x: frame.midX, y: frame.midY)
    }

    var prevUpdateTime: TimeInterval = -1;
    var deltaTime: TimeInterval = 0

    override init(size: CGSize) {
        super.init(size: size)
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        if !contentCreated {
            createSceneContents()
            contentCreated = true
        }
    }

    func createSceneContents() {
    }

    override func update(_ currentTime: TimeInterval) {
        if (prevUpdateTime < 0) {
            prevUpdateTime = currentTime
        }
        deltaTime = currentTime - prevUpdateTime
        prevUpdateTime = currentTime
    }

    func createLabel(_ text: String, color: SKColor, order: Int) {
        let label = SKLabelNode(text: text)
        label.fontSize = 14.0
        label.fontName = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize).fontName
        let padding: CGFloat = 10.0
        label.position = CGPoint(x: padding, y: frame.maxY - CGFloat(order) * label.fontSize - padding)
        label.fontColor = color
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .top
        addChild(label)
    }
}
