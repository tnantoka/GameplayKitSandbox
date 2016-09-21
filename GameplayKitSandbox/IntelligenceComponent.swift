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

    var waitingMoveTime: TimeInterval = 0
    var waitingAttackTime: TimeInterval = 0
    let random = GKRandomDistribution(lowestValue: -30, highestValue: 30)

    override func update(deltaTime seconds: TimeInterval) {
        waitingMoveTime += seconds
        waitingAttackTime += seconds

        if waitingMoveTime > 1 {
            let x = CGFloat(random.nextInt())
            let y = CGFloat(random.nextInt())
            if let entity = entity {
                if let visualComponent = entity.component(ofType: VisualComponent.self) {
                    visualComponent.moveBy(x, y)
                }

            }
            waitingMoveTime = 0
        }
        if waitingAttackTime > 3 {
            if let entity = entity {
                if let attackComponent = entity.component(ofType: AttackComponent.self) {
                    attackComponent.attack()
                }
            }
            waitingAttackTime = 0
        }
    }
}
