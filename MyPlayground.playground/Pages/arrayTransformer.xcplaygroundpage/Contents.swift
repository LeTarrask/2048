import UIKit

let array = [8, 4, 8, 2]

// Tests:
// [2,0,4,0]
// [0,0,0,0]
// [0,4,0,8]
// [8,0,2,2]
// [2,2,2,2]
// [0,2,2,0]
// [2,2,2,8]
// [256,256,2,4]
// [2,0,2,0]
// [4,0,0,0]
// [4,2,8,0]
// [512,2,4,0]
// [8,4,8,2]

var newArray = [Int]()

// Joins all numeric values together
for position in 0...array.count-1 {
    if array[position] != 0 { newArray.append(array[position]) }
}

// Iterates new array to merge values, to the second to last element.
// If duplicates found, doubles the first and eliminates the second
if newArray.count > 2 {
    for position in 0...newArray.count-2 {
        if newArray[position] == newArray[position+1] {
            newArray[position] = newArray[position] * 2
            newArray[position+1] = 0
        }
    }
}

newArray = newArray.filter({ $0 != 0 })

// get the difference between old and new array and add zeroes to the end
let diff = (array.count)-(newArray.count)
for _ in 1...diff {
    newArray.append(0)
}

newArray

// for each original number in the array that is not zero
//  - look backwards for a target position that does not contain a zero (unless it is position zero)
//  -- if the target position does not contain the original number use the next position
//  --- if the target position is different from the original position
//  -- add the number to the number on the target position
//  --- replace the original number by zero
