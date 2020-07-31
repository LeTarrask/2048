//
//  LeaderBoard.swift
//  2048
//
//  Created by Alex Luna on 30/07/2020.
//

import SwiftUI

struct LeaderBoard: View {
    @ObservedObject var game: GameEngine

    // [(String, Int)]

    var body: some View {
        VStack {
            Text("LEADERBOARD")
            List(game.leaderBoard, id: \.self) { record in
                Text(record.playerName)
                Spacer()
                Text("\(record.score) points")
            }
        }
    }
}

struct LeaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameEngine()
        let record = Record(playerName: "Tarrask", score: 123123)
        for _ in 1...20 {
            game.leaderBoard.append(record)
        }
        return LeaderBoard(game: game)
    }
}
