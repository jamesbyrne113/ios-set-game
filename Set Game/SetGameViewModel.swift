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
    @Published private var setGameModel = SetGameViewModel.createSetGame()
    
    static func createSetGame() -> SetGame {
        return SetGame()
    }
    
    var cards: [SetGame.Card] { setGameModel.cards }
    
    var displayedCards: [SetGame.Card] { setGameModel.displayedCards}
    
    var unseenCardNum: Int { setGameModel.numOfUnseenCards }
    
    var numOfMatchedSets: Int { setGameModel.numOfMatchedSets / 3 }
    
    var totalNumOfSets: Int { setGameModel.totalNumOfSets }
    
    func select(card: SetGame.Card) {
        setGameModel.select(card: card)
    }
    
    func dealMoreCards() {
        setGameModel.dealMoreCards()
    }
    
    func resetGame() {
        setGameModel = SetGameViewModel.createSetGame()
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
