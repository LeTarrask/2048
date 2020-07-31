//
//  Array+IndexesOf.swift
//  2048
//
//  Created by Alex Luna on 31/07/2020.
//

import Foundation

// This extension gets an element and returns the indexes of this element in an array
extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
