//
//  Person.swift
//  Loader
//
//  Created by Константин Чернов on 25.12.2020.
//

import Foundation

class Person {
    
    init(){
        self.name = "🤠"
        self.position = Point(x: 0, y: 0)
        self.room = Room(width: 10)
        self.box = Object(name: "👹", position: Point(x: 1, y: 1), pointToWin: Point(x: 2, y: 2), maxV: room.width-1)

    }
    
    let name: String
    var position: Point

    var box: Object
    var room: Room
    
    init(name: String, position: Point, box: Object, room: Room) {
        self.name = name
        self.position = position
        self.box = box
        self.room = room
    }
    
    func moveTo(direction: Direction){
        let startPoint = (x: 0, y: 0)
        let finishPoint = (x: room.width-1, y: room.length-1)
        
        switch (position.x, position.y, direction) {
        case (startPoint.x, _, .left): break
        case (finishPoint.y, _, .right): break
        case (_, startPoint.x, .up): break
        case (_, finishPoint.y, .down): break
        default:
            if box.position.x == position.x+direction.stepWithDirection.x, box.position.y == position.y+direction.stepWithDirection.y{
                guard box.moveTo(direction: direction, in: room) else {break}
                position.x = position.x+direction.stepWithDirection.x
                position.y = position.y+direction.stepWithDirection.y
            }else {
                position.x = position.x+direction.stepWithDirection.x
                position.y = position.y+direction.stepWithDirection.y
            }
        }
    }
    
    func numberOfCells() -> Int{
        return room.width*room.length
    }
    func currentPosition() -> Int{
        return (room.width*position.y+position.x)
    }
    func boxCurrentPosition()->Int{
        return (room.width*box.position.y+box.position.x)
    }
    func finalPosition()->Int{
        return (room.width*box.pointToWin.y+box.pointToWin.x)
    }
    
    func newGame(){
        let newPosition = Point(x: Int.random(in: 0...room.width-1), y: Int.random(in: 0...room.width-1))
        box.resetWinPosition()
        box.resetBoxPosition()
        if newPosition.x != box.position.x && newPosition.y != box.position.y,
            newPosition.x != box.pointToWin.x && newPosition.y != box.pointToWin.y{
            self.position = newPosition
            box.scores = 0
        }
        else{
            newGame()
        }
    }
}
