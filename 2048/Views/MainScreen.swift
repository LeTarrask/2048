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

    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Control buttons
                HStack {
                    Spacer()
                    VStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.blue)
                                .cornerRadius(15)
                                .frame(width: 100, height: 100)
                            VStack {
                                Text("SCORE")
                                    .fontWeight(.bold)
                                Text(String(game.score))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        NavigationLink(
                            destination: OptionsScreen(username: $playerName, boardSize: $boardSize, game: game),
                            label: { Text("OPTIONS")})
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    }
                    VStack {
                        ZStack {
                            HStack {
                                Rectangle()
                                    .foregroundColor(.blue)
                                    .cornerRadius(15)
                                    .frame(width: 100, height: 100)
                            }
                            VStack {
                                Text("BEST")
                                    .fontWeight(.bold)
                                Text(String(game.highest))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }
                        Button("LEADERBOARD") {
                            self.showLeader.toggle()
                        }
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    }
                }.padding()

                HStack {
                    Spacer()
                    Text(playerName)
                }.padding(.trailing)

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
                .background(Color.gray)
                .cornerRadius(15)
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
            }
            .sheet(isPresented: $showLeader) { LeaderBoard() }
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
