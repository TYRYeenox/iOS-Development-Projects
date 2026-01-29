/*:
## Exercise - Return Values

 Write a function called `greeting` that takes a `String` argument called name, and returns a `String` that greets the name that was passed into the function. I.e. if you pass in "Sophie" the return value might be "Hi, Sophie! How are you?" Use the function and print the result.
 */
func greeting(name: String) -> String {
    return ("Hi \(name), how are you?")
}
let message = greeting(name: "Brandon")
print(message)
//:  Write a function that takes two `Int` arguments, and returns an `Int`. The function should multiply the two arguments, add 2, then return the result. Use the function and print the result.
func multiplyAndAddTwo(_ first: Int, _ second: Int) -> Int {
    let result = (first * second) + 2
    return result
}

let answer = multiplyAndAddTwo(1, 2)
print(answer)
/*:
[Previous](@previous)  |  page 5 of 6  |  [Next: App Exercise - Separating Functions](@next)
 */
