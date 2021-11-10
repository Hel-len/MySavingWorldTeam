//
//  PlayerTableViewCell.swift
//  MySavingWorldTeam
//
//  Created by Елена Дранкина on 10.11.2021.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    static let identifier = "PlayerTableViewCell"
    
    private let playerAvatar: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя героя"
        label.textColor = .black
        label.font = UIFont(name: "mr_OzHandicraft_BTG", size: 20)
        return label
    }()
    
    private let playerTountLabel: UILabel = {
        let label = UILabel()
        label.text = "Насмешка"
        label.textColor = .black
        label.font = UIFont(name: "mr_OzHandicraft_BTG", size: 20)
        return label
    }()
    
    private let playerEquipLabel: UILabel = {
        let label = UILabel()
        label.text = "Предметы"
        label.textColor = .black
        label.font = UIFont(name: "mr_OzHandicraft_BTG", size: 20)
        return label
    }()
    
    private let playerBack: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backbg")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let equipPlaceBack: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "equipPlaceHolder")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var nameStackView = UIStackView()
    private var tountStackView = UIStackView()
    private let playerName = UITextField()
    private let playerTount = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(playerBack)
        contentView.addSubview(playerAvatar)
        setupStackViews([nameStackView, tountStackView])
        contentView.addSubview(nameStackView)
        contentView.addSubview(tountStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerBack.frame = CGRect(x: 0,
                                  y: 0,
                                  width: contentView.frame.size.width,
                                  height: contentView.frame.size.height)
        playerAvatar.frame = CGRect(x: 10,
                                    y: 10,
                                    width: 67,
                                    height: 100)
        nameStackView.frame = CGRect(x: 87,
                                     y: 10,
                                     width: contentView.frame.size.width - 97,
                                     height: 30)
        tountStackView.frame = CGRect(x: 87,
                                      y: 40,
                                      width: contentView.frame.size.width - 97,
                                      height: 30)

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        playerAvatar.image = nil
        playerName.text = nil
        playerTount.text = nil
    }
    
    private func setupTextFields(_ textfields: [UITextField]) {
        for textField in textfields {
            textField.borderStyle = .roundedRect
            textField.placeholder = "Введите текст"
            textField.font = UIFont(name: "mr_OzHandicraft_BTG", size: 20)
        }
    }
    
    private func setupStackViews(_ stackViews: [UIStackView]) {
        setupTextFields([playerName, playerTount])
        nameStackView = UIStackView(arrangedSubviews: [playerNameLabel, playerName])
        tountStackView = UIStackView(arrangedSubviews: [playerTountLabel, playerTount])
        for stackView in stackViews {
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.spacing = 5
            stackView.alignment = .fill
        }
    }
    
    func configure(player: Player?) {
        if player == nil {
            playerAvatar.image = UIImage(named: "avatar11")
            playerName.text = ""
            playerTount.text = ""
        } else {
            playerAvatar.image = UIImage(named: player!.avatar)
            playerName.text = player!.name
            playerTount.text = player!.tount
        }
    }
}
