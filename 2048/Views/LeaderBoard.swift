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
            List {
                ForEach(game.leaderBoard, id: \.self) {                     BoardItem(record: $0)
                }
                .onDelete(perform: deleteRecord)
            }
        }
    }

    func deleteRecord(at offsets: IndexSet) {
        game.leaderBoard.remove(atOffsets: offsets)
    }
}

struct BoardItem: View {
    var record: Record

    var body: some View {
        HStack {
            Text(record.playerName)
            Spacer()
            Text("\(record.score)")
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
