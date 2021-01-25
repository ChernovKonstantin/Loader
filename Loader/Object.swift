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
    var maxV: Int
    var position: Point
//    {
//        didSet{
//            if position.x == 0 || position.y == 0 || position.x == maxV || position.y == maxV{
//                scores -= 1
//                resetBoxPosition()
//            }
//            if position.x == pointToWin.x && position.y == pointToWin.y{
//                scores += 1
//                resetWinPosition()
//            }
//        }
//    }
    init(name: String, position: Point, pointToWin: Point, maxV: Int) {
        self.name = name
        self.position = position
        self.pointToWin = pointToWin
        self.maxV = maxV
    }
    var pointToWin: Point
    
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
    
    
    func resetWinPosition() {
        self.pointToWin = Point(x: Int.random(in: 1...maxV-1), y: Int.random(in: 1...maxV-1))
    }
    
    func resetBoxPosition() {
        let newPosition = Point(x: Int.random(in: 1...maxV-1), y: Int.random(in: 1...maxV-1))
        if (newPosition.x != self.pointToWin.x) && (newPosition.y != self.pointToWin.y){
            self.position = newPosition
        }else{
            resetBoxPosition()}
    }
}


