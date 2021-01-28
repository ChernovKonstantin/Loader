//
//  Object.swift
//  Loader
//
//  Created by Константин Чернов on 25.12.2020.
//

import Foundation

class Object{
    var scores = 0
    var name: String
    var position: Point
    var pointToWin: Point

    init(name: String, position: Point, pointToWin: Point) {
        self.name = name
        self.position = position
        self.pointToWin = pointToWin
    }
    
    func moveTo(direction: Direction, in room: Room) -> Bool{
        let startPoint = (x: 0, y: 0)
        let finishPoint = (x: room.width, y: room.length)
        switch (position.x, position.y, direction) {
        case (startPoint.x, _, .left): break
        case (_, finishPoint.y, .right): break
        case (_, startPoint.x, .up): break
        case (finishPoint.y, _, .down): break
        default: position.x = position.x+direction.stepWithDirection.x; position.y = position.y+direction.stepWithDirection.y
            return true
        }
        return false
    }
}


