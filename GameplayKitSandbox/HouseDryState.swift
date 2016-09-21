//
//  HouseDryState.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/22.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import GameplayKit

class HouseDryState: HouseState {
    override func didEnter(from previousState: GKState?) {
        if let component = entity.component(ofType: BurnableComponent.self) {
            component.useDryAppearance()
        }
    }
}
