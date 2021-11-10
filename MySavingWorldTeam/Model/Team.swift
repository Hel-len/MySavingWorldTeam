//
//  Team.swift
//  MySavingWorldTeam
//
//  Created by Елена Дранкина on 10.11.2021.
//
import UIKit

struct Team {
    let name: String
    let emblem: String
    let players: [Player]

    static func getTeams() -> [Team] {
        [
            Team(
                name: "Team Spirit",
                emblem: "emblem0",
                players: [
                    Player(
                        avatar: "avatar11",
                        name: "Windranger",
                        isCaptain: true,
                        tount: "Время пострелять.",
                        equipment: [.assaultCuirass]
                    ),
                    Player(
                        avatar: "avatar12",
                        name: "Mirana",
                        isCaptain: false,
                        tount: "Луна освещает мне дорогу!",
                        equipment: [.assaultCuirass]
                    ),
                    Player(
                        avatar: "avatar13",
                        name: "Crystar Maiden",
                        isCaptain: false,
                        tount: "А вот и заморозки!",
                        equipment: nil
                    )]),
            Team(
                name: "Team Secret",
                emblem: "emblem3",
                players: [
                    Player(
                        avatar: "avatar13",
                        name: "Crystal Maiden",
                        isCaptain: false,
                        tount: "Превращу в сосульку!",
                        equipment: [.assaultCuirass]
                    ),
                    Player(
                        avatar: "avatar12",
                        name: "Mirana",
                        isCaptain: true,
                        tount: "Крадусь...",
                        equipment: [.nullifier, .powerTreads]
                    ),
                    Player(
                        avatar: "avatar13",
                        name: "Crystal Maiden",
                        isCaptain: false,
                        tount: "А вот и заморозки!",
                        equipment: nil
                    )]
            )]
    }
}

struct Player {
    let avatar: String
    let name: String
    let isCaptain: Bool
    let tount: String
    let equipment: [Equip]?
}

enum Equip: String {
    case assaultCuirass = "Assault cuirass"
    case nullifier = "Nullifier"
    case powerTreads = "Power Treads"
    
    var definition: UIImage {
        switch self {
            
        case .assaultCuirass:
            guard let image = UIImage(named: "assault_cuirass") else { return UIImage(systemName: "nosign")! }
            return image
        case .nullifier:
            guard let image = UIImage(named: "nullifier") else { return UIImage(systemName: "nosign")! }
            return image
        case .powerTreads:
            guard let image = UIImage(named: "power_treads") else { return UIImage(systemName: "nosign")!}
            return image
        }
    }
}
