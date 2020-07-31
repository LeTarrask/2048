//: [Previous](@previous)

import Foundation

struct Board {
    var grid = [[Tile]]()
    var size: Int

    init(size: Int) {
        self.size = size

        // MARK: - Testing board
        for lines in [[8, 2, 2, 8], [2, 2, 2, 8], [256, 256, 2, 4], [2, 2, 2, 4]] {
            var line = [Tile]()
            for value in lines {
                var tile = Tile()
                tile.value = value
                line.append(tile)
            }
            grid.append(line)
        }
    }
}

struct Tile: Hashable {
    var value: Int = 0
}

let board = Board(size: 4)

board.grid

let values = board.grid.flatMap { $0 }.filter { $0.value == 0 }
values

var movesAvailable = false

for line in 0...board.size-1 {
//    print(board.grid[line].map({$0.value}))
    for row in 0...board.size-2 {
        if board.grid[line][row].value == board.grid[line][row+1].value {
                    movesAvailable = true
        }
    }
    for row in 0...board.size-1 {
        if line == board.size-1 {
            break
        }
        if board.grid[line][row].value == board.grid[line+1][row].value {
            movesAvailable = true
        }
    }
}
movesAvailable
