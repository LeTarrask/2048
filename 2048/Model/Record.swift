//
//  Record.swift
//  2048
//
//  Created by Alex Luna on 31/07/2020.
//

import Foundation

struct Record: Hashable, Codable {
    var playerName: String
    var score: Int
}
