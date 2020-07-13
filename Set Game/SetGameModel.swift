//
//  SetGameModel.swift
//  Set Game
//
//  Created by James Byrne on 05/07/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import Foundation

struct SetGameModel {
    private(set) var cards: [Card]
    private(set) var maxNumOfCardsDisplayed = 12
    
    var totalNumOfSets: Int { cards.count / 3 }
    
    private var matchedCardNum: Int { cards.filter({ card in (card.isMatched ?? false) }).count }
    private var unmatchedCardNum: Int { cards.filter({ card in !(card.isMatched ?? false) }).count }
    var numOfMatchedSets: Int { matchedCardNum / 3 }
    
    private var numOfDisplayedCards: Int { min(unmatchedCardNum, maxNumOfCardsDisplayed) }
    var numOfUnseenCards: Int { unmatchedCardNum - numOfDisplayedCards }
    
    var displayedCards: [SetGameModel.Card] {
        return Array(cards.filter{ card in !(card.isMatched ?? false) || card.isSelected }[0..<numOfDisplayedCards])
    }
    
    init() {
        cards = SetGameModel.createCards()
    }
    
    private func isMatchingSet(cardSet: [Card]) -> Bool {
        var numbers = Set<Card.Number>()
        var shapes = Set<Card.Shape>()
        var shadings = Set<Card.Shading>()
        var colors = Set<Card.Color>()
        
        for card in cardSet {
            numbers.insert(card.number)
            shapes.insert(card.shape)
            shadings.insert(card.shading)
            colors.insert(card.color)
        }
        
        if numbers.count == 2 || shapes.count == 2 || shadings.count == 2 || colors.count == 2 {
            return false
        }
        
        return true
    }
    
    mutating func select(card: SetGameModel.Card) {
        let previousSelectedIndices = IndexSet(cards.indices.filter({ cardIndex in cards[cardIndex].isSelected }))
        
        guard let currentSelectedIndex = cards.firstIndex(matching: card) else { return }
        
        var allSelectedIndices = previousSelectedIndices
        allSelectedIndices.insert(currentSelectedIndex)
        
        if allSelectedIndices.count == 3 {
            if previousSelectedIndices.count == 3 {
                previousSelectedIndices.forEach({ cardIndex in
                    cards[cardIndex].isMatched = nil
                    if cardIndex != currentSelectedIndex {
                        cards[cardIndex].isSelected = false
                    }
                })
            } else if isMatchingSet(cardSet: allSelectedIndices.map { cards[$0] }) {
                allSelectedIndices.forEach({ cardIndex in cards[cardIndex].isMatched = true })
                cards[currentSelectedIndex].isSelected = true
            } else {
                allSelectedIndices.forEach({ cardIndex in
                    cards[cardIndex].isMatched = false
                    cards[cardIndex].isSelected = true
                })
            }
        } else if previousSelectedIndices.count == 3 {
            if isMatchingSet(cardSet: previousSelectedIndices.map { cards[$0] }) {
                for cardIndex in previousSelectedIndices {
                    cards[cardIndex].isSelected = false
                    cards[cardIndex].isMatched = true
                }
            } else {
                for cardIndex in previousSelectedIndices {
                    cards[cardIndex].isSelected = false
                    cards[cardIndex].isMatched = nil
                }
            }
            cards[currentSelectedIndex].isSelected = !cards[currentSelectedIndex].isSelected
        } else {
            cards[currentSelectedIndex].isSelected = !cards[currentSelectedIndex].isSelected
        }
    }
    
    mutating func dealMoreCards() {
        maxNumOfCardsDisplayed += min(numOfUnseenCards, 3)
    }
    
    static func createCards() -> Array<Card> {
        var cards = [Card]()
        
        for number in Card.Number.allCases {
            for shape in Card.Shape.allCases {
                for shading in Card.Shading.allCases {
                    for color in Card.Color.allCases {
                        cards.append(Card(id: cards.count, number: number, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        
        cards.shuffle()
        
        return cards
    }
    
    struct Card: Identifiable, Equatable {
        let id: Int
        let number: Number
        let shape: Shape
        let shading: Shading
        let color: Color
        
        var isMatched: Bool?
        var isSelected = false
        
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
}
