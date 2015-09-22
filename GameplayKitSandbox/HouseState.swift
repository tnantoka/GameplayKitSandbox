//
//  HouseState.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/22.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import GameplayKit

class HouseState: GKState {
    let entity: GKEntity

    init(entity: GKEntity) {
        self.entity = entity
    }
}
