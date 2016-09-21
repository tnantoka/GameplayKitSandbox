//
//  HouseWetState.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/22.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import GameplayKit

class HouseWetState: HouseState {

    var remainingTime: TimeInterval = 0

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == HouseDryState.self
    }

    override func didEnter(from previousState: GKState?) {
        if let component = entity.component(ofType: BurnableComponent.self) {
            component.useWetAppearance()
            remainingTime = 3.0
        }
    }

    override func update(deltaTime seconds: TimeInterval) {
        remainingTime -= seconds
        if remainingTime < 0 {
            stateMachine?.enter(HouseDryState.self)
        }
    }
}
