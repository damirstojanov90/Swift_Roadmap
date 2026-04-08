/**
Create a struct, containing parameter count. Block any external access to
parameter. Create functions which will read from and write to the parameter.
*/

struct SomeStruct {
    private var count: Int = 0

    mutating func addToCount(_ increment: Int) {
        print("Adding\t\(increment)\t to count.")
        self.count += increment
    }

    func checkCount() -> Int {
        return self.count
    }

    func displayCount() {
        print("Current count:\t\t\(self.checkCount())")
    }
}

/// Since var count is the only property and is private, the automatic memberwise initializer takes 0 arguments,
/// the following line causes:
/// >>> Argument passed to call that takes no arguments
//var testStruct = SomeStruct(count: 17)

var myStruct = SomeStruct()
myStruct.displayCount()
myStruct.addToCount(17)
myStruct.displayCount()
myStruct.addToCount(78946513132)
myStruct.displayCount()
