import Foundation

/**
 Phase 1 - Deliverable 1

 Create a for loop for number 1 to 100 which will
 count and list all prime numbers.
 */
func loopPrimesV1() {
    // 1. Create an array of integers from 1 to 100 using a closed range.
    let numbers = Array(1...100)
    var primeNumbers: [Int] = []

    // 2. Loop through them:
    for number in numbers {
        // 3. Skip 1 since it isn't a prime and will break divisors range.
        if number == 1 {
            continue
        }

        // 4. Create test flag isPrime, set it to true.
        var isPrime: Bool = true

        // 5. Create an array of all divisors of number (from 2 to number - 1):
        let divisors = Array(2..<number)

        // 6. Use modulo on number with every divisor:
        for divisor in divisors {
            let remainder = number % divisor

            // 7. If remainder is 0, the number is not a prime: set isPrime to FALSE, break the INNER loop.
            if remainder == 0 {
                isPrime = false
                break
            }
        }

        // 8. Once INNER loop finishes, check isPrime flag:
        if isPrime {
            // 9. If number isPrime, append it to primeNumbers array.
            primeNumbers.append(number)
        }
        // 10. Otherwise continue:
        continue
    }

    // 11. Print how many prime numbers were found, and a list of them:
    print("Found \(primeNumbers.count) prime numbers between 1 and 100!\n\(primeNumbers)")
}

loopPrimesV1()
