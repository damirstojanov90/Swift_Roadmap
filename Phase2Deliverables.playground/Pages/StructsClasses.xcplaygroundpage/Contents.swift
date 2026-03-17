/**
 Phase 2 - Deliverable 1

 Create a struct and a class, with parameter of type Int with any value.
 Create variables containing each.
 Create new variables referencing previous ones.
 Modify their values.
 Log old struct and class and new ones.
 Explain differences and behavior.
 */

// Define a struct and a class:
struct ExampleStruct {
    var value: Int = 7
}

class ExampleClass {
    var value: Int = 7
}

// Create instances of both:
var aStruct = ExampleStruct(value: 17)
// var aClass = ExampleClass(value: 700) // ERROR - no memberwise initializer for classes.
var aClass = ExampleClass()

func printValuesFor(
    _ someStruct: ExampleStruct,
    _ someClass: ExampleClass
) {
    print(
        "aStruct: \t - type:  \(type(of: someStruct))  ,"
          + " \t - value:  \(someStruct.value)  "
    )
    print(
        "aClass: \t - type:  \(type(of: someClass))  ,"
          + "\t - value: \(someClass.value)  "
    )
    print("⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n")
}

func printByDump(
    _ someStruct: ExampleStruct,
    _ someClass: ExampleClass
) {
    print("STRUCT:")
    dump(someStruct)
    print()
    print("CLASS:")
    dump(someClass)
    print("⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n")
}

// Dump aStruct and aClass:
//printByDump(aStruct, aClass)

// Create new variables referencing previous ones:
var anotherStruct = aStruct
var anotherClass = aClass

//printByDump(anotherStruct, anotherClass)

// Modify their values:
anotherStruct.value = 700
anotherClass.value = 1700

// Dump both old an new variables for comparison:
printByDump(anotherStruct, anotherClass)

printByDump(aStruct, aClass)
// Be shocked!

/**
 Output for lines 67 and 69:

 STRUCT:
 ▿ __lldb_expr_636.ExampleStruct
   - value: 700

 CLASS:
 ▿ __lldb_expr_636.ExampleClass #0
   - value: 1700
 ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯

 STRUCT:
 ▿ __lldb_expr_636.ExampleStruct
   - value: 17

 CLASS:
 ▿ __lldb_expr_636.ExampleClass #0
   - value: 1700
 ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯

 Biggest takeaway here is that structs are value types and classes are reference types, meaning:
    - structs are a VALUE TYPE, meaning that they are a type whose value is copied when assigned to a variable or constant,
    or when it's passed to a function -> a completely new value is being created in a new memory block with the variable referencing that block
    - classes are a REFERENCE TYPE, meaning that their value does not get copied when assigned or passed to a function,
    rather, a REFERENCE to the same existing instance is used -> the memory block containing the initial value just gets another variable referencing it

 Meaning, you can safely use structs to "copy" instances, since you are creating a full fledged "copy" of the original, but you can't "copy" classes by just assigning an existing instance to a new variable, since it just creates a reference to an already existing object.

 So, above in:

    `var anotherClass = aClass`
    `anotherClass.value = 1700`

 you created another reference to aClass' values, so when you directly changed .value to 1700 via instance anotherClass, you basically had two people pointing at the same box (sort of), but when you did the same to structs, you had two people looking at two different boxes.

However:
 */

var yetAnotherClass = ExampleClass()
dump(yetAnotherClass)
yetAnotherClass.value = 1
dump(aClass)
dump(anotherClass)
dump(yetAnotherClass)
