import Foundation
@main
struct SwiftPlayground {
    static func main() throws {
        // The size of the board (width and height).
        let size = 6
        
        // The board you are playing on.
        var ocean = Array(repeating: Array(repeating: "~", count: size), count: size)
        
        // A record of the guesses that have been made.
        let guesses = Array(repeating: Array(repeating: "~", count: size), count: size)
        
        // Manually place the ships (testing version).
        ocean[1][3] = "S"
        ocean[2][3] = "S"
        ocean[4][0] = "S"
        ocean[5][4] = "S"
        
        printBoard(guesses)
    }
}
/// Parameter:
/// - board: The 2D grid to display.
func printBoard(_ board: [[String]]) {
    var columnLabels = "  "
    for i in 1...board.count {
        columnLabels = columnLabels + "\(i) "
    }
    print(columnLabels)
    
    for (index, row) in board.enumerated() {
        var rowString = "\(index + 1) "
        for cell in row {
            rowString = rowString + cell + " "
        }
        print(rowString)
    }
}
/// Parameters:
/// - row: The row index for the guess.
/// - col: The column index for the guess.
/// - ocean: The hidden ships grid.
/// - guesses: The player's current guesses grid.
///
/// Returns: The updated guesses grid after the guess is applied.
func processGuess(row: Int, col: Int, ocean: [[String]], guesses: [[String]]) -> [[String]] {
    // Make sure the row and column exist. If not, exit this function early.
    guard row >= 1, row <= ocean.count, col >= 1, col <= ocean[0].count else {
        print("Your guess is invalid. Try again.")
        return guesses
    }
    
    // Make sure that the user hasn't already guessed the position.
    // If not, exit this function early.
    guard guesses[row - 1][col - 1] == "O" || guesses[row - 1][col - 1] == "X" else {
        print("You have already guessed that position. Try again.")
        return guesses
    }
    
    // Make sure that the user hasn't missed the battleship.
    // If not, return an updated guesses table including the miss.
    guard guesses[row - 1][col - 1] != "~" else {
        print("MISS!")
        var newGuesses = guesses
        newGuesses[row - 1][col - 1] = "O"
        return newGuesses
    }
    
    // If the code hasn't returned by now, the player must have hit a ship.
    print("You've sunk my battleship!")
    var newGuesses = guesses
    newGuesses[row - 1][col - 1] = "X"
    return newGuesses
}
/// Parameters:
/// - ocean: The hidden ships grid.
/// - guesses: The player's current guesses grid.
///
/// Returns: How many ships remain unhit.
func remainingShips(in ocean: [[String]], guesses: [[String]]) -> Int {
    var shipsCount = 0
    for row in 0...ocean.count-1 {
        for col in 0...row {
            if ocean[row][col] == "S" {
                shipsCount = shipsCount + 1
            }
        }
    }
    
    var hitCount = 0
    for row in 0...guesses.count-1 {
        for col in 0...row {
            if guesses[row][col] == "X" {
                hitCount = hitCount + 1
            }
        }
    }
    
    return shipsCount - hitCount
}

