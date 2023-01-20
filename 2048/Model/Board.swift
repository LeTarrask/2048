//
//  Board.swift
//  2048
//
//  Created by Alex Luna on 29/07/2020.
//

import Foundation

struct Board: Equatable {
    var grid = [[Tile]]()
    var size: Int

    init(size: Int) {
        self.size = size
        var line = [Tile]()

        for _ in 1...size {
            let tile = Tile()
            line.append(tile)
        }

        for _ in 1...size { grid.append(line) }

        grid[Int.random(in: 0..<size)][Int.random(in: 0..<size)].value = 2
    }
}
