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
            foundValues.append((index, element))
        }
    }
//    print("""
//        Found \(foundValues.count) values between 0.1 and 0.2 inside array.
//        """)
//    print("Found values: \(foundValues)")
}


// 1. Create an array containing 100 random numbers:

let randomNumbers = generateRandomNumbers(count: 100)

// 2. Find all elements (and their indices) that are > 0.1 and 0.2:

findValuesAndIndices(randomNumbers: randomNumbers)

// 3. Filter out all values greater than 0.9:

let filteredNumbers = randomNumbers.filter { $0 < 0.9 }
print("Array filtered for values smaller than 0.9 - contains: \(filteredNumbers.count) values")
printSeparator()

// 4. Multiply all elements by 100 and convert them to Int.

let multipliedByHundred = filteredNumbers.map { Int($0 * 100) }

// 5. Convert array to set to filter out duplicates.

let numberSet = Set(multipliedByHundred)
//print("Multiplied every element of filtered array by 100 and converted to set to remove duplicates.")
//print("Set contains: \(numberSet.count) numbers.")
print(numberSet)
printSeparator()

// 6. Create a dictionary using tens as keys and arrays of Ints as values, placing them under correct key.
// 6.1 Create a number partitioning function:

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

func lookFor(values: any Sequence<Int>, in dictionary: [Int: [Int]]) {
    for value in values.sorted() {
        // Reuse partitionNumber for extracting ten of lookup value:
        let (ten, _ ) = partitionNumber(value)


// TODO: Replace this block with a function and map it to values?
        // Check that dictionary contains that key:
        guard let valuesForTen = dictionary[ten] else {
            print("⚠️ Value  \(value)  not in dictionary  ->  No values for key:   \(ten)  !")
            continue
        }
        // Check if lookup value contained in the values:
        if valuesForTen.contains(value) {
            print("✅ Value  \(value)  found under key:  \(ten)  : \(valuesForTen)  !")
        } else {
            print("❌ Value  \(value)  not found  ->  Values for key:  \(ten)  : \(valuesForTen)  !")
        }
    }
}

printSeparator()
let lookupNumbers = [55, 70, 99]
lookFor(values: lookupNumbers, in: partitionedNumbers)
