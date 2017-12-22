//
//  Card.swift
//  CardProtoRenderer
//
//  Created by Corey Perrigo on 12/20/17.
//  Copyright © 2017 Corey Perrigo. All rights reserved.
//

import Foundation

enum GameResource: String, Codable {
    case Relic = "R"
    case Cultist = "C"
    case Prisoner = "P"
    case Food = "F"
    case Money = "M"
    case Suspicion = "S"
    case Human = "H"
}

struct CardList: Codable {
    let cards: [Card]
}

struct Quest: Codable {
    var name: String
    var progress: Int
    var maxProgress: Int
    var progressHighlight: Bool
}

struct CardOption: Codable {
    var text: String
    var cost: [GameResource]?
    var reward: [GameResource]?
    var effect: String?
    var notes: String?
}

struct Card: Codable {
    var name: String
    var set: String?
    var flavorText: String
    var singleUse: Bool?
    var quest: Quest?
    var options: [CardOption]
}
