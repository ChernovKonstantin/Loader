//
//  InputDataViewController.swift
//  Loader
//
//  Created by Константин Чернов on 06.01.2021.
//

import UIKit
import PKHUD

class InputDataViewController: UIViewController {
    
    var person: Person!
    
    @IBOutlet weak var roomSize: UITextField!
    @IBOutlet weak var personX: UITextField!
    @IBOutlet weak var personY: UITextField!
    @IBOutlet weak var boxX: UITextField!
    @IBOutlet weak var boxY: UITextField!
    @IBOutlet weak var winX: UITextField!
    @IBOutlet weak var winY: UITextField!
    
    @IBAction func updatePosition(_ sender: UIButton) {
        if checkInputData(){
            self.dismiss(animated: true)}
    }
    
    var delegate: InputDataUpdate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLabelText()
    }
    
    private func checkInputData() -> Bool{
        if let roomSize = Int(roomSize.text!), roomSize <= 10, roomSize >= 6,
           let personX = Int(personX.text!), personX > 0, personX < person.room.width,
           let personY = Int(personY.text!), personY > 0, personY < person.room.width,
           let boxX = Int(boxX.text!), boxX > 1, boxX < person.room.width-1,
           let boxY = Int(boxY.text!), boxY > 1, boxY < person.room.width-1,
           let winX = Int(winX.text!), winX > 1, winX < person.room.width-1,
           let winY = Int(winY.text!), winY > 1, winY < person.room.width-1{
            if personX != boxX || personY != boxY,
               boxX != winX || boxY != winY,
               personX != winX || personY != winY
            {
            delegate?.updateInfo(roomSize: roomSize,
                                 personX: personX-1,
                                 personY: personY-1,
                                 boxX: boxX-1,
                                 boxY: boxY-1,
                                 winX: winX-1,
                                 winY: winY-1)
            return true
            }
        }
        HUD.flash(.labeledError(title: "Wrong coordinates", subtitle: nil), delay: 1.5)
        return false
    }
    
    private func setLabelText(){
        if let person = person{
            personX.text = "\(person.position.x+1)"
            personY.text = "\(person.position.y+1)"
            boxX.text = "\(person.box.position.x+1)"
            boxY.text = "\(person.box.position.y+1)"
            winX.text = "\(person.box.pointToWin.x+1)"
            winY.text = "\(person.box.pointToWin.y+1)"
            roomSize.text = "\(person.room.width)"
        }
    }
}

protocol InputDataUpdate{
    func updateInfo(roomSize: Int, personX: Int, personY: Int, boxX: Int, boxY: Int, winX: Int, winY: Int)
}
