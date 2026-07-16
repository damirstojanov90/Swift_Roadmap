/**
 Create an array of random numbers, with 100 elements. Find indices and count all
 numbers which are between 0.1 and 0.2, after that filter out all values above 0.9.
 Map the array multiplying values by 100 and converting them to Int. Convert the
 array into set filtering out all duplicates. Create a dictionary using tens as keys, and
 array of Ints as values, placing numbers with correct tens under the same key.
 */

func printSeparator() {
    print("\n------------------------------------\n")
}

/// Generates an array of random doubles between 0.0 and 2.0 containing count elements.
func generateRandomNumbers(count: Int) -> [Double] {
    var randomNumbers: [Double] = []
    for _ in 1...count {
        let randomNumber = Double.random(in: 0.0...2.0)
        randomNumbers.append(randomNumber)
    }
    return randomNumbers
}

/// Finds numbers between 0.1 and 0.2 in given array of Doubles, prints number and index where it was found.
/// NOTE: Written without using enumerated()
///
///
func findValues(randomNumbers: [Double]) {
    var currentIndex = 0
    var counter = 0

    for element in randomNumbers {
        if 0.1 < element && element < 0.2 {
            print("""
                Found number greater than 0.1 and less than 0.2! NUMBER: \(element) AT INDEX: \(currentIndex)
                """)
            counter += 1
        }
        currentIndex += 1
    }
    print("Found TOTAL OF \(counter) numbers between 0.1 and 0.2.")
}

/// Finds values (and indices of) greater than 0.1 and less than 0.2 inside given array.
///
/// NOTE: .enumerated() returns pairs (n, x) where n is a counter for the enumeration but can be used as an
/// index only in instances of zero-indexed., integered-indexed collections -> **Array** and **ContiguousArray**!
func findValuesAndIndices(randomNumbers: [Double]) {
    var foundValues: [(Int, Double)] = []

    for (index, element) in randomNumbers.enumerated() {
        if 0.1 < element && element < 0.2 {
            // ALTERNATIVE: Create a range 0.1...0.2 and check if it contains element.
            foundValues.append((index, element))
        }
    }
//    print("""
//        Found \(foundValues.count) values between 0.1 and 0.2 inside array.
//        """)
//    print("Found values: \(foundValues)")
}

let randomNumbers = generateRandomNumbers(count: 100)

// 1. Find all elements (and their indices) that are > 0.1 and 0.2:

findValuesAndIndices(randomNumbers: randomNumbers)

// 2. Filter out all values greater than 0.9:

//let filteredNumbers = randomNumbers.filter { $0 > 0.9 }
//print("Array filtered for values smaller than 0.9 - contains: \(filteredNumbers.count) values")
//printSeparator()

/// This doesn't actually "filter out" all the values greater than 0.9 from randomNumbers rather, it
/// returns an array filteredNumbers that contains all the values from randomNumbers that are greater than 0.9.
///
/// If we wanted to actually remove all numbers greater than 0.9, we would use .removeAll { $0 > 0.9 }, however,
/// since .removeAll is mutating, we can't use it on a constant, but on a variable, so we copy randomNumbers into a variable:
var randomNumbersVariable = randomNumbers
print("Copied array contains: \(randomNumbersVariable.count) values and is: \(type(of: randomNumbersVariable))")
randomNumbersVariable.removeAll(where: { $0 > 0.9 })
print("Copied array filtered for values smaller than 0.9 - contains: \(randomNumbersVariable.count) values")
printSeparator()

/// But if we wanted to simultaneously do steps 2 and 3, we could use .map and .filter combined.
//let randomNumbersFilteredAndMultiplied = randomNumbers
//    .filter { $0 < 0.9 } // Returns an array of randomNumbers elements smaller than 0.9.
//    .map { Int($0 * 100) }

// 3. Multiply all elements by 100 and convert them to Int.

let multipliedByHundred = randomNumbersVariable.map { Int($0 * 100) }

// 4. Convert array to set to filter out duplicates.

let numberSet = Set(multipliedByHundred)
print("Multiplied every element of filtered array by 100 and converted to set to remove duplicates.")
print("Set contains: \(numberSet.count) numbers.")
//print(numberSet)
//printSeparator()

// 5. Create a dictionary using tens as keys and arrays of Ints as values, placing them under correct key.
// 5.1 Create a number partitioning function:

/// Partitions given number into tens and ones.
///
/// - parameter number - number to partition
/// - returns (Int, Int) - tuple containing tens and ones.
///
/// WORTH NOTING:
/// Swift does not implicitly convert Int / Int into a Double, even if the result is
/// a double!
///
/// EXAMPLE:
/// let result = 57 / 10
/// print(result, type(of: result)) >>> 5 Int
///
/// You need to either explicityl type let result: Double = 57 / 10, or divide Double with Int
/// (or vice versa) to get a Double as a result.
func partitionNumber(_ number: Int) -> (ten: Int, ones: Int) {
    if number < 10 {
        return (ten: 0, ones: number)
    }

    let ten = number / 10
    let ones = number % 10
    return (ten: ten, ones: ones)
}

