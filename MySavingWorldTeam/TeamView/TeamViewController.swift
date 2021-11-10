//
//  TeamViewController.swift
//  MySavingWorldTeam
//
//  Created by Елена Дранкина on 10.11.2021.
//

import UIKit

class TeamViewController: UIViewController {
    
    var team: Team?
    
    var playerAmount = 3
    var stackHeight: CGFloat = 0
    let playerBlockHeight: CGFloat = 120.0
    let playerStackSpacing: CGFloat = 15
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let imageBackground: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "teamCreate")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private let teamNameBack: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backbg")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let playerBack: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backbg")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название команды"
        label.textColor = .black
        label.font = UIFont(name: "mr_OzHandicraft_BTG", size: 20)
        return label
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
    
    private let equipPlaceBack: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "equipPlaceHolder")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var teamNameStackView = UIStackView()
    private let teamEmblem = UIImageView()
    private let teamNameTextField = UITextField()
    private let playerAvatar = UIImageView()
    private let playerName = UITextField()
    private let playerTount = UITextField()
    private var playerEquipStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setupTeam()
        setupViews()
        registerKeyboardNotification()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.setConstraints(to: view, constant: 0)
        scrollView.addSubview(imageBackground)
        imageBackground.setConstraints(to: view, constant: 0)
        imageBackground.addSubview(teamEmblem)
        imageBackground.addSubview(teamNameBack)
        setupAllPlayers()
        setupTeamNameStackView()
        self.view.addSubview(teamNameStackView)
    }
    
    private func setupTeam() {
        teamEmblem.translatesAutoresizingMaskIntoConstraints = false
        teamNameTextField.translatesAutoresizingMaskIntoConstraints = false
        teamEmblem.clipsToBounds = true
        teamNameTextField.borderStyle = .roundedRect
        teamNameTextField.placeholder = "Введите текст"
        teamNameTextField.font = UIFont(name: "mr_OzHandicraft_BTG", size: 20)
        if team == nil {
            teamEmblem.image = UIImage(named: "emblem2")
            teamNameTextField.text = ""
        } else {
            teamEmblem.image = UIImage(named: team!.emblem)
            teamNameTextField.text = team!.name
        }
    }
    
    private func setupTeamNameStackView() {
        teamNameStackView = UIStackView(arrangedSubviews: [teamNameLabel, teamNameTextField])
        teamNameStackView.translatesAutoresizingMaskIntoConstraints = false
        teamNameStackView.axis = .vertical
        teamNameStackView.alignment = .fill
        teamNameStackView.distribution = .fillProportionally
        teamNameStackView.spacing = 5
    }
    
    private func setupEquipStack() {
        playerEquipStack = UIStackView(arrangedSubviews: [equipPlaceBack, equipPlaceBack, equipPlaceBack, equipPlaceBack])
        playerEquipStack.axis = .horizontal
        playerEquipStack.distribution = .fillProportionally
        playerEquipStack.spacing = 10
    }
    
    private func setupTextFields(for textFields: [UITextField], index: Int) {
        for textField in textFields {
            textField.borderStyle = .roundedRect
            textField.placeholder = "Введите текст"
            textField.font = UIFont(name: "mr_OzHandicraft_BTG", size: 20)
            
            if team == nil {
                textField.text = ""
            } else {
                playerName.text = team!.heroes[index].name
                playerTount.text = team!.heroes[index].tount
            }
        }
    }
    
    private func setupPlayerAvatar(_ index: Int) {
        playerAvatar.clipsToBounds = true
        if team == nil {
            playerAvatar.image = UIImage(named: "avatar12")
        } else {
            playerAvatar.image = UIImage(named: team!.heroes[index].avatar)
        }
    }
    
    private func setupPlayerBlock(_ index: Int) {
        setupPlayerAvatar(index)
        setupTextFields(for: [playerName, playerTount], index: index)
        view.addSubview(playerBack)
        view.addSubview(playerAvatar)
        view.addSubview(playerNameLabel)
        view.addSubview(playerName)
        view.addSubview(playerTountLabel)
        view.addSubview(playerTount)
        view.addSubview(playerEquipLabel)
        view.addSubview(playerEquipStack)
        setAllPlayerConstraints(index)
    }
    
    private func setupAllPlayers() {
        var index = 0
        if team == nil {
            for _ in 1...playerAmount {
                setupPlayerBlock(index)
                index += 1
            }
        } else {

            for _ in team!.heroes {
                setupPlayerBlock(index)
                index += 1
            }
        }
    }
    
    private func setDelegate() {
        teamNameTextField.delegate = self
        playerName.delegate = self
        playerTount.delegate = self
    }
}

