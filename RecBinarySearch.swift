// Copyright (c) 2022 Mel Aguoth All rights reserved.
//
// Created By: Mel Aguoth
// Date: January 20, 2022
// This program uses binary searching to find the index of an integer in an array.

// Import modules.
import Foundation

func binarySearch(searchArray: [Int], searchInt: Int, left: Int, right: Int) -> Int {

  // Declare constants.
  let tempInt: Int = searchInt
  let tempLeft: Int = left
  let tempRight: Int = right

  // If the user's integer isn't in the list, return -1.
  if left > right {
    return -1
  }

  // Calculate the center of the array.
  let middle: Int = (left + right) / 2

  // If the user's integer is in the middle, return the middle integer.
  if searchArray[middle] == tempInt {
    return middle

  /* If the user's integer is lesser than the middle integer,
     shorten the search area by half to the left. */
  } else if searchInt < searchArray[middle] {
    return binarySearch(searchArray: searchArray, searchInt: tempInt, left: tempLeft, right: middle - 1)

  /* If the user's integer is greater than the middle integer,
     shorten the search area by half to the right. */
  } else {
    return binarySearch(searchArray: searchArray, searchInt: tempInt, left: middle + 1, right: tempRight)
  }
}

// Declare constants.
let arraySize: Int = 250
let max: Int = 999
let min: Int = 0
let numFile = "/home/ubuntu/ICS4U/Unit2/Unit2-03/Unit2-03-Swift/randomIntegers.txt"
let text = ""

// Write the random numbers to a text file.
try text.write(to: URL(fileURLWithPath: "/home/ubuntu/ICS4U/Unit2/Unit2-03/Unit2-03-Swift/"
             + "randomIntegers.txt"), atomically: false, encoding: .utf8)
if let fileWriter = try? FileHandle(forUpdating: URL(fileURLWithPath: "/home/ubuntu/ICS4U/Unit2/"
                                  + "Unit2-03/Unit2-03-Swift/randomIntegers.txt")) {
  for _ in 1...arraySize {
    let randomInt = Int.random(in: min...max)
    let intToString = String(randomInt) + "\n"
    fileWriter.seekToEndOfFile()
    fileWriter.write(intToString.data(using: .utf8)!)
  }
  fileWriter.closeFile()
}

// Read the random numbers from the text file into an array.
let integerString: String = try String(contentsOfFile: numFile)
let integerStringArray: [String] = integerString.components(separatedBy: "\n")
var integerArray: [Int] = integerStringArray.compactMap {Int($0)}

// Sort the array.
integerArray.sort()

// Introduce the program.
print("This program allows you to search for an integer between 0 and 999 in an array of 250"
    + " integers using the binary search method.")

// Display the array to the user.
print("These are the integers in the array: \(integerArray)")

// Get the user's integer.
print("Enter the integer to search for (between 0 and 999):", terminator: " ")
let userString: String = readLine() ?? ""
let userInt: Int = Int(userString) ?? 0

// If the user's input isn't an integer, display an error to the user.
if Int(userString) == nil {
  print("\n" + "'\(userString)' isn't an integer. Please enter a proper integer.")

// If the user's integer isn't between 0 and 999, display an error to the user.
} else if userInt < min || userInt > max {
  print("\n" + "\(userInt) isn't between 0 and 999. Please enter an integer between 0 and 999.")

} else {

  // Call binarySearch.
  let answer: Int = binarySearch(searchArray: integerArray, searchInt: userInt, left: 0,
                                 right: integerArray.count - 1)

  // If the user's integer isn't in the list, display as such to the user.
  if answer == -1 {
    print("\n" + "\(userInt) isn't in the list. Please try again with an integer from the list.")

  // Display the user's integer's index to the user.
  } else {
    print("\n" + "\(userInt) is at index: \(answer)")
  }
}