/// Sorts given array of numbers into a dictionary that has tens as keys and appends corresponding number
/// to it's ten component.
///
/// - parameter numbers - Array of integers to sort.
/// - returns Dictionary of numbers where key is number's ten component and value is an array of corresponding numbers.
func sortByTens(numbers: [Int]) -> [Int : [Int]] {
    var partitionedNumbers: [Int : [Int]] = [:]

    for number in numbers {
        let (ten, _) = partitionNumber(number)

        // Check if key exists and append if yes, create value array if no:
        if partitionedNumbers[ten] != nil {
            partitionedNumbers[ten]?.append(number)
        } else {
            partitionedNumbers[ten] = [number]
        }
    }

    return partitionedNumbers
}

/// Sorts given Sequence of numbers into a dictionary with tens as keys and arrays of corresponding Integers as values.
///
/// Uses Swift Dictionary's default subscripting which access value with given key but provides default fallback if key not found.
///
/// - parameters numbers: Any Sequence of Integers to be sorted.
/// - returns dictionary of tens as keys and array of corresponding numbers as values.
func sortByTensV2(numbers: any Sequence<Int>) -> [Int : [Int]] {
    var partitionedNumbers: [Int: [Int]] = [:]

    for number in numbers {
        let (ten, _) = partitionNumber(number)

        // Default subscripting: Access valye for key ten (if key does not exist,
        // add it to dictionary with value []) and add [number] to values array.
        partitionedNumbers[ten, default: []] += [number]
    }

    return partitionedNumbers
}

// Can pass either numberSet or numberSet.sorted().
// sortByTens() required numbers to be [Int], so numberSet had to be converted first.
let partitionedNumbers = sortByTensV2(numbers: numberSet)

print("Numbers sorted by tens:\n")
for (key, value) in partitionedNumbers.sorted(by: { $0.key < $1.key }) {
//for (key, value) in partitionedNumbers {
    print("TEN:\t\(key) -> ", terminator: "")
    for number in value {
        print("\(number)", terminator: " ")
    }
    print("")
}

/**
 ------------------------------------------------------------------------------
 In that dictionary check for values 55, 70, 99. If the value exists log it, otherwise log
 “Value not found.” Do not hardcode key search, instead create a function which will
 extract tens value, and based on it set proper key.
 */

// TODO: CHALLENGE: Refactor to O(1) - Explore and come up with a solution:
func lookFor(values: any Sequence<Int>, in dictionary: [Int: [Int]]) {
    /// 1. for LOOP - O(n), performance rises with number of iterations in a linear fashion.

    /// 2. .sorted() - O(n log n), sits between linear (O(n)) and quadratic (O(n^2)), runs only ONCE when values
    /// gets sorted, the first for loop iterates through those.
    /// ⚠️ ISSUE: This is sort of unnecessary, it doesn't really matter what order the target values are in.
    for value in values.sorted() {
        // Reuse partitionNumber for extracting ten of lookup value:
        /// 3. partitionNumber(: Int) is flat performance, it just divides, stores and returns a tuple. -> Ignore.
        let (ten, _ ) = partitionNumber(value)

        // Check that dictionary contains that key:
        /// 4. Acessing the correct array of Ints in the dictionary is flat (O(1)), since Dictionaries use hash tables. -> Ignore.
        guard let valuesForTen = dictionary[ten] else {
            print("⚠️ Value  \(value)  not in dictionary  ->  No values for key:   \(ten)  !")
            continue
        }
        // Check if lookup value contained in the values:
        /// 5. On the dictionary array, we are using .contains, which is linear performance (O(n)), meaning it rises with the number of elements.
        /// However, this should be 10 elements at max?
        if valuesForTen.contains(value) {
            print("✅ Value  \(value)  found under key:  \(ten)  : \(valuesForTen)  !")
        } else {
            print("❌ Value  \(value)  not found  ->  Values for key:  \(ten)  : \(valuesForTen)  !")
        }
    }
    /// Once all the performance costs are put together, we have:
    /// 1. a single O(n log n) - .sorted
    /// 2. O(1) + O(1) + O(n) running values.count times.
    /// HOWEVER, since .sorted depends on the size of the values array, and .contains depends on the size of the dictionary[ten] array, we need to change those values to:
    /// O(n log n) + n x ( O(1) + O(1) + O(m)) n = values.count and m = dictionary[ten].count.
    /// Since we can ignore O(1)s, that leaves us with:
    ///
    /// O(n log n + n x m)
    ///
    /// So, we have two friction points:
    /// 1. unnecessary `values.sorted()` call
    /// 2. `valuesForTen.contains(value)`call
}

/// A refactored version of `func lookFor(values: any Sequence<Int>, in dictionary: [Int: [Int]])`.
///
/// Still not O(1) since we are converting a dictionary to Set using flatMap which is O(n+m)
/// where n is the lenght of the sequence and m is length of the result,
/// and then using a for loop with values which is O(n), but since numbers is a Set, numbers.contains(value) is now O(1).
func lookForV2(values: any Sequence<Int>, in dictionary: [Int: [Int]]) {
    let numbers = Set(dictionary.values.flatMap { $0 })
    for value in values {
        if numbers.contains(value) {
            print("✅ Value \(value) contained in numbers.")
        } else {
            print("❌ Value \(value) not found.")
        }
    }
}

printSeparator()
let lookupNumbers = [55, 70, 99]
//lookFor(values: lookupNumbers, in: partitionedNumbers)
lookForV2(values: lookupNumbers, in: partitionedNumbers)
