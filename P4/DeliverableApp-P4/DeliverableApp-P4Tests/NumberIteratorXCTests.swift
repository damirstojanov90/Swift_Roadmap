//
//  NumberIteratorXCTests.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 20.08.2026..
//

/**
 USING XCTEST IN SWIFT PROJECTS

 To add tests to the project:
    - create a new subclass of `XCTestCase` within a test target (see NumberIteratorTests.swift for setting up
      test targets)
    - add one or more test methods to the test case
    - add one or more test assertions to each test method

- TEST METHOD
    - an instance method in an XCTestCase subclass with no parameters, no return value, and a name
      that begins with lowercase word `test`
    - automatically detected by XCTest framework, allowing us to run them individually, or as part of a suite

 - STRUCTURE:
    - use Given - When - Then
    - commonly used in test methods for better readability: "Given these conditions, when these actions are performed,
      then this is the expected outcome."

 - TIPS:
    - Test one thing at a time - focusing on one aspect of your code.
    - Write clear and descriptive test names
    - Mock data provided by external dependencies/systems such as APIs or databases

❗️Thread 1: signal SIGABRT
 - If the appTarget has SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor set in, every type gets
   implicilty @MainActor isolated (Swift 6.2) which triggers a deinit bug, especially in synchronous XCTest methods

  - swiftlang/swift#87316 — Crash during deallocation in XCTest with MainActor as default actor (https://github.com/swiftlang/swift/issues/87316)
     - the compiler bug itself, with repro and workarounds
  - Swift Forums: XCTestCase compiler error with Swift 6.2 default actor isolation MainActor (https://forums.swift.org/t/xctestcase-compiler-error-with-swift-6-2-default-actor-isolation-mainactor/83418)
     - the broader XCTest/MainActor-default friction and community-recommended setup

 - multiple ways to fix it:
         1. remove default MainActor isolation from the app target's build settings:
         2. mark the entire class as nonisolated:
             ✅ Works - but only applicable for individual non-UI classes tested with XCTest.
         3. add a nonisolated deinit {} to an implicit @MainActor isolated class:
             ✅ Works - need to include in every class you intend to test with XCTest.
         4. make the test method async (even though it's not doing any async work)
             ✅⚠️ TRUE - This works, but it also causes a bunch of warnings, unless you
             annotate the test method with @MainActor
 */

import XCTest
@testable import DeliverableApp_P4

class NumberIteratorXCTests: XCTestCase {
    /// When we want to use the same value or object multiple times throughout a TestCase,
    /// we can set it up by overriding `setUp()` allowing us to use them later.
    /// XCTest automatically calls setUp exactly once for a test case, before it's first method is called.
    /// For cleaning up - use tearDown().
    private var numberIterator: NumberIterator?

    override func setUp() {
        self.numberIterator = NumberIterator()
    }

    func testInitializesWithZero() {
//        let numberIterator = NumberIterator()
        XCTAssertTrue(numberIterator?.number == 0, "NumberIterator.number is not zero!")
        addTeardownBlock {
            /// Using `addTeardownBlock` registers a block of code to run after the current test method ends.
            /// Used for test-specific teardown code - i.e. if a resource that must be deleted when the test is completed:
            /// write the code to create the resource, IMMEDIATELY followed by code that registers a teardown block to delete the resource.
            print("⚠️⚠️ TEARING DOWN AFTER testInitializesWithZero! ⚠️⚠️")
        }
    }

    func testFlakyGenerateRandomFloat() {
//        let numberIterator = NumberIterator()
        XCTAssertTrue(
            numberIterator!.generateRandomFloat() > 0.5,
            "NumberIterator.generateRandomFloat() is not greater than 0.5!"
        )
    }

    func testToggleNumberToOne() {
        let iterator = NumberIterator()
        // XCTAssertEqual used here instead of XCTAssertTrue:
        XCTAssertEqual(iterator.number, 0, "NumberIterator.number is not zero!")
        iterator.toggleNumber()
        XCTAssertTrue(iterator.number == 1, ".toggleNumber did not toggle number from zero to one!")
    }

    func testToggleNumberToZero() {
        let iterator = NumberIterator()
        iterator.number = 1
        XCTAssertTrue(iterator.number == 1, "NumberIterator.number is not one!")
        iterator.toggleNumber()
        XCTAssertTrue(iterator.number == 0, ".toggleNumber did not toggle number from one to zero!")
    }
}
