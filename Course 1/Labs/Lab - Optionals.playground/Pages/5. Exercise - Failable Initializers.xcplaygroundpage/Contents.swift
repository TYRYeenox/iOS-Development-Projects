/*:
## Exercise - Failable Initializers

 Create a `Computer` struct with two properties, `ram` and `yearManufactured`, where both parameters are of type `Int`. Create a failable initializer that will only create an instance of `Computer` if `ram` is greater than 0, and if `yearManufactured` is greater than 1970, and less than 2020.
 */
struct Computer {
    let ram: Int
    let yearManufactured: Int
    
    init?(ram: Int, yearManufactured: Int) {
        guard ram > 0,
              yearManufactured > 1970,
              yearManufactured < 2020 else {
            return nil
        }
        
        self.ram = ram
        self.yearManufactured = yearManufactured
    }
}

//:  Create two instances of `Computer?` using the failable initializer. One instance should use values that will have a value within the optional, and the other should result in `nil`. Use if-let syntax to unwrap each of the `Computer?` objects and print the `ram` and `yearManufactured` if the optional contains a value.

let computer1: Computer? = Computer(ram: 16, yearManufactured: 2015)
let computer2: Computer? = Computer(ram: 0, yearManufactured: 2022)

if let newer = computer1 {
    print("Computer 1 RAM: \(newer.ram), Year: \(newer.yearManufactured)")
} else {
    print("Computer 1 is nil")
}

if let older = computer2 {
    print("Computer 2 RAM: \(older.ram), Year: \(older.yearManufactured)")
} else {
    print("nil")
}

/*:
[Previous](@previous)  |  page 5 of 6  |  [Next: App Exercise - Workout or Nil](@next)
 */
