//
//  helper.swift
//  MySavingWorldTeam
//
//  Created by Елена Дранкина on 10.11.2021.
//

import UIKit

extension UIView {
    func setConstraints(to superView: UIView, constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor, constant: 5 * constant).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -constant).isActive = true
    }
}
