//
//  SetGame.swift
//  Set Game
//
//  Created by James Byrne on 05/07/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import Foundation

class SetGameModel {
    private(set) var cards: Array<Card>
    private(set) var matchedSets = 0
    
    init() {
        cards = SetGameModel.createCards()
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
        
        return cards
    }
    
    
    struct Card: Identifiable {
        let id: Int
        let number: Number
        let shape: Shape
        let shading: Shading
        let color: Color
        
        var matched = false
        
        enum Number: Int, CaseIterable {
            case one = 1, two, three
        }
        
        enum Shape: CaseIterable {
            case diamond, rectangle, oval
        }
        
        enum Shading: CaseIterable {
            case solid, transparent, open
        }
        
        enum Color: CaseIterable {
            case red, green, blue
        }
    }
}
