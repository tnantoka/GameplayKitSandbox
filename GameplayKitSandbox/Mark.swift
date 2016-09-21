//
//  Mark.swift
//  GameplayKitSandbox
//
//  Created by Tatsuya Tobioka on 2015/09/24.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import UIKit

enum Mark :Int {
    case none
    case o
    case x

    func text() -> String {
        switch self {
        case .o:
            return "o"
        case .x:
            return "x"
        default:
            return ""
        }
    }
}
