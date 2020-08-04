//
//  ContentView.swift
//  2048
//
//  Created by Alex Luna on 29/07/2020.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject var game = GameEngine()
    
    @State var splashActive: Bool = false

    @State private var offset = CGSize.zero
    @State var showLeader = false
    @State var gameOver = false

    @State var playerName: String = NSLocalizedString("Player 1", comment: "") {
        didSet {
            game.playerName = playerName
        }
    }

    @State var boardSize: Int = 4

    var cornerRadius: CGFloat = 10

    var body: some View {
        Group {
            if splashActive {
                LoadingScreen()
            } else {
                NavigationView {
                    ZStack {
                        Color.backgroundGray.edgesIgnoringSafeArea(.all)

                        // MARK: - Screen Content
                        VStack {
                            
                            // MARK: - SCORE
                            HStack {
                                Spacer()
                                
                                VStack {
                                    Text(NSLocalizedString("SCORE", comment: ""))
                                        .fontWeight(.bold)
                                        .foregroundColor(.darkGray)
                                    Text(String(game.score))
                                        .fontWeight(.bold)
                                        .foregroundColor(.darkGray)
                                }
                                .modifier(IsoRoundedBorder(Color.backgroundGray))
                                
                                VStack {
                                    Text(NSLocalizedString("BEST", comment: ""))
                                        .fontWeight(.bold)
                                        .foregroundColor(.darkGray)
                                    Text(String(game.highest))
                                        .foregroundColor(Color.darkGray)
                                        .fontWeight(.bold)
                                }
                                .modifier(IsoRoundedBorder(Color.backgroundGray))
                                
                            }.padding()
                            
                            // MARK: - Player name
                            HStack {
                                Spacer()
                                Text(playerName)
                                    .foregroundColor(Color.darkGray)
                            }.padding(.trailing, 25)
                            
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
                                            && value.translation.height > -100
                                            && value.translation.height < 100 {
                                            self.game.move(direction: .left)
                                        } else if value.translation.width > 0
                                                    && value.translation.height > -100
                                                    && value.translation.height < 100 {
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

                            // MARK: - Control buttons
                            HStack(alignment: .bottom) {
                                NavigationLink(
                                    destination: OptionsScreen(username: $playerName,
                                                               boardSize: $boardSize,
                                                               game: game),
                                    label: { Text(NSLocalizedString("Options",
                                                                    comment: "")).foregroundColor(.darkGray) })
                                    .modifier(IsoRoundedBorder(Color.backgroundGray))
                                
                                Button(NSLocalizedString("Leaderboard", comment: "")) {
                                    self.showLeader.toggle()
                                }
                                .modifier(IsoRoundedBorder(Color.backgroundGray))
                            }.padding()
                        }
                    }
                    .sheet(isPresented: $showLeader) { LeaderBoard(game: game) }
                    .alert(isPresented: $gameOver) {
                        Alert(title: Text(NSLocalizedString("GameOver", comment: "")),
                              message: Text(NSLocalizedString("NoMovesAvailable.", comment: "")),
                              dismissButton: .default(Text(NSLocalizedString("OK", comment: "")), action: {
                                if game.state == .won {
                                    self.showLeader.toggle()
                                }
                                self.game.state = .start
                              }))
                    }
                    .onReceive(game.$state) { state in
                        if [.won, .over].contains(state) {
                            self.gameOver = true
                        }
                    }
                    .navigationBarTitle(NSLocalizedString("2048", comment: ""), displayMode: .inline)
                    .navigationBarItems(trailing:
                                            Button(NSLocalizedString("Reset", comment: "")) { game.state = .start })
                }
            }
        }
        .animation(Animation.easeInOut(duration: 1.0))
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                // 7.
                withAnimation {
                    self.splashActive = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
