//
//  ViewController.swift
//  Loader
//
//  Created by Константин Чернов on 25.12.2020.
//

import UIKit
import PKHUD

class ViewController: UIViewController {
    var person = Person()
    var segueIdentifier = "Input"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scores: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    
    @IBAction func newGame(_ sender: UIButton) {
        person.newGame()
        updateView()
    }
    @IBAction func moveUP(_ sender: UIButton) {
        person.moveTo(direction: .up)
        updateView()
    }
    @IBAction func moveLeft(_ sender: UIButton) {
        person.moveTo(direction: .left)
        updateView()
    }
    @IBAction func moveRight(_ sender: UIButton) {
        person.moveTo(direction: .right)
        updateView()
    }
    @IBAction func moveDown(_ sender: UIButton) {
        person.moveTo(direction: .down)
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        leftButton.layer.cornerRadius = 35.0
        downButton.layer.cornerRadius = 35.0
        rightButton.layer.cornerRadius = 35.0
        upButton.layer.cornerRadius = 35.0
        
        
    }
    
    func updateView(){
        
        if person.position.x == person.box.pointToWin.x, person.position.y == person.box.pointToWin.y{
            person.box.scores -= 1
            HUD.flash(.labeledError(title: "You died", subtitle: "New game"), delay: 1.5)
            person.newGame() 
        }
        
        if person.box.position.x == 0 || person.box.position.y == 0 || person.box.position.x == person.room.width-1 || person.box.position.y == person.room.width-1{
            person.box.scores -= 1
            HUD.flash(.labeledError(title: "You lost 1 score", subtitle: nil), delay: 1.5)
            person.resetBoxPosition()
            person.resetWinPosition()
            
        }
        if person.box.position.x == person.box.pointToWin.x && person.box.position.y == person.box.pointToWin.y{
            person.box.scores += 1
            HUD.flash(.labeledSuccess(title: "You get 1 score", subtitle: nil), delay: 1.5)
            person.resetBoxPosition()
            person.resetWinPosition()
        }
        
        scores.text = String("Scores: \(person.box.scores)")
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier, let vc = segue.destination as? InputDataViewController{
            vc.delegate = self
            vc.person = person
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CustomCollectionViewCell{
            cell.setModeltoUI(person: person, index: indexPath.item)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width / CGFloat(person.room.width)) - 1
        return CGSize(width: size, height: size)
    }
}

extension ViewController: InputDataUpdate{    
    func updateInfo(roomSize: Int, personX: Int, personY: Int, boxX: Int, boxY: Int, winX: Int, winY: Int) {
            person.room.width = roomSize
            person.position.x = personX
            person.position.y = personY
            person.box.position.x = boxX
            person.box.position.y = boxY
            person.box.pointToWin.x = winX
            person.box.pointToWin.y = winY
        
        collectionView.reloadData()
    }
}