extension TeamViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        teamNameTextField.resignFirstResponder()
        playerName.resignFirstResponder()
        playerTount.resignFirstResponder()
        return true
    }
}

extension TeamViewController {
    private func setConstraints() {
        teamEmblem.topAnchor.constraint(equalTo: imageBackground.topAnchor, constant: 100).isActive = true
        teamEmblem.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor, constant: 30).isActive = true
        teamEmblem.heightAnchor.constraint(equalToConstant: 80).isActive = true
        teamEmblem.widthAnchor.constraint(equalToConstant: 80).isActive = true
    
        teamNameBack.topAnchor.constraint(equalTo: imageBackground.topAnchor, constant: 100).isActive = true
        teamNameBack.leadingAnchor.constraint(equalTo: teamEmblem.trailingAnchor, constant: 15).isActive = true
        teamNameBack.heightAnchor.constraint(equalToConstant: 80).isActive = true
        teamNameBack.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -30).isActive = true
        
        teamNameStackView.centerXAnchor.constraint(equalTo: teamNameBack.centerXAnchor).isActive = true
        teamNameStackView.centerYAnchor.constraint(equalTo: teamNameBack.centerYAnchor).isActive = true
        teamNameStackView.leadingAnchor.constraint(equalTo: teamNameBack.leadingAnchor, constant: 20).isActive = true
        teamNameStackView.trailingAnchor.constraint(equalTo: teamNameBack.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setPlayerBackConstraints(_ topConstant: Int) {
        playerBack.translatesAutoresizingMaskIntoConstraints = false
        playerBack.topAnchor.constraint(equalTo: teamEmblem.bottomAnchor, constant: 15 + CGFloat(topConstant) * ( playerBlockHeight + 15 )).isActive = true
        playerBack.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor, constant: 30).isActive = true
        playerBack.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -30).isActive = true
        playerBack.heightAnchor.constraint(equalToConstant: playerBlockHeight).isActive = true
    }
    
    private func setPlayerBlockConstraints(for view: UIView, topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, leadAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, height: CGFloat, width: CGFloat?, constant: CGFloat, topConstant: Int) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor, constant: constant + CGFloat(topConstant) * ( playerBlockHeight + 15 )).isActive = true
        view.leadingAnchor.constraint(equalTo: leadAnchor, constant: constant).isActive = true
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        if width == nil {
            view.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -(30 + constant)).isActive = true
        } else {
            view.widthAnchor.constraint(equalToConstant: width!).isActive = true
        }
    }
    
    private func setAllPlayerConstraints(_ index: Int) {
        setPlayerBackConstraints(index)
        setPlayerBlockConstraints(for: playerAvatar, topAnchor: playerBack.topAnchor, leadAnchor: playerBack.leadingAnchor, height: 100, width: 67, constant: 10, topConstant: index)
        setPlayerBlockConstraints(for: playerNameLabel, topAnchor: playerBack.topAnchor, leadAnchor: playerAvatar.trailingAnchor, height: 20, width: 55, constant: 15, topConstant: index)
        setPlayerBlockConstraints(for: playerTountLabel, topAnchor: playerNameLabel.bottomAnchor, leadAnchor: playerAvatar.trailingAnchor, height: 20, width: 55, constant: 15, topConstant: index)
        setPlayerBlockConstraints(for: playerEquipLabel, topAnchor: playerTountLabel.bottomAnchor, leadAnchor: playerAvatar.trailingAnchor, height: 20, width: 55, constant: 15, topConstant: index)
        setPlayerBlockConstraints(for: playerName, topAnchor: playerBack.topAnchor, leadAnchor: playerNameLabel.trailingAnchor, height: 20, width: nil, constant: 15, topConstant: index)
        setPlayerBlockConstraints(for: playerTount, topAnchor: playerName.bottomAnchor, leadAnchor: playerTountLabel.trailingAnchor, height: 20, width: nil, constant: 15, topConstant: index)
        setPlayerBlockConstraints(for: playerEquipStack, topAnchor: playerTount.bottomAnchor, leadAnchor: playerEquipLabel.trailingAnchor, height: 20, width: nil, constant: 15, topConstant: index)
    }
}

