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
    
    var displayedCards: [SetGameModel.Card] { setGameModel.displayedCards}
    
    var unseenCardNum: Int { setGameModel.numOfUnseenCards }
    
    var numOfMatchedSets: Int { setGameModel.numOfMatchedSets / 3 }
    
    var totalNumOfSets: Int { setGameModel.totalNumOfSets }
    
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
