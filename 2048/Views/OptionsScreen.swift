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
                Section(header: Text(NSLocalizedString("PROFILE", comment: ""))) {
                    TextField(NSLocalizedString("Username", comment: ""), text: $username)
                }

                Section(header: Text(NSLocalizedString("GAMEOPTIONS", comment: ""))) {
                    Stepper(value: $boardSize, in: 3...8) {
                        Text(NSLocalizedString("Boardsize", comment: ""))
                        Spacer()
                        Text("\(boardSize) x \(boardSize)")
                    }
                    Button(action: { game.state = .start }, label: {
                        Text(NSLocalizedString("StartNewGame", comment: ""))
                    })
                }

            }
            .navigationBarTitle(NSLocalizedString("Settings", comment: ""))
        }
    }
}

struct OptionsScreen_Previews: PreviewProvider {
    static var previews: some View {
        OptionsScreen(username: .constant("username"), boardSize: .constant(4), game: GameEngine())
    }
}
