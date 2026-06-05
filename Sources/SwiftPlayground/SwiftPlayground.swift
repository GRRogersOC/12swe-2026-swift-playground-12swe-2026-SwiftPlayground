// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation


// Stores all information about completed sales
struct SalesData {
var saleWeights: [Double] = []
var bagCounts: [Double] = []
var totalCharges: [Double] = []
}

@MainActor
var data = SalesData()

// Program constraints and validation limits
let maximumStock = 50.0
let minimumStock = 0.0
let minimumSale = 0.1 
let maximumBags = 5000.0

/** 
 Displays the Kumara Stand menu and validates the user's menu selection.

 Parameters:
 None

 Returns:
 An integer between 1 and 6 representing the selected menu option.
*/
func menuChoice() -> Int {
    let menu: [[String]] = [
        ["== Kumara Stand "], 
        ["== $3 per Kg"],
        ["20 cents per bag"], 
        ["5 kg of Kumara per bag"],
        ["== 1. Add Kumara "],
        ["== 2. Sell Kumara "],
        ["== 3. View current stock "],
        ["== 4. Sale Records "],
        ["== 5. Owner Summary "],
        ["== 6. Quit "]
    ]

    while true {
        
    for row in menu {
        print(row.joined(separator: " "))
    }

        print("Enter menu option")
            if let input = readLine(),
            let number = Int(input),
            (1...6).contains(number) {
                return number
            }
            print("Invalid menu option. Try again.")
    }
}

/**
 Prompts the user for a positive number and validates the input.

 Parameters:
 - prompt: The message displayed to the user.

 Returns:
 A valid positive Double entered by the user.
*/
func readInteger(prompt: String) -> Double {
    print(prompt)
    var returnValue = -1.0
    guard let userInput = readLine(), let number = Double(userInput), number > 0.0 else {
        print("Invalid number.")
        return readInteger(prompt: prompt)
    }
    returnValue = number
    return returnValue
}

/**
 Adds kumara to the current stock if the amount is valid and there is enough storage space.

 Parameters:
 - currentStock: The current amount of kumara in stock.
 - amount: The amount of kumara being added.

 Returns:
 The updated stock level if successful, otherwise the original stock level.
 */
func addKumara(currentStock: Double, amount: Double) -> Double {

    if amount <= 0.0 {
        print("Cant add \(amount) Kgs")
        return currentStock
    }

    if currentStock + amount > maximumStock {
        print("Too much Kumara, not enough space")
        return currentStock
    }

    return currentStock + amount 
}



/**
 Removes kumara from stock when a sale is made.

 Parameters:
 - currentStock: The current amount of kumara in stock.
 - amount: The amount of kumara being sold.

 Returns:
 The new stock level if the sale is valid, otherwise nil.
 */
func sellKumara(currentStock: Double, amount: Double) -> Double? {
    if amount < minimumSale {
        print("Can't sell \(amount)")
        return nil  
    }

    if amount > currentStock {
        print("Cant sell more than \(currentStock) Kgs of kumara")
        return nil
    }
    return currentStock - amount
}

/**
 Calculates the total cost of a sale.

 Parameters:
 - weight: Amount of kumara sold in kilograms.
 - bags: Number of bags used.

 Returns:
 The total sale cost including kumara and bag charges.
 */
func calculateTotal(weight: Double, bags: Double) -> Double {
    let kumaraCost = weight * 3.0
    let bagCost = bags * 0.20
    let total = kumaraCost + bagCost

    return total
}

/**
 Updates the total amount of kumara sold.

 Parameters:
 - currentSold: Current total kilograms sold.
 - amount: Amount sold in the current transaction.

 Returns:
 Updated total kilograms sold.
 */
func updateSoldCount(currentSold: Double, amount: Double) -> Double {
    if amount <= 0.0 {
        print("Cant sell \(amount)")
        return currentSold
    }
    return currentSold + amount
}

/**
 Creates a stock message for the user.

 Parameters:
 - stock: Current stock level.

 Returns:
 A formatted string showing the amount of stock available.
 */
func stockMessage(stock: Double) -> String {
    return "You have \(stock) Kgs of kumara in the container."
}

/**
 Displays a summary for the owner including:
 - Total weight sold
 - Total bags used
 - Total earnings
 - Average weight per bag
 - Average earnings per bag

 Parameters:
 None

 Returns:
 Nothing (prints summary information).
 */
