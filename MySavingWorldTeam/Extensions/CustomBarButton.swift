//
//  CustomBarButton.swift
//  MySavingWorldTeam
//
//  Created by Елена Дранкина on 10.11.2021.
//

import UIKit

extension UIViewController {
    
    func createCustomBarButton(selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton()
        
        let buttonImage = UIImage(named: "addButton")
        button.setImage(buttonImage, for: .normal)
        
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
