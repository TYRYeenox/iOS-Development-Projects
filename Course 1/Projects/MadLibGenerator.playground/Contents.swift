import UIKit

var greeting = "Hello, playground"


func generateMadLib(
    noun: String,
    adjective: String,
    verb: String,
    place: String
) -> String {
    
    if noun.isEmpty || adjective.isEmpty || verb.isEmpty || place.isEmpty {
        return "Invalid Input"
    }

    let randomStorySelection: Int = Int.random(in: 1...3)
    
    switch randomStorySelection {
        
    case 1:
        return """
        Last week, a \(adjective) \(noun) wanted to \(verb) on over to the \(place). 
        The \(noun) found that being \(adjective) was the best way to blend into the \(place), and to survive.
        """
        
    case 2:
        return """
        Around the \(place), a \(adjective) \(noun) demonstrated how to \(verb). 
        local animals watched as the \(noun) showed that adventures are amazing if you \(verb).
        """
        
    case 3:
        return """
        Once upon a time, a \(adjective) \(noun) was heard around town that they like to \(verb) near the \(place). 
        Legend has it the \(noun) is still there, telling everyone to stay \(adjective) 
        and never stop trying to \(verb).
        """
        
    default:
        return "Invalid Input"
    }
}

let madLib = generateMadLib(
    noun: "bottle",
    adjective: "green",
    verb: "roll",
    place: "flatlands"
)

print(madLib)
