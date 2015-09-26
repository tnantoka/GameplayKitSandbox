//
//  Move.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/25.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import GameplayKit

class Move: NSObject, GKGameModelUpdate {
    var value = 0
    var index: Int

    init(index: Int) {
        self.index = index
    }
}
