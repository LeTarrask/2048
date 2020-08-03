//
//  ContentView.swift
//  2048
//
//  Created by Alex Luna on 29/07/2020.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject var game = GameEngine()

    @State private var offset = CGSize.zero

    @State var showLeader = false

    @State var playerName: String = "Player 1" {
        didSet {
            game.playerName = playerName
        }
    }

    @State var boardSize: Int = 4

    var cornerRadius: CGFloat = 10

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                  gradient: Gradient(colors: [.white, .lightGray]),
                  startPoint: UnitPoint(x: 0.2, y: 0.2),
                  endPoint: .bottomTrailing
                )

                // MARK: - Screen Content
                VStack {
                    // MARK: - Board
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
                    .background(LinearGradient.horizontalLight)
                    .cornerRadius(cornerRadius)
                    .overlay(
                      RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(LinearGradient.diagonalLightBorder, lineWidth: 1)
                    )
                    .padding()
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.offset = gesture.translation
                            }
                            .onEnded { value in
                                if value.translation.width < 0
                                    && value.translation.height > -30
                                    && value.translation.height < 30 {
                                    self.game.move(direction: .left)
                                } else if value.translation.width > 0
                                            && value.translation.height > -30
                                            && value.translation.height < 30 {
                                    self.game.move(direction: .right)
                                } else if value.translation.height < 0
                                            && value.translation.width < 100
                                            && value.translation.width > -100 {
                                    self.game.move(direction: .up)
                                } else if value.translation.height > 0
                                            && value.translation.width < 100
                                            && value.translation.width > -100 {
                                    self.game.move(direction: .down)
                                }
                            }
                    )

                    // MARK: - Player name
                    HStack {
                        Spacer()
                        Text(playerName)
                            .foregroundColor(Color.darkGray)
                    }.padding(.trailing, 25)

                    // MARK: - Control buttons
                    HStack(alignment: .bottom) {
                        Spacer()

                        VStack(alignment: .trailing) {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color.lightGray)
                                    .cornerRadius(cornerRadius)
                                    .frame(width: 80, height: 70)
                                VStack {
                                    Text("SCORE")
                                        .fontWeight(.bold)
                                    Text(String(game.score))
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(Color.darkGray)
                            }
                            NavigationLink(
                                destination: OptionsScreen(username: $playerName, boardSize: $boardSize, game: game),
                                label: { Text("OPTIONS") })
                            .padding(10)
                            .background(Color.lightGray)
                            .cornerRadius(cornerRadius)
                            .foregroundColor(Color.darkGray)
                        }
                        VStack(alignment: .trailing) {
                            ZStack {
                                HStack {
                                    Rectangle()
                                        .foregroundColor(Color.lightGray)
                                        .cornerRadius(cornerRadius)
                                        .frame(width: 80, height: 70)
                                }
                                VStack {
                                    Text("BEST")
                                        .fontWeight(.bold)
                                    Text(String(game.highest))
                                        .foregroundColor(Color.darkGray)
                                        .fontWeight(.bold)
                                }
                            }
                            Button("LEADERBOARD") {
                                self.showLeader.toggle()
                            }
                            .padding(10)
                            .background(Color.lightGray)
                            .cornerRadius(cornerRadius)
                            .foregroundColor(Color.darkGray)
                        }
                    }.padding()
                }
            }
            .sheet(isPresented: $showLeader) { LeaderBoard(game: game) }
            .navigationBarTitle("2048", displayMode: .inline)
            .navigationBarItems(trailing: Button("Reset") { game.resetGame(boardSize: boardSize) })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
