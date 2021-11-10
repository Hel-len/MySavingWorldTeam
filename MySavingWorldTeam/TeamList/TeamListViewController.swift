//
//  TeamListViewController.swift
//  MySavingWorldTeam
//
//  Created by Елена Дранкина on 10.11.2021.
//

import UIKit

class TeamListViewController: UIViewController {
    
    var tableView = UITableView()
    var teamLeader = ""
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = UIImage(named: "teamListBack")
        return image
    }()
    
    private let navigationBarLabel: UILabel = {
        let label = UILabel()
        label.text = "Доступные команды"
        label.textColor = .white
        label.font = UIFont(name: "mr_OzHandicraft_BTG", size: 30)
        return label
    }()
    
    let teams = Team.getTeams()
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        configurateBackground()
        configurateTableView()
        setNavigationBar()
        setupSearchController()
        setDelegates()
        setNavigationItem()
        setCustomBackButton()
    }
    
    private func setNavigationItem() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setCustomBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backBarButton")
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backBarButton")
    }
    
    private func setNavigationBar() {
        navigationItem.titleView = navigationBarLabel
        let addNewTeam = createCustomBarButton(selector: #selector(newTeamButtonTapped))
        navigationItem.rightBarButtonItem = addNewTeam
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func configurateBackground() {
        view.addSubview(imageView)
        imageView.setConstraints(to: view, constant: 0)
    }
    
    private func configurateTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(white: 1, alpha: 0)
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "teamCell")
        tableView.setConstraints(to: imageView, constant: 20)
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchBar.delegate = self
    }
    
    @objc private func newTeamButtonTapped() {
        let teamVC = TeamViewController()
        navigationController?.pushViewController(teamVC, animated: true)
    }
    
    private func findTeamLeader(team: Team) {
        for hero in team.heroes {
            if hero.isCaptain == true {
                teamLeader = hero.name
            }
        }
    }

}

extension TeamListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
        let team = teams[indexPath.row]
        findTeamLeader(team: team)

        var content = cell.defaultContentConfiguration()
        content.text = team.name
        content.secondaryText = teamLeader
        content.image = UIImage(named: team.emblem)
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = teams[indexPath.row]
        let teamViewController = TeamViewController()
        teamViewController.team = team
        navigationController?.pushViewController(teamViewController, animated: true)
    }
}

extension TeamListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

