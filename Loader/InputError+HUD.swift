//
//  InputError+HUD.swift
//  Loader
//
//  Created by Константин Чернов on 28.01.2021.
//

import Foundation
import PKHUD

enum InputError{
    case personX
    case personY
    case boxX
    case boxY
    case dropX
    case dropY
    case room
    case coordinates
}

func showHUD(for input: InputError){
    switch input {
    case .boxX: HUD.flash(.labeledError(title: "Wrong Box X", subtitle: nil), delay: 1.5)
    case .boxY: HUD.flash(.labeledError(title: "Wrong Box Y", subtitle: nil), delay: 1.5)
    case .dropX: HUD.flash(.labeledError(title: "Wrong Drop X", subtitle: nil), delay: 1.5)
    case .dropY: HUD.flash(.labeledError(title: "Wrong Drop Y", subtitle: nil), delay: 1.5)
    case .personX: HUD.flash(.labeledError(title: "Wrong Person X", subtitle: nil), delay: 1.5)
    case .personY: HUD.flash(.labeledError(title: "Wrong Person Y", subtitle: nil), delay: 1.5)
    case .room: HUD.flash(.labeledError(title: "Wrong room size", subtitle: nil), delay: 1.5)
    case .coordinates: HUD.flash(.labeledError(title: "Coordinates are same.", subtitle: "Please check"), delay: 1.5)
    }
}
