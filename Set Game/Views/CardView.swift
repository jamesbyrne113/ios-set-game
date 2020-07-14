//
//  CardView.swift
//  Set Game
//
//  Created by James Byrne on 07/07/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.cardContents(for: geometry.size)
        }
            .padding(5)
    }
    
    private func cardContents(for size: CGSize) -> some View {
        let width = size.width * shapeWidthRatio
        let height = size.height * shapeHeightRatio

        let shape = createShape()

        return ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(cardFillColor)
                .opacity(0.5)
            RoundedRectangle(cornerRadius: 5)
                .stroke(cardStrokeColor)

            VStack(spacing: self.shapeSpacing(for: size.height)) {
                ForEach(1...self.card.number.rawValue, id: \.self) { index in
                    shape
                    .frame(width: width, height: height)
                }
            }
        }
    }
    
    private var cardStrokeColor: Color {
        if !card.isSelected && card.isMatched == nil {
            return Color.black
        }
        
        if let isMatched = card.isMatched {
            if isMatched {
                return Color.green
            } else {
                return Color.gray
            }
        } else {
            return Color.yellow
        }
    }
    
    private var cardFillColor: Color {
        if !card.isSelected {
            return Color.clear
        }
        
        if let isMatched = card.isMatched {
            if isMatched {
                return Color.green
            } else {
                return Color.gray
            }
        } else {
            return Color.yellow
        }
    }
    
    private func createShape() -> some View {
        var shape: AnyShape

        switch(card.shape) {
        case .rectangle:
            shape =  AnyShape(Rectangle())
        case .oval:
            shape = AnyShape(Ellipse())
        case .diamond:
            shape = AnyShape(Diamond())
        }

        return ZStack {
            shape
                .fill(Color.white)
            shape
                .fill(shapeColor)
                .opacity(shapeOpacity)
            shape
                .stroke(shapeColor)
                .opacity(card.shading == .open ? 1 : shapeOpacity)
        }
    }

    private var shapeColor: Color {
        switch(card.color) {
        case .red:
            return Color.red
        case .blue:
            return Color.blue
        case .purple:
            return Color.purple
        }
    }

    private var shapeOpacity: Double {
        switch(card.shading) {
        case .open:
            return 0.0
        case .transparent:
            return 0.4
        case .solid:
            return 1.0
        }
    }

    // MARK: - Constants
    func shapeSpacing(for cardHeight: CGFloat) -> CGFloat { return cardHeight / 10 }
    let shapeWidthRatio: CGFloat = 0.75
    let shapeHeightRatio: CGFloat = 0.2
}

struct CardSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let setGameViewModel = SetGameViewModel()
        return SetGameView(setGameViewModel: setGameViewModel)
    }
}
