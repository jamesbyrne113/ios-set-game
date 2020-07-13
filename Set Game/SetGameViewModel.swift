//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by James Byrne on 05/07/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var setGameModel = SetGameViewModel.createSetGame()
    
    static func createSetGame() -> SetGameModel {
        return SetGameModel()
    }
    
    var cards: [SetGameModel.Card] { setGameModel.cards }
    
    var displayedCards: [SetGameModel.Card] {
        return Array(setGameModel.cards.filter{ card in !(card.isMatched ?? false) || card.isSelected }[0..<setGameModel.numOfDisplayedCards])
    }
    
    var unseenCardNum: Int { setGameModel.numOfUnseenCards }
    
    var numOfMatches: Int { setGameModel.matchedCardNum / 3 }
    
    var totalNumOfSets: Int { setGameModel.cards.count / 3 }
    
    func select(card: SetGameModel.Card) {
        setGameModel.select(card: card)
    }
    
    func dealMoreCards() {
        setGameModel.dealMoreCards()
    }
    
    func resetGame() {
        setGameModel = SetGameViewModel.createSetGame()
    }
}
