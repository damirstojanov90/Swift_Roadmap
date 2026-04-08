import Foundation

let someQueue = DispatchQueue(label: "my-queue")
someQueue.sync {
  print("print this")

  someQueue.sync {
    print("deadlocked")
  }
}

print("Done on someQueue.")
