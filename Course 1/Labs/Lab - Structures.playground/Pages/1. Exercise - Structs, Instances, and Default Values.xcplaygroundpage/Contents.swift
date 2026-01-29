/*:
## Exercise - Structs, Instances, and Default Values
 
 Imagine you are creating an app that will monitor location. Create a `GPS` struct with two variable properties, `latitude` and `longitude`, both with default values of 0.0.
 */
struct gps {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}
//:  Create a variable instance of `GPS` called `somePlace`. It should be initialized without supplying any arguments. Print out the latitude and longitude of `somePlace`, which should be 0.0 for both.
var somePlace = gps ()

print("Latitude:", somePlace.latitude)
print("Longitude:", somePlace.longitude)
//:  Now imagine you are making a social app for sharing your favorite books. Create a `Book` struct with four variable properties: `title`, `author`, `pages`, and `price`. The default values for both `title` and `author` should be an empty string. `pages` should default to 0, and `price` should default to 0.0.
struct book {
    var title: String = ""
    var author: String = ""
    var pages: Int = 0
    var price: Double = 0.0
}

//:  Create a variable instance of `Book` called `favoriteBook` without supplying any arguments. Print out the title of `favoriteBook`. Does it currently reflect the title of your favorite book? Probably not. Change all four properties of `favoriteBook` to reflect your favorite book. Then, using the properties of `favoriteBook`, print out facts about the book.
var favoriteBook = book()

favoriteBook.title = "Random Book Title"
favoriteBook.author = "John"
favoriteBook.pages = 50
favoriteBook.price = 9.99

print("My favorite book is \(favoriteBook.title).")
print("Written by \(favoriteBook.author).")
/*:
page 1 of 10  |  [Next: App Exercise - Workout Tracking](@next)
 */
