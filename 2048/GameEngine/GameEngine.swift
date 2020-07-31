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

    @Published var state: State = .running {
        didSet {
            switch state {
            case .over:
                print("game over")
            case .won:
                let record = (playerName, score)
                leaderBoard.append(record)
                let defaults = UserDefaults.standard
                defaults.set(highest, forKey: "High Score")
                defaults.set(playerName, forKey: "Player Name")
                defaults.set(leaderBoard, forKey: "Leaderboard")
            case .start:
                print("started")
            case .running:
                print("running")
            }
        }
    }

    var playerName: String
    var leaderBoard: [(String, Int)]

    @Published var score: Int = 0 {
        didSet {
            if score > highest {
                highest = score
            }
        }
    }

    @Published var highest: Int = 0

    init() {
        highest = UserDefaults.standard.integer(forKey: "High Score")
        leaderBoard = UserDefaults.standard.object(forKey: "Leaderboard") as? [(String, Int)] ?? [(String, Int)]()
        playerName = UserDefaults.standard.string(forKey: "Player Name") ?? "Player 1"
    }

    var boardSize: Int = 4
    @Published var board: Board = Board(size: 4)

    func resetGame(boardSize: Int) {
        board = Board(size: boardSize)
        self.boardSize = boardSize
        score = 0
    }

    //swiftlint:disable cyclomatic_complexity
    func dropRandomTile(direction: MoveDirection) {
        if state != .over {
            switch direction {
            case .up:
                if let column = findEmptyTile(array: board.grid[boardSize-1]) {
                    board.grid[boardSize-1][column].value = 2
                }
            case .down:
                if let column = findEmptyTile(array: board.grid[0]) {
                    board.grid[0][column].value = 2
                }
            case .left:
                var lastColumn = [Tile]()
                for line in board.grid {
                    lastColumn.append(line.last!)
                }
                if let chosen = findEmptyTile(array: lastColumn) {
                    board.grid[chosen][boardSize-1].value = 2
                }
            case .right:
                var firstColumn = [Tile]()
                for line in board.grid {
                    firstColumn.append(line.first!)
                }
                if let chosen = findEmptyTile(array: firstColumn) {
                    board.grid[chosen][0].value = 2
                }
            }
        }
    }

    // This function gets the array where we should drop a new 2 tile,
    // finds a tile that's empty and returns it's index randomly
    func findEmptyTile(array: [Tile]) -> Int? {
        let available = array.indexes(of: Tile(value: 0))
        return available.randomElement()
    }

    func checkState() {
        // here it checks if all the spaces are occuppied
        let values = board.grid.flatMap { $0 }.filter { $0.value == 0 }

        var movesAvailable = false

        for line in 0...boardSize-1 {
            for row in 0...boardSize-2
                where board.grid[line][row].value == board.grid[line][row+1].value {
                    movesAvailable = true
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
        }

        if board.grid.flatMap { $0 }.filter({ $0.value == 2048 }).count > 1
            && movesAvailable == false {
            state = .won
        }
    }

    enum MoveDirection {
        // swiftlint:disable identifier_name
        case up
        case down
        case left
        case right
    }

    // swiftlint:disable cyclomatic_complexity
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
                let newArray = transformArray(array: board.grid[lineNumber].map { $0.value })
                var newLine = [Tile]()
                for value in newArray {
                    newLine.append(Tile(value: value))
                }
                board.grid[lineNumber] = newLine
            }
        case .right:
            print("right move")
            for lineNumber in 0...boardSize-1 {
                let backwardsArray = board.grid[lineNumber].map { $0.value }
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
        var newArray = [Int]()

        // Joins all numeric values together
        for position in 0...array.count-1 where array[position] != 0 { newArray.append(array[position]) }

        // Iterates new array to merge values, to the second to last element.
        // If duplicates found, doubles the first and eliminates the second
        if newArray.count > 1 {
            for position in 0...newArray.count-2 where newArray[position] == newArray[position+1] {
                    newArray[position] = newArray[position] * 2
                    score += newArray[position]
                    newArray[position+1] = 0
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
