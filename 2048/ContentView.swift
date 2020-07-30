//
//  ContentView.swift
//  2048
//
//  Created by Alex Luna on 29/07/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game = GameEngine()
    
    @State private var offset = CGSize.zero
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: Move button
                HStack {
                    Button("Reset") { game.resetGame() }
                        .foregroundColor(.red)
                    Spacer()
                    Text("Score: " + String(game.score))
                        .font(.headline)
                        .foregroundColor(.green)
                }.padding()
                
                
                // MARK: - Board Drawing
                VStack {
                    ForEach(game.board.grid, id: \.self) { line in
                        HStack {
                            ForEach(line, id: \.self) { tile in
                                TileView(tile: tile)
                            }
                        }
                    }
                }
                .padding()
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.offset = gesture.translation
                        }
                        .onEnded { value in
                            if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                                self.game.move(direction: .left)
                            }
                            else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                                self.game.move(direction: .right)
                            }
                            else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
                                self.game.move(direction: .up)
                            }
                            else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                                self.game.move(direction: .down)
                            }
                        }
                )
            }
            .navigationBarTitle("2048", displayMode: .inline)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
