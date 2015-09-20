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

    override func didMoveToView(view: SKView) {
        if !contentCreated {
            createSceneContents()
            contentCreated = true
        }
    }

    func createSceneContents() {
    }
}
