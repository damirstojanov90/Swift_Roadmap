//
//  NumberIteratorTests.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 19.08.2026..
//

/**
 USING SWIFT TESTING IN XCODE PROJECT

 1. Create a test target
  SELECT: File > New > Target… > Unit Testing Bundle
  - set "Target to be Tested" to your app target
  - this ensures that Testing.framework is automatically linked,  import Testing will not resolve in
    an app target without this

 2. Separate production and test code
  - app/business logic should exist in the main app folder - under DeliverableApp-P4
  - tests should exist under the main apps's folder (the test target) - under DeliverableApp-P4Tests

 3. Check target membership if something is not working
  - select the file and open File Inspector (keyboard: ⌥⌘1  -  SELECT: View > Inspectors > File)
  - check: "Target Membership" section
  - a test file should show only the Tests target checked
  - ff the app target is also checked, a compiler error will surface stating 'No such module 'Testing'!

 4. Add app target as @testable import
  - app code and test code are considered separate modules, so the test file needs:
        import Testing
        @testable import DeliverableApp_P4 (App Module Name)
  IMPORTANT:
    - hyphens in the app name need to be written as underscores
    - adding @testable import allows the test target to access internal-level declarations in the app module without
      marking anything public

 5. Write tests using Swift Testing syntax
     @Suite("Some Suite")
     struct SomeTests {
         @Test("description")
         func testSomething() {
             #expect(someCondition)
         }
     }
  - @Test/#expect/@Suite are Swift Testing

  - XCTestCase/XCTAssert is the older XCTest framework - imports of both are allowed in one file and will work fine
    but mixing them is not recommended for clarity

 6. Run Test
  - KEYBOARD: ⌘U runs the entire test plan
  - clicking gutter diamond icon next to @Suite runs the entire test suite
  - clicking gutter diamond icon next to @Test runs single test
  - TEST NAVIGATOR (KEYBOARD: ⌘6) allows us to run entire plan, specific suite or single test
  - test results are visible in the Debug Area, or in Test Navigator

 7. REPORT NAVIGATOR (KEYBOARD: ⌘9)
  - keeps a history of every build/run/test
  - selecting a test run from it allows us to see the full log, pass/failed per test, timings and Coverage

  - Coverage 74% means that 74% of executable lines in the app target were run by the test suite
  - 100% would mean that every branch or function in the covered target was executed at least once by some tests
  - IMPORTANT: measures only how many were executed, not how many passed or failed
  - a test can cover 100% of code but never assert anything and provide any useful insights

  - in NumberIterator, .reportCurrentState() is not run during the tests, but .init(), toggleNumber() and
    .generateRandomFloat() are, so coverage is 68,4%

CHECKLIST: Tests not building:
 - Is there a test target set?
 - Is the failing file's only target membership the test target?
 - Does the test file @testable import the right module name?
 - Same Swift Testing symbols throughout the file (no stray XCTest mixed in)?
 */

import Testing
@testable import DeliverableApp_P4

@Suite("Number Iterator Tests")
struct NumberIteratorTests {

    @Test("Test: NumberIterator always initializes with number set to 0")
    func testToggleNumber() {
        let iterator = NumberIterator()
        #expect(iterator.number == 0)
    }

    /// INTENTIONALY FLAKY: This test will fail ~50% of the time, per Deliverable specification!
    @Test("Test: generateRandomNumber result > 0.5")
    func testGenerateRandomNumber() {
        let iterator = NumberIterator()
        #expect(iterator.generateRandomFloat() > 0.5)
    }

    @Test("Test: toggleNumber() toggles number to 1")
    func testToggleNumberTo1() {
        let iterator = NumberIterator()
        iterator.toggleNumber()
        #expect(iterator.number == 1)
    }

    @Test("Test: toggleNumber() toggles number to 0 (when number is 1")
    func testToggleNumberTo0() {
        let iterator = NumberIterator()
        iterator.number = 1
        iterator.toggleNumber()
        #expect(iterator.number == 0)
    }
}
