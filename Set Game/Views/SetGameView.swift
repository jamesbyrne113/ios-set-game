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
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        VStack {
            HStack {
                Spacer()
                
                Text("Matches: \(setGameViewModel.numOfMatchedSets) / \(setGameViewModel.totalNumOfSets)")
                
                Spacer()
                
                Text("Score: \(setGameViewModel.score)")
                
                Spacer()
            }
                .font(Font.title)
            
            Grid(self.setGameViewModel.displayedCards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.2)) {
                        self.setGameViewModel.select(card: card)
                    }
                }
            }
                
            .onAppear(perform: {
                withAnimation(.easeInOut(duration: 1.2)) {
                    self.setGameViewModel.createSetGame()
                }
            })
            
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
                        self.setGameViewModel.resetSetGame()
                    }
                }, label: { Text("New Game")})
                
                Spacer()
            }
            
            Spacer()
        }
    }
    
    private func generateOffsetPoint(for size: CGSize) -> CGSize {
        let radius = 1.5 * sqrt(pow(size.width, 2) + pow(size.height, 2))
        let centerX = size.width/2
        let centerY = size.height/2
        
        let randomAngle = CGFloat(Double.random(in: 0..<360))
        let x = centerX + radius * cos(randomAngle * CGFloat(Double.pi) / 180)
        let y = centerY + radius * sin(randomAngle * CGFloat(Double.pi) / 180)
        
        return CGSize(width: x, height: y)
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let setGameViewModel = SetGameViewModel()
        return SetGameView(setGameViewModel: setGameViewModel)
    }
}
