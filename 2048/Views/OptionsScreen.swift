//
//  OptionsScreen.swift
//  2048
//
//  Created by Alex Luna on 30/07/2020.
//

import SwiftUI

struct OptionsScreen: View {
    @Binding var username: String

    @Binding var boardSize: Int
    @ObservedObject var game: GameEngine

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("PROFILE")) {
                    TextField("Username", text: $username)
                }

                Section(header: Text("GAME OPTIONS")) {
                    Stepper(value: $boardSize, in: 3...8) {
                        Text("Board size: ")
                        Spacer()
                        Text("\(boardSize) x \(boardSize)")
                    }
                    Button(action: { game.resetGame(boardSize: boardSize) }, label: {
                        Spacer()
                        Text("Start New Game")
                    })
                }

            }
            .navigationBarTitle("Settings")
        }
    }
}

struct OptionsScreen_Previews: PreviewProvider {
    static var previews: some View {
        OptionsScreen(username: .constant("username"), boardSize: .constant(4), game: GameEngine())
    }
}
