/**
 Phase 2 - Deliverable 2

 Create and explain a sample Protocol with constant “ID” of type String, variable
 “dimensions” of type CGFloat. Explain differences for constants and variables.

 Add a function to protocol “resize”, create protocol extension and define default
 implementation for the function.

 Conform protocol to Equatable, override “equals” function in extension to return
 equals based on ID.
 */

import Foundation

protocol IdentifiableWithDimensions: Equatable {
    /// Protocols do not allow us to declare properties as either constants or variables, we can declare them as var,
    /// declare their Type, and whether they are gettable, settable or both - meaning, we can't do:
    ///
    /// `let id: String { get }` - we'd only get errors.
    ///
    /// The only choice we do have is to declare it with a getter only, which allows the conforming type to declare id
    /// as a constant property...
    var id: String { get }
    /// However, since the property dimensions is declared as gettable AND settable, any conforming types are
    /// required to provide a setter, so the property cannot be constant!
    var dimensions: CGFloat { get set }

    mutating func resize(_ dimensions: CGFloat)
}

extension IdentifiableWithDimensions {
    mutating func resize(_ dimensions: CGFloat) {
        print("\(self.id) - MODIFYING DIMENSIONS TO: \(dimensions)")
        self.dimensions = dimensions
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

class Line: IdentifiableWithDimensions {
    let id: String
    //let dimensions: CGFloat // Type 'Shape' does not conform to protocol 'IdentifiableDimensions'.
    var dimensions: CGFloat

    /// Since we defined a default implementation of resize in the protocol extension, we are not required to implement it in the conforming type.

    init(id: String, dimensions: CGFloat) {
        self.id = id
        self.dimensions = dimensions
    }

    // This is fine:
    func resizeDoubled(_ dimensions: CGFloat) {
        self.dimensions = dimensions * 2
    }
}

var line1 = Line(id: "Line 1", dimensions: 17.67)
print("Line 1 - id: \t\t\(line1.id); dimensions:\t\t\(line1.dimensions)")
line1.resize(9874531.87645132)
print("Line 1 - id: \t\t\(line1.id); dimensions:\t\t\(line1.dimensions)")

var line2 = Line(id: "Line 2", dimensions: 22.7)
print("line1 == line2 IS \(line1 == line2)")

var line3 = Line(id: "Line 1", dimensions: 987846312487813.545478)
print("line1 == line3 IS \(line1 == line3)")
// The comparison by ID works.

//MARK: - Interesting:
//let line1 = Line(id: "Line 1", dimensions: 17.67)
//line1.resize(9874531.87645132)
/// Curious: Although Line is a class and since classess are reference types that allow us to modify properties even
/// with `let` instances of a class, calling .resize on a let instance of Line causes:
///
/// 🛑 Cannot use mutating member on immutable value: 'line1' is a 'let' constant
///
/// IdentifiableWithDimensions declares the default implementation of resize with the `mutating` keyword,
/// and since Line uses the default implementation,  it apparently inherits the mutating constraint and let instances get
/// blocked at the call site by the compiler.
///
/// If we overrode the the default implementation of resize in Line without the mutating keyword, we could use it even with
/// let instances of the class.
///
/// This is still fine, though:
let randomLine = Line(id: "Random Line", dimensions: 1.0)
randomLine.dimensions = 9001

/// But, if we didn't have the mutating modifier, we wouldn't be able to use this with structs (var instances of structs, of course):
struct ShortLine: IdentifiableWithDimensions {
    var id: String
    var dimensions: CGFloat

    // THIS IS NOT:
//    func resizeDouble(_ dimensions: CGFloat) {
//        self.dimensions = dimensions * 2
//    }
    
}
var shortLine = ShortLine(id: "Really short line", dimensions: 0.000001)
shortLine.resize(0.00001)

//let anotherShortLine = ShortLine(id: "A short line", dimensions: 0.1)
//anotherShortLine.resize(78) // 🛑 Cannot use mutating member on immutable value: 'anotherShortLine' is a 'let' constant
