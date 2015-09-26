//
//  Player.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/23.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

import GameplayKit

class Player: NSObject, GKGameModelPlayer {
    let mark: Mark

    init(mark: Mark) {
        self.mark = mark
    }

    static var _players = [
        Player(mark: .O),
        Player(mark: .X),
    ]

    class func oPlayer() -> Player {
        return _players[Mark.O.rawValue - 1]
    }

    class func xPlayer() -> Player {
        return _players[Mark.X.rawValue - 1]
    }

    class func all() -> [Player] {
        return _players
    }

    func opponent() -> Player? {
        switch mark {
        case .O:
            return Player.xPlayer()
        case .X:
            return Player.oPlayer()
        default:
            return nil
        }
    }

    // MARK: GKGameModelPlayer

    var playerId: Int {
        return mark.rawValue
    }
}
