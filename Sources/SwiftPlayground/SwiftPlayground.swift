// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

struct SalesData {
var saleWeights: [Double] = []
var bagCounts: [Double] = []
var totalCharges: [Double] = []
}

@MainActor
var data = SalesData()

let maximumStock = 50.0
let minimumStock = 0.0
let minimumSale = 0.1 
let maximumBags = 5000.0

/** 
Menu choice function prints the menu and all available options, and does a small check to validate menu choice
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
Read integer reads the users inputted number and validates
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
Add kumara stock to the kumara container in kgs
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
Sell kumara, takes kumara away from the
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
Sale cost combines the price of kumara and bags per purchase
*/
func calculateTotal(weight: Double, bags: Double) -> Double {
    let kumaraCost = weight * 3.0
    let bagCost = bags * 0.20
    let total = kumaraCost + bagCost

    return total
}

/**
Update the sold count on kumara
*/
func updateSoldCount(currentSold: Double, amount: Double) -> Double {
    if amount <= 0.0 {
        print("Cant sell \(amount)")
        return currentSold
    }
    return currentSold + amount
}

/** 
View the current stock of kumara in kgs
*/
func stockMessage(stock: Double) -> String {
    return "You have \(stock) Kgs of kumara in the container."
}

/**
Summary for owner - Average weight per sold bag, average amount earned per bag
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

    for i in data.saleWeights.indices {
        totalWeight += data.saleWeights[i]
        totalBags += data.bagCounts[i]
        totalMoney += data.totalCharges[i]
    }

    if totalBags == 0 {
        print("No bags used in sales.")
        return
    }

    let avgWeightPerBag = totalWeight / totalBags
    let avgMoneyPerBag = totalMoney / totalBags

    print("Total weight sold: \(totalWeight) Kg")
    print("Total bags used: \(totalBags)")
    print(String(format: "Total earnings: $%.2f", totalMoney))
    print(String(format:"Average weight per bag: %.2f %@", avgWeightPerBag, "Kg"))
    print(String(format: "Average earnings per bag: $%.2f", avgMoneyPerBag))
}

@MainActor
func saleRecord() {

    if data.saleWeights.isEmpty {
        print("No sales recorded yet.")
        return
    }


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

        var currentStock = 25.0
        var currentSold = 0.0
        var choice: Int

        repeat { 
            repeat {
                print("")
                choice = menuChoice()
            } while !availableOptions.contains(choice)

            switch choice {
            case 1:
                print("==== Add Kumara to current stock ====")
                let amount = readInteger(prompt: "Enter amount of Kumara you are adding to current stock")
                currentStock = addKumara(currentStock: currentStock, amount: amount)

            case 2:
                print("==== Sell Kumara from stock ====")
                let amount = readInteger(prompt: "Enter amount you are trying to buy")
                let bags = readInteger(prompt: "Enter number of bags used")

                guard let newStock = sellKumara(currentStock: currentStock, amount: amount) else {
                    print("Sale failed.")
                    break
                }

                if bags <= 0 || bags > maximumBags {
                    print("Invalid number of bags.")
                    print("Sale failed.")
                    break
                }

                if bags * 5 < amount {
                    print("Not enough bags. Each bag can only hold 5kg.")
                    print("You need at least \(Int(ceil(amount / 5))) bags for \(amount)kg of kumara.")
                    print("Sale failed.")
                    break
                }

                currentStock = newStock
                currentSold = updateSoldCount(currentSold: currentSold, amount: amount)

                let total = calculateTotal(weight: amount, bags: bags)

                data.saleWeights.append(amount)
                data.bagCounts.append(bags)
                data.totalCharges.append(total)

                print("Sale successful!")
                print(String(format: "  Total charge: $%.2f", total))

            case 3:
                print("==== Current Amount of Stock ====")
                print(stockMessage(stock: currentStock))

            case 4:
                print("==== Sales Records ====")
                saleRecord()                
            case 5:
                print("==== Owner Summary ====")
                ownerSummary()
                
            case 6:
                print("==== Quit ====")
            
            default:
                break
                
            } 
        } while choice != 6
    }
}
