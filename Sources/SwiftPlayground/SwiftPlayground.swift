// The Swift Programming Language
// https://docs.swift.org/swift-book

func printRoomIntro() {
    print("This program calculates room volume and area")
    print("This program also finds usable volume after furniture is placed")
}

func printDivider() {
    print("---------------")
}

func printUnitsNote() {
    print("All measurements in meters.")
}

func printGoodbye (){
    print("Done. Thanks for using the Calculator")
}

@main
struct SwiftPlayground {
    static func main() {

printRoomIntro()
printUnitsNote()
printDivider()
print("Summar Here")
printDivider()
printGoodbye()
    }
}
