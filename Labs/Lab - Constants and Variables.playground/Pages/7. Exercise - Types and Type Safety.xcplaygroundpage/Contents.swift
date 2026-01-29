/*:
## Exercise - Types and Type Safety
 
 Declare two variables, one called `firstDecimal` and one called `secondDecimal`. Both should have decimal values. Look at both of their types by holding Option and clicking the variable name.
 */
var firstDecimal: Double = 1.1
var seondDecimal: Double = 2.2
//:  Declare a variable called `trueOrFalse` and give it a boolean value. Try to assign it to `firstDecimal` like so: `firstDecimal = trueOrFalse`. Does it compile? Print a statement to the console explaining why not, and remove the line of code that will not compile.
var trueOfFalse: Bool = false
//firstDecimal = trueOfFalse
print("Cannot assign a bool to a double. The types do not match")
//var string: String = "a variable conflicts with a true or false statement?"
//:  Declare a variable and give it a string value. Then try to assign it to `firstDecimal`. Does it compile? Print a statement to the console explaining why not, and remove the line of code that will not compile.
let name = "my name"
//firstDecimal = name
//var stringValue: String = "because a string is a list of words, I believe"
print("A string is not a double because the types are different")

//:  Finally, declare a variable with a whole number value. Then try to assign it to `firstDecimal`. Why won't this compile even though both variables are numbers? Print a statement to the console explaining why not, and remove the line of code that will not compile.
let wholeNumber = 11
//firstDecimal = wholeNumber
var String: String = "a whole number is an Int, and not a Double. They are different types."
/*:
[Previous](@previous)  |  page 7 of 10  |  [Next: App Exercise - Tracking Different Types](@next)
 */
