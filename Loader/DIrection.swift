//
//  DIrection.swift
//  Loader
//
//  Created by Константин Чернов on 25.12.2020.
//

import Foundation
enum Direction {
    case up
    case down
    case left
    case right
    
    var stepWithDirection: (x: Int, y: Int) {
        switch self {
        case .up: return (0, -1)
        case .down: return (0, 1)
        case .left: return (-1, 0)
        case .right: return (1, 0)
        }
    }
}
