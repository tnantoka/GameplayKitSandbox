//
//  HouseBurningState.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/22.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import GameplayKit

class HouseBurningState: HouseState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == HouseWetState.self
    }

    override func didEnter(from previousState: GKState?) {
        if let component = entity.component(ofType: BurnableComponent.self) {
            component.useBurningAppearance()
        }
    }
}
