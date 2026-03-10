/**
 Create an enum “Semaphore”, which will contain red and green cases, create a
 while loop looking at a variable of type of that enum with initial value of .green. It will
 indefinitely iterate over random numbers, and switch to red only if the random value
 is between 0.5 and 0.6. When value switched to .red exit loop.
 */

enum Semaphore {
    case green
    case red

    var light: String {
        switch self {
        case .green:
            return "✅ Green Light"
        case .red:
            return "🛑 Red Light"
        }
    }

    var meaning: Bool {
        switch self {
        case .green:
            return true
        case .red:
            return false
        }
    }
}

var counter: Int = 0

var trafficLight: Semaphore = .green

print("Starting Semaphore:\t\(trafficLight.light)")

while trafficLight.meaning {
    let randomDouble = Double.random(in: 0.0...5.0)
    counter += 1
    if 0.5 <= randomDouble && randomDouble <= 0.6 {
        trafficLight = .red
        print("""
            Semaphore ran for:  \(counter)  iterations.
            Detected number between 0.5 and 0.6:  \(randomDouble)  .
            Switching Seamphore: \(trafficLight.light)
            """
        )
    }
}
