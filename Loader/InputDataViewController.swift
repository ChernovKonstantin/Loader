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
    var sections = ["Room size", "Person location", "Box location", "Drop location"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func updatePosition(_ sender: UIButton) {
        if checkInputData(table: tableView){
            self.dismiss(animated: true)
        }
    }
    
    func setTextForLabels(for cell: UITableViewCell, X xText: String, Y yText: String){
        let xLabel = cell.viewWithTag(100) as! UITextField
        let yLabel = cell.viewWithTag(101) as! UITextField
        xLabel.text = xText
        if !yText.isEmpty{
            yLabel.text = yText}
        else{
            yLabel.isHidden = true
        }
    }
    
    var delegate: InputDataUpdate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.hideKeyboardWhenTapAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func checkInputData(table: UITableView) -> Bool{
        for i in 0...sections.count{
            if let cell = table.cellForRow(at: IndexPath(row: 0, section: i)){
                guard let xLabel = (cell.viewWithTag(100) as! UITextField).text else {return false }
                guard let yLabel = (cell.viewWithTag(101) as! UITextField).text else {return false }
                switch i {
                case 0:
                    guard let roomSize = Int(xLabel), roomSize <= 10, roomSize >= 6 else {
                        showHUD(for: .room); return false
                    }
                    person.room.width = roomSize
                case 1:
                    guard let personX = Int(xLabel), personX > 0, personX <= person.room.width else {
                        showHUD(for: .personX); return false
                    }
                    person.position.x = personX
                    guard let personY = Int(yLabel), personY > 0, personY <= person.room.width else {
                        showHUD(for: .personY); return false
                    }
                    person.position.y = personY
                case 2:
                    guard let boxX = Int(xLabel), boxX > 1, boxX < person.room.width else{
                        showHUD(for: .boxX); return false
                    }
                    person.box.position.x = boxX
                    guard  let boxY = Int(yLabel), boxY > 1, boxY < person.room.width else{
                        showHUD(for: .boxY); return false
                    }
                    person.box.position.y = boxY
                case 3:
                    guard let dropX = Int(xLabel), dropX > 1, dropX < person.room.width else{
                        showHUD(for: .dropX); return false
                    }
                    person.box.pointToWin.x = dropX
                    guard  let dropY = Int(yLabel), dropY > 1, dropY < person.room.width else{
                        showHUD(for: .dropY); return false
                    }
                    person.box.pointToWin.y = dropY
                default:
                    break
                }
            }
        }
        if person.position.x != person.box.position.x || person.position.y != person.box.position.y,
           person.box.position.x != person.box.pointToWin.x || person.box.position.y != person.box.pointToWin.y,
           person.position.x != person.box.pointToWin.x || person.position.y != person.box.pointToWin.y{
            delegate?.updateInfo(roomSize: person.room.width,
                                 personX: person.position.x-1,
                                 personY: person.position.y-1,
                                 boxX: person.box.position.x-1,
                                 boxY: person.box.position.y-1,
                                 winX: person.box.pointToWin.x-1,
                                 winY: person.box.pointToWin.y-1)
            return true
        } else{
            showHUD(for: .coordinates)
        }
        return false
    }
}

protocol InputDataUpdate{
    func updateInfo(roomSize: Int, personX: Int, personY: Int, boxX: Int, boxY: Int, winX: Int, winY: Int)
}

extension InputDataViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch indexPath.section {
        case 0: setTextForLabels(for: cell, X: "\(person.room.width)", Y: "");
        case 1: setTextForLabels(for: cell, X: "\(person.position.x+1)", Y: "\(person.position.y+1)")
        case 2: setTextForLabels(for: cell, X: "\(person.box.position.x+1)", Y: "\(person.box.position.y+1)")
        case 3: setTextForLabels(for: cell, X: "\(person.box.pointToWin.x+1)", Y: "\(person.box.pointToWin.y+1)")
        default: break
        }
        return cell
    }
}
