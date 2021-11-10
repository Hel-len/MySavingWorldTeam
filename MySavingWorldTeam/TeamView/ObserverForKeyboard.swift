//
//  ObserverForKeyboard.swift
//  MySavingWorldTeam
//
//  Created by Елена Дранкина on 10.11.2021.
//

import UIKit

extension TeamViewController {
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow() {
        print(#function)
    }
    
    @objc private func keyboardWillHide() {
        print(#function)
    }
}
