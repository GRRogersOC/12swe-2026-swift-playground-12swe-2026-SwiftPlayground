// The Swift Programming Language
// https://docs.swift.org/swift-book

func print(board: [[String]]){
    board.forEach { line in
    print("\(line[0]) | \(line[1]) | \(line[2])")
    print("--+---+--")
    
    }
    print()
    
}

func askForPosition(board: [[String]]) -> [Int] {
    while true{ }
    print("Please enter column number 1-3: ")
    let userInput = readLine()!
    let rowNumber = Int(userInput)! - 1
}


@main
struct SwiftPlayground {
    static func main() {




              
//         var board = [
//             [".", ".", "."],
//             [".", ".", "."], // row 1
//             [".", ".", "."]  // row 2
//         ]
//         print(board: board)
        
//         //first move, O in middle
//         board[1][1] = "O"
//         print(board: board)

//         // second move, X top left
//         board[0][0] = "X"
//         print(board: board)

//         //third move, O top roght
//         board[0][2] = "O"
//         print(board: board)

//         //forth move, 
//         board[2][0] = "X"
//         print(board: board)

//         //fifth move, O
//         board[1][0] = "O"
//         print(board: board)

//         //sixth move
//         board[1][2] = "X"
//         print(board: board)

//         //seventh move
//         board[2][1] = "O"
//         print(board: board)

//         //eighth move
//         board[2][2] = "X"
//         print(board: board)

//         //ninth move
//         board[0][1] = "O"
//         print(board: board)
    }

}