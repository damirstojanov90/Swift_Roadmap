//: [Previous](@previous)

enum CustomError: Error {
    case always

    var message: String {
        switch self {
        case .always: "This is an error that is always supposed to be thrown from a function."
        }
    }
}

func throwError(number: Int) throws -> Int {
    throw CustomError.always
}

func dontThrowError(number: Int) -> Int {
    return number * number
}

func callOtherFunctions() {
    let someNumber = 7

    let dontThrowErrorResult = dontThrowError(number: someNumber)
    print("✅ func dontThrowError EXECUTED - result:\t\(dontThrowErrorResult)")

/**
 TRY
 Try is used to identify places in our code that can throw errors, meaning, that we need to mark calling throwing functions
 using `try` in order to propagate those errors..
 Whenever we are calling throwing functions, we need to either call them from within a do-catch block,
 or from withing another function that is marked throws (which again needs to be called from a do catch block, etc....).

 So, the code below will actually cause a compile time error:

 warning: TryErrors.xcplaygroundpage:62:23: comparing non-optional value of type 'Int' to 'nil' always returns true
     if functionResult != nil {
        ~~~~~~~~~~~~~~ ^  ~~~

 warning: TryErrors.xcplaygroundpage:34:9: variable 'functionResult' was never mutated; consider changing to 'let' constant
     var functionResult = try throwError(number: someNumber)
     ~~~ ^
     let

 error: TryErrors.xcplaygroundpage:34:26: errors thrown from here are not handled
     var functionResult = try throwError(number: someNumber)
                          ^
 */
//    var functionResult = try throwError(number: someNumber)

/**
 TRY?
 If we are calling a throwing function, and we use `try?`, we are basically converting errors to optional values.
 Meaning, if an error is thrown while evaulating the try expression, the value of the expression will be nil.

 So in the case below, functionResult will evaluate to nil:

 ✅ func dontThrowError EXECUTED - result:    49
 ⚠️ functionResult is nil!

 NOTE: Same rules as with optionals apply.
 - you can use guard:

 guard var functionResult = try? throwError(number: someNumber) else {
    // throwError threw an error, function result is nil, come up with something to do...
 }

 - you can use the coalescing operator:

 var functionResult = (try? throwError(number:someNumber) ?? Something`

 */
    var functionResult = try? throwError(number: someNumber)

/**
 TRY!
 When using `try!`, we are essentially disabling error propagation. Meaning, that we are asserting that no errors will
 be thrown in runtime (which also allows us to call a throwing function from outside of a do-catch block because the compiler will not flag it).

 However, if an error does occur, then we get a runtime error:

 ✅ func dontThrowError EXECUTED - result:    49
 __lldb_expr_1095/TryErrors.xcplaygroundpage:55: Fatal error: 'try!' expression unexpectedly raised an error: __lldb_expr_1095.CustomError.always

 */
//    var functionResult = try! throwError(number: someNumber)

    if functionResult != nil {
        print("🤯 functionResult IS NOT NIL!")
    } else {
        print("⚠️ functionResult is nil!")
    }
}

callOtherFunctions()
