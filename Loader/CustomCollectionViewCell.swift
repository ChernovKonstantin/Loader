//
//  CustomCollectionViewCell.swift
//  Loader
//
//  Created by Константин Чернов on 24.01.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    var cellContent: UITextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createComponents()
    }
    
    private func createComponents() {
        self.cellContent = UITextField(frame: .zero)
        self.cellContent?.sizeToFit()
        self.cellContent?.backgroundColor = .opaqueSeparator
        self.cellContent?.borderStyle = .bezel
        self.cellContent?.isUserInteractionEnabled = false
        self.cellContent?.textAlignment = .center
        cellContent?.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cellContent ?? UIView())
        
        NSLayoutConstraint.activate([
            self.cellContent!.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.cellContent!.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
            self.cellContent!.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0),
            self.cellContent!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
        ])
    }
    
    public func setModeltoUI(person: Person, index: Int) {
        switch index {
        case person.currentPosition(): cellContent?.text = person.name
        case person.boxCurrentPosition(): cellContent?.text = person.box.name
        case person.finalPosition(): cellContent?.text = "🔥"
        default: cellContent?.text = ""
        }
    }
}
