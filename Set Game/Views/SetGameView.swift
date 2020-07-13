//
//  SetGameView.swift
//  Set Game
//
//  Created by James Byrne on 05/07/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGameViewModel: SetGameViewModel
    
    var body: some View {
        VStack{
            Text("\(setGameViewModel.numOfMatchedSets) / \(setGameViewModel.totalNumOfSets) matches")
            .font(Font.title)
            
            Grid(setGameViewModel.displayedCards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.2)) {
                        self.setGameViewModel.select(card: card)
                    }
                }
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                        withAnimation(.linear(duration: 0.2)) {
                            self.setGameViewModel.dealMoreCards()
                        }
                    }, label: { Text("Deal More Cards") }
                )
                    .disabled(setGameViewModel.unseenCardNum <= 0)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.75)) {
                        self.setGameViewModel.resetGame()
                    }
                }, label: { Text("New Game")})
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let setGameViewModel = SetGameViewModel()
        setGameViewModel.select(card: setGameViewModel.cards[0])
        return SetGameView(setGameViewModel: setGameViewModel)
    }
}
