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

    var remainingTime: NSTimeInterval = 0

    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass == HouseDryState.self
    }

    override func didEnterWithPreviousState(previousState: GKState?) {
        if let component = entity.componentForClass(BurnableComponent.self) {
            component.useWetAppearance()
            remainingTime = 3.0
        }
    }

    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        remainingTime -= seconds
        if remainingTime < 0 {
            stateMachine?.enterState(HouseDryState.self)
        }
    }
}
