//
//  UIViewController+Extension.swift
//  Loader
//
//  Created by Константин Чернов on 24.01.2021.
//

import Foundation
import UIKit

extension UIViewController {
  func hideKeyboardWhenTapAround() {
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    view.addGestureRecognizer(gestureRecognizer)
  }
  
  @objc func hideKeyboard() {
    view.endEditing(true) //resignFirstResponder()
  }
}
