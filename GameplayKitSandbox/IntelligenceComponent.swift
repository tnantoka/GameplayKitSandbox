//
//  IntelligenceComponent.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/21.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import GameplayKit

class IntelligenceComponent: GKComponent {

    var waitingMoveTime: NSTimeInterval = 0
    var waitingAttackTime: NSTimeInterval = 0
    let random = GKRandomDistribution(lowestValue: -30, highestValue: 30)

    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        waitingMoveTime += seconds
        waitingAttackTime += seconds

        if waitingMoveTime > 1 {
            let x = CGFloat(random.nextInt())
            let y = CGFloat(random.nextInt())
            if let entity = entity {
                if let visualComponent = entity.componentForClass(VisualComponent.self) {
                    visualComponent.moveBy(x, y)
                }

            }
            waitingMoveTime = 0
        }
        if waitingAttackTime > 3 {
            if let entity = entity {
                if let attackComponent = entity.componentForClass(AttackComponent.self) {
                    attackComponent.attack()
                }
            }
            waitingAttackTime = 0
        }
    }
}