@MainActor
func ownerSummary() {

    var totalWeight = 0.0
    var totalBags = 0.0
    var totalMoney = 0.0

    if data.saleWeights.isEmpty {
        print("No sales recorded yet.")
        return
    }

    // Calculate totals from all recorded sales
    for i in data.saleWeights.indices {
        totalWeight += data.saleWeights[i]
        totalBags += data.bagCounts[i]
        totalMoney += data.totalCharges[i]
    }

    if totalBags == 0 {
        print("No bags used in sales.")
        return
    }

    // Calculate averages for owner reporting
    let avgWeightPerBag = totalWeight / totalBags
    let avgMoneyPerBag = totalMoney / totalBags

    print("Total weight sold: \(totalWeight) Kg")
    print("Total bags used: \(totalBags)")
    print(String(format: "Total earnings: $%.2f", totalMoney))
    print(String(format:"Average weight per bag: %.2f %@", avgWeightPerBag, "Kg"))
    print(String(format: "Average earnings per bag: $%.2f", avgMoneyPerBag))
}

/**
 Displays every sale that has been recorded.

 Parameters:
 None

 Returns:
 Nothing (prints sale records).
 */
@MainActor
func saleRecord() {

    if data.saleWeights.isEmpty {
        print("No sales recorded yet.")
        return
    }

    // Loop through each recorded sale and display details
    for i in data.saleWeights.indices {
        let weight = data.saleWeights[i]
        let bags = data.bagCounts[i]
        let total = data.totalCharges[i]

        print("Sale \(i + 1):")
        print("  Weight: \(weight) kg")
        print("  Bags: \(bags)")
        print(String(format: "  Total: $%.2f", total))
        print("----------------------")
    }
}


@main
struct SwiftPlayground {
    @MainActor
    static func main() {
let availableOptions = 1...6

        // Starting stock available for sale
        var currentStock = 25.0

        // Running total of kumara sold
        var currentSold = 0.0
        
        var choice: Int

        // Continue displaying menu until a valid option is entered
        repeat { 
            repeat {
                print("")
                choice = menuChoice()
            } while !availableOptions.contains(choice)

            switch choice {
            case 1:
                print("==== Add Kumara to current stock ====")

                // Get amount of kumara to add to stock
                let amount = readInteger(prompt: "Enter amount of Kumara you are adding to current stock")
                
                // Update stock level
                currentStock = addKumara(currentStock: currentStock, amount: amount)

            case 2:
                print("==== Sell Kumara from stock ====")

                // Get sale information from user
                let amount = readInteger(prompt: "Enter amount you are trying to buy")
                let bags = readInteger(prompt: "Enter number of bags used")

                // Validate sale and calculate new stock level
                guard let newStock = sellKumara(currentStock: currentStock, amount: amount) else {
                    print("Sale failed.")
                    break
                }

                // Check bag amount is within allowed range
                if bags <= 0 || bags > maximumBags {
                    print("Invalid number of bags.")
                    print("Sale failed.")
                    break
                }

                // Ensure there are enough bags to carry the kumara
                if bags * 5 < amount {
                    print("Not enough bags. Each bag can only hold 5kg.")
                    print("You need at least \(Int(ceil(amount / 5))) bags for \(amount)kg of kumara.")
                    print("Sale failed.")
                    break
                }

                // Update stock and total kilograms sold
                currentStock = newStock
                currentSold = updateSoldCount(currentSold: currentSold, amount: amount)

                // Calculate customer charge
                let total = calculateTotal(weight: amount, bags: bags)

                // Store sale information for reports and summaries
                data.saleWeights.append(amount)
                data.bagCounts.append(bags)
                data.totalCharges.append(total)

                print("Sale successful!")
                print(String(format: "  Total charge: $%.2f", total))

            case 3:
                print("==== Current Amount of Stock ====")

                // Display current stock level
                print(stockMessage(stock: currentStock))

            case 4:
                print("==== Sales Records ====")

                // Display all recorded sales
                saleRecord()                
            case 5:
                print("==== Owner Summary ====")

                // Display owner statistics and averages
                ownerSummary()
                
            case 6:
                print("==== Quit ====")
            
            default:
                break
                
            } 
        } while choice != 6
    }
}
