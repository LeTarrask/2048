//
//  GameEngine.swift
//  2048
//
//  Created by Alex Luna on 29/07/2020.
//

import Foundation

class GameEngine: ObservableObject {
    enum State {
        case start
        case won
        case running
        case over
    }
    
    var state: State = .running
        
    @Published var score: Int = 0 {
        didSet {
            if score > highest {
                highest = score
            }
        }
    }
    @Published var highest: Int {
        didSet {
            UserDefaults.standard.set(self.highest, forKey: "High Score")
        }
    }
    
    init() {
        highest = UserDefaults.standard.integer(forKey: "High Score")
    }
    
    var boardSize: Int = 4
    @Published var board: Board = Board(size: 4)
    
    func resetGame() {
        board = Board(size: boardSize)
        score = 0
    }
    
    func dropRandomTile(direction: MoveDirection) {
        if state != .over {
            let random = Int.random(in: 0...boardSize-1)

            switch direction {
            case .up:
                board.grid[boardSize-1][random].value = 2
            case .down:
                board.grid[0][random].value = 2
            case .left:
                board.grid[random][boardSize-1].value = 2
            case .right:
                board.grid[random][0].value = 2
            }
        }
    }
    
    func checkState() {
        let values = board.grid.flatMap { $0 }.filter { $0.value == 0 } // here it checks if all the spaces are occuppied
        
        var movesAvailable = false
        
        for line in 0...boardSize-1 {
            for row in 0...boardSize-2 {
                if board.grid[line][row].value == board.grid[line][row+1].value {
                    movesAvailable = true
                }
            }
            for row in 0...boardSize-1 {
                if line == boardSize-1 {
                    break
                }
                if board.grid[line][row].value == board.grid[line+1][row].value {
                    movesAvailable = true
                }
            }
        }
        
        if values.count == 0 && movesAvailable == false {
            state = .over
            print("Game Over")
        }
        
        if board.grid.flatMap { $0 }.filter({ $0.value == 2048 }).count > 1 {
            state = .won
            print("Game Won")
        }
    }
    
    enum MoveDirection {
        case up
        case down
        case left
        case right
    }
    
    func move(direction: MoveDirection) {
        switch direction {
        case .down:
            print("down move")
            for row in 0...boardSize-1 {
                var values = [Int]()
                for line in 0...boardSize-1 {
                    values.append(board.grid[line][row].value)
                }
                var newArray = transformArray(array: values.reversed())
                newArray.reverse()
                for line in 0...boardSize-1 {
                    board.grid[line][row].value = newArray[line]
                }
            }
        case .up:
            print("up move")
            for row in 0...boardSize-1 {
                var values = [Int]()
                for line in 0...boardSize-1 {
                    values.append(board.grid[line][row].value)
                }
                let newArray = transformArray(array: values)
                for line in 0...boardSize-1 {
                    board.grid[line][row].value = newArray[line]
                }
            }
        case .left:
            print("left move")
            for lineNumber in 0...boardSize-1 {
                let newArray = transformArray(array: board.grid[lineNumber].map{ $0.value } )
                var newLine = [Tile]()
                for value in newArray {
                    newLine.append(Tile(value: value))
                }
                board.grid[lineNumber] = newLine
            }
        case .right:
            print("right move")
            for lineNumber in 0...boardSize-1 {
                let backwardsArray = board.grid[lineNumber].map{ $0.value }
                let newArray = transformArray(array: backwardsArray.reversed() )
                var newLine = [Tile]()
                for value in newArray {
                    newLine.append(Tile(value: value))
                }
                board.grid[lineNumber] = newLine.reversed()
            }
        }
        checkState()
        dropRandomTile(direction: direction)
    }
    
    func transformArray(array: [Int]) -> [Int] {
        // Tests:
        // [2,0,4,0]
        // [0,4,0,8]
        // [8,0,2,2]
        // [2,2,2,2]
        // [0,2,2,0]
        // [2,2,2,8]
        // [256,256,2,4]
        // [2,0,2,0]

        var newArray = [Int]()

        // Joins all numeric values together
        for position in 0...array.count-1 {
            if array[position] != 0 { newArray.append(array[position]) }
        }

        // Iterates new array to merge values, to the second to last element. If duplicates found, doubles the first and eliminates the second
        if newArray.count > 1 {
            for position in 0...newArray.count-2 {
                if newArray[position] == newArray[position+1] {
                    newArray[position] = newArray[position] * 2
                    score += newArray[position]
                    newArray[position+1] = 0
                }
            }
        }

        newArray = newArray.filter({ $0 != 0 })

        // get the difference between old and new array and add zeroes to the end
        if newArray != array {
            let diff = (array.count)-(newArray.count)
            for _ in 1...diff {
                newArray.append(0)
            }
        }

        return newArray
    }
}

