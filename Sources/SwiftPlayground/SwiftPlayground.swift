// The Swift Programming Language
// https://docs.swift.org/swift-book

func menuChoice() -> Int {
    while true {
        print("""
        ==== Egg Shop ====
        1. Add eggs
        2. Sell eggs
        3. Show current stock
        4. Show total eggs sold
        5. Exit
        Choose an option:
        """)

        print("Enter menu option")
            if let input = readLine(),
            let number = Int(input),
            (1...5).contains(number) {
                return number
            }
            print("Invalid menu option. Try again.")
    }
}


func readInteger(prompt: String) -> Int {
    print(prompt)
    var returnValue = -1
    guard let userInput = readLine(), let number = Int(userInput), number > 0 else {
        print("Invalid number.")
        return readInteger(prompt: prompt)
    }
    returnValue = number
    return returnValue
}

// addEggs takes the current stock of eggs in the shop, adds an amount to it and returns the new current stock amount
func addEggs(currentStock: Int, amount: Int) -> Int {
    if amount <= 0 {
        print("Cant add \(amount)")
        return currentStock
    }

    if currentStock + amount >= 1000 {
        print("Too many eggs, not enough storage")
        return currentStock
    }

    return currentStock + amount 
}
// sellEggs takes the current tock of eggs in the shop, takes an amount from it
// and returns the new stock amount
func sellEggs(currentStock: Int, amount: Int) -> Int? {
    if amount <= 0 {
        print("Can't sell \(amount)")
        return nil  
    }

    if amount > currentStock {
        print("Cant sell more than \(currentStock) eggs")
        return nil
    }
    return currentStock - amount
}
// updateSoldCount takes the current number of eggs sold, adds an amount to it
// and returns the new amount of sold eggs
func updateSoldCount(currentSold: Int, amount: Int) -> Int {
    if amount <= 0 {
        print("Cant add \(amount)")
        return currentSold
    }
    return currentSold + amount
}
// stockMessage takes the amount of stock, converts it to a string
// and returns the stock
func stockMessage(stock: Int) -> String {
    return "You have \(stock) eggs in stock."
}



@main
struct SwiftPlayground {
    static func main() {
        let availableOptions = 1...5

        var currentStock = 100
        var currentSold = 0
        var choice: Int

        repeat { 
            repeat {
                print("")
                choice = menuChoice()
            } while !availableOptions.contains(choice)

            switch choice{
            case 1:
                print("==== Add Eggs to current stock ====")
                let amount = readInteger(prompt: "Enter amount of eggs you are adding to current stock")
                currentStock = addEggs(currentStock: currentStock, amount: amount)

            case 2:            
                print("==== Sell Eggs from stock ====")
                let amount = readInteger(prompt: "Enter amount you are trying to sell")

                if let newStock = sellEggs(currentStock: currentStock, amount: amount) {
                    currentStock = newStock
                    currentSold = updateSoldCount(currentSold: currentSold, amount: amount)
                    print("Sale successful!")
                } else {
                    print("Sale failed.")
                }
            case 3:
                print("==== Current Amount of Stock ====")
                print(stockMessage(stock: currentStock))

            case 4:
                print("==== Number of Sold Eggs ====")
                print("Total eggs sold: \(currentSold)")
                
            case 5:
                print("==== Quit ====")
            

            default:
                break
                
            } 
        } while choice != 5
    }
}