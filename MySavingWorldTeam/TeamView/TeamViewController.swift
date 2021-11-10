//
//  TeamViewController.swift
//  MySavingWorldTeam
//
//  Created by Елена Дранкина on 10.11.2021.
//

import UIKit

class TeamViewController: UIViewController {
    
    var team: Team?
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(white: 1, alpha: 0)
        tableView.rowHeight = 120
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: PlayerTableViewCell.identifier)
        return tableView
    }()
    
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
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название команды"
        label.textColor = .black
        label.font = UIFont(name: "mr_OzHandicraft_BTG", size: 20)
        return label
    }()
    
    private let addEmblemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addEmblemButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var teamNameStackView = UIStackView()
    private let teamEmblem = UIImageView()
    private let teamNameTextField = UITextField()
    private var playerAmount = 3
    
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
        addEmblemButton.setImage(teamEmblem.image, for: .normal)
        view.addSubview(addEmblemButton)
        imageBackground.addSubview(teamNameBack)
        setupTeamNameStackView()
        self.view.addSubview(teamNameStackView)
        view.addSubview(tableView)
    }
    
    private func setupTeam() {
        teamNameTextField.translatesAutoresizingMaskIntoConstraints = false
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
    
    @objc private func addEmblemButtonTapped() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    private func setupTeamNameStackView() {
        teamNameStackView = UIStackView(arrangedSubviews: [teamNameLabel, teamNameTextField])
        teamNameStackView.translatesAutoresizingMaskIntoConstraints = false
        teamNameStackView.axis = .vertical
        teamNameStackView.alignment = .fill
        teamNameStackView.distribution = .fillProportionally
        teamNameStackView.spacing = 5
    }
    
    private func setDelegate() {
        teamNameTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TeamViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        teamNameTextField.resignFirstResponder()
        return true
    }
}

extension TeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = team?.players.count else { return playerAmount }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as! PlayerTableViewCell
        
        cell.configure(player: team?.players[indexPath.row])
        return cell
    }
}

extension TeamViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            teamEmblem.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension TeamViewController {
    private func setConstraints() {
        
        addEmblemButton.topAnchor.constraint(equalTo: imageBackground.topAnchor, constant: 100).isActive = true
        addEmblemButton.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor, constant: 30).isActive = true
        addEmblemButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        addEmblemButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    
        teamNameBack.topAnchor.constraint(equalTo: imageBackground.topAnchor, constant: 100).isActive = true
        teamNameBack.leadingAnchor.constraint(equalTo: addEmblemButton.trailingAnchor, constant: 15).isActive = true
        teamNameBack.heightAnchor.constraint(equalToConstant: 80).isActive = true
        teamNameBack.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -30).isActive = true
        
        teamNameStackView.centerXAnchor.constraint(equalTo: teamNameBack.centerXAnchor).isActive = true
        teamNameStackView.centerYAnchor.constraint(equalTo: teamNameBack.centerYAnchor).isActive = true
        teamNameStackView.leadingAnchor.constraint(equalTo: teamNameBack.leadingAnchor, constant: 20).isActive = true
        teamNameStackView.trailingAnchor.constraint(equalTo: teamNameBack.trailingAnchor, constant: -20).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: addEmblemButton.bottomAnchor, constant: 15).isActive = true
        tableView.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor, constant: 30).isActive = true
        tableView.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: imageBackground.bottomAnchor, constant: 0).isActive = true
    }
}

