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
    @State var gameOver = false

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
                Color.backgroundGray.edgesIgnoringSafeArea(.all)

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
                    .modifier(IsoRoundedBorder(Color.backgroundGray))
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
                            VStack {
                                Text("SCORE")
                                    .fontWeight(.bold)
                                    .foregroundColor(.darkGray)
                                Text(String(game.score))
                                    .fontWeight(.bold)
                                    .foregroundColor(.darkGray)
                            }
                            .modifier(IsoRoundedBorder(Color.backgroundGray))
                            .padding(.bottom)
                            NavigationLink(
                                destination: OptionsScreen(username: $playerName, boardSize: $boardSize, game: game),
                                label: { Text("Options").foregroundColor(.darkGray) })
                                .modifier(IsoRoundedBorder(Color.backgroundGray))
                        }
                        VStack(alignment: .trailing) {
                            VStack {
                                Text("BEST")
                                    .fontWeight(.bold)
                                    .foregroundColor(.darkGray)
                                Text(String(game.highest))
                                    .foregroundColor(Color.darkGray)
                                    .fontWeight(.bold)
                            }
                            .modifier(IsoRoundedBorder(Color.backgroundGray))
                            .padding(.bottom)

                            Button("Leaderboard") {
                                self.showLeader.toggle()
                            }
                            .modifier(IsoRoundedBorder(Color.backgroundGray))
                        }
                    }.padding()
                }
            }
            .sheet(isPresented: $showLeader) { LeaderBoard(game: game) }
            .alert(isPresented: $gameOver) {
                Alert(title: Text("Game Over"),
                      message: Text("There are no more moves available."),
                      dismissButton: .default(Text("OK"), action: {
                        self.game.resetGame(boardSize: boardSize)
                        if game.state == .won {
                            self.showLeader.toggle()
                        }
                      }))
            }
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
