//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by James Byrne on 05/07/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI

typealias SetGame = SetGameModel<SetGameViewModel.Number, SetGameViewModel.Shape, SetGameViewModel.Shading, SetGameViewModel.Color>

class SetGameViewModel: ObservableObject {
    @Published private var setGameModel: SetGame?

//    static func createSetGame() -> SetGame {
//        return SetGame()
//    }

    var cards: [SetGame.Card] { setGameModel?.cards ?? [SetGame.Card]() }

    var displayedCards: [SetGame.Card] { setGameModel?.displayedCards ?? [SetGame.Card]()}

    var unseenCardNum: Int { setGameModel?.numOfUnseenCards ?? 0}

    var numOfMatchedSets: Int { (setGameModel?.numOfMatchedSets ?? 0) }

    var totalNumOfSets: Int { setGameModel?.totalNumOfSets ?? 0}
    
    var score: Int { setGameModel?.score ?? 0 }

    func select(card: SetGame.Card) {
        setGameModel?.select(card: card)
    }

    func dealMoreCards() {
        setGameModel?.dealMoreCards()
    }
    
    func createSetGame() {
        setGameModel = SetGame()
    }
    
    func resetSetGame() {
        setGameModel = nil
        setGameModel = SetGame()
    }
    
    enum Number: Int, CaseIterable {
        case one = 1, two, three
    }
    
    enum Shape: String, CaseIterable {
        case diamond, rectangle, oval
    }
    
    enum Shading: String, CaseIterable {
        case solid, transparent, open
    }
    
    enum Color: String, CaseIterable {
        case red, purple, blue
    }
}
