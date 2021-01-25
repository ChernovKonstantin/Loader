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
    
    @IBOutlet weak var roomWIdth: UITextField!
    @IBOutlet weak var personX: UITextField!
    @IBOutlet weak var personY: UITextField!
    @IBOutlet weak var boxX: UITextField!
    @IBOutlet weak var boxY: UITextField!
    @IBOutlet weak var winX: UITextField!
    @IBOutlet weak var winY: UITextField!
    
    @IBAction func updatePosition(_ sender: UIButton) {
        guard !personX.text!.isEmpty, !personY.text!.isEmpty, !boxX.text!.isEmpty, !boxY.text!.isEmpty, !winX.text!.isEmpty, !winY.text!.isEmpty
        else {
            HUD.flash(.labeledError(title: "Please fill all the coordinates", subtitle: nil), delay: 1.5)
            return
        }
        delegate?.updateInfo(roomSize: roomWIdth.text!,
                             personX: personX.text!,
                             personY: personY.text!,
                             boxX: boxX.text!,
                             boxY: boxY.text!,
                             winX: winX.text!,
                             winY: winY.text!)
        self.dismiss(animated: true)
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
    
    private func setLabelText(){
        if let person = person{
            personX.text = "\(person.position.x)"
            personY.text = "\(person.position.y)"
            boxX.text = "\(person.box.position.x)"
            boxY.text = "\(person.box.position.y)"
            winX.text = "\(person.box.pointToWin.x)"
            winY.text = "\(person.box.pointToWin.y)"
            roomWIdth.text = "\(person.room.width)"
        }
    }
}

protocol InputDataUpdate{
    func updateInfo(roomSize: String, personX: String, personY: String, boxX: String, boxY: String, winX: String, winY: String)
}
