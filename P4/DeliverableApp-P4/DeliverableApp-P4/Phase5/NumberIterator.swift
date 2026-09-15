//
//  NumberIterator.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 19.08.2026..
//

/** Deliverables
1. Create a class object which will iterate over a function yielding various results, for
example return a random number between 0 and 1. Create a test case which will
succeed only if returned value is > 0.5

2. Create an object which will contain a number parameter of value 0, and a function
which will change that value to 1 when called. Create a test case which will observe
the value change and assert whether value is 1.
*/

// TODO: Better naming, NumberIterator does not reflect what the class actually does?
class NumberIterator {
    var number: Int

    init() {
        self.number = 0
    }

// See NumberIteratorXCTests.swift for clarification on this:
    nonisolated deinit {}

    /// Specification requires changing number from 0 to 1,
    /// toggling between 0 and 1 added intentionally for Testing.
    func toggleNumber() {
        if self.number == 0 {
            self.number = 1
        } else {
            self.number = 0
        }
    }

    func generateRandomFloat() -> Double {
        return Double.random(in: 0.0...1.0)
    }

    func reportCurrentState() {
        print("""
            NumberIterator current state:
              - var number: Int = \(self.number)
            """)
    }
}
