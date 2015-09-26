//
//  Mark.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/24.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

enum Mark :Int {
    case None
    case O
    case X

    func text() -> String {
        switch self {
        case .O:
            return "o"
        case .X:
            return "x"
        default:
            return ""
        }
    }
}
