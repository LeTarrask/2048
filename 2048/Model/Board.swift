//
//  Board.swift
//  2048
//
//  Created by Alex Luna on 29/07/2020.
//

import Foundation

struct Board {
    var grid = [[Tile]]()
    var size: Int
    
    init(size: Int) {
        self.size = size
//        var line = [Tile]()
//
//        for x in 1...size {
//            var tile = Tile()
//            tile.value = Int(pow(Double(x+1), 2.0))
//            line.append(tile)
//        }
//
//        for _ in 1...size { grid.append(line) }
        
        // MARK: - Testing board
        for lines in [[0,2,2,0], [2,2,2,8], [256,256,2,4], [2,0,2,0]] {
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
