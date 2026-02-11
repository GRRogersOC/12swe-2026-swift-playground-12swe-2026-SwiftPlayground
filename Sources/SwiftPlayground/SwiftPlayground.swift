// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct SwiftPlayground {

    /**
    getUserInput checks if users inputted measurements are a positive number.
    - If the users input is less than or equal to 0, it will request input again and specify a positive number.
    - If the users input is not in a number format, it will request input again and specify a number.
    */
    static func getUserInput(question: String, successMessage: String) -> Double {
        
        var value: Double? = nil

        repeat{
            print(question)
            // Checks if input is valid and it's a number
            if let input = readLine(), let number = Double(input){  
                // This is checking it's a positive number
                if number <= 0 {
                    print("Invalid measurement, please input a positive")
                    
                } else {
                    value = number
                }
            
            } else {
                print("Invalid measurement, please input a number")
                
            }

        } while value == nil

        print(successMessage)
        return value!
    }

    static func main() {

        let maximumItemVoume = 2.0

        // Input validation for measurements
        let width = getUserInput(
            question: "Enter room width",
            successMessage: "Width accepted"
        )

        let length = getUserInput(
            question: "Enter room length", 
            successMessage: "Length accepted"
        )

        let height = getUserInput(
            question: "Enter room height",
            successMessage: "Height accepted"
        )

        // Calculate room volume and area
        let roomArea = length * width
        let roomVolume = roomArea * height

        // Calculate Furniture volumes
        let furnitureVolumes = [1.2, 0.8, 2.5, 0.6, 1.0]
        for (index, furnitureVolume) in furnitureVolumes.enumerated () {
            print("Furniture \(index + 1): \(furnitureVolume)m³")
            if (furnitureVolume > maximumItemVoume) {
                print("Oversized item detected")
            }
        }

        // Calculate the usable volume
        var totalFurnitureVolume = 0.0
        for furnitureVolume in furnitureVolumes{
            totalFurnitureVolume += furnitureVolume
        }
        print("Total furniture volume =\(totalFurnitureVolume)m³")

        let usableroom = roomVolume - totalFurnitureVolume

        print("")        // Print blank line for readability


        // Users minimal volume
        let minimalVolume = getUserInput(
            question:("Enter minimal usable volume in meters cubed"),
            successMessage:("Volume accecpted")
        ) 

        // Print final sumamry
        print("")       // Prints blank line for easy to read summary

        
        print("Room area: \(roomArea) m²")
        print("Room volume:\(roomVolume) m³")
        print("Total furniture volume: \(totalFurnitureVolume) m³")
        print("Usable room: \(usableroom) m³")
        // Print success message if usable room is greater than users minimal volume
        if usableroom > minimalVolume {
            print("Usable volume is fine") 
        } else {
            print("Furniture takes up too much space")
        }
    }
}

