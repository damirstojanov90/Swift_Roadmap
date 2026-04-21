/**
 Define ARC, create a example of deadlock, provide a fix for it.

 ARC - Automatic Reference Counting
    Swift counts number of active (strong) references to an instance of a class. Once the number of active
 references becomes zero, the instance automatically deinitializes.

 DEADLOCK
    Occurs when two or more threads are blocked indefinitly, each waiting for the other to release a
 shared resource (an object/variable, execution context - e.g.: MainThread for updating UI, file handle on the disk, ...).
 */

import Foundation

let lockOne: NSLock = NSLock()
let lockTwo: NSLock = NSLock()

let threadOne = DispatchQueue(label: "ThreadOne")
let threadTwo = DispatchQueue(label: "ThreadTwo")

func lockingOneTwo(on thread: DispatchQueue) {
    let tag = " 1 - 2 | \(thread.label) | "
    print("\(tag)Starting !")
    print("\(tag)🔐 LOCKING #1!")
    lockOne.lock()
    sleep(2)
    print("\(tag)Slept for 2 seconds.")
    print("\(tag)🔐 LOCKING #2!")
    lockTwo.lock()
    sleep(1)
    print("\(tag)🔓 UNLOCKING #1 and #2")
    lockOne.unlock()
    lockTwo.unlock()
}

func lockingTwoOne(on thread: DispatchQueue) {
    let tag = " 2 - 1 | \(thread.label) | "
    print("\(tag)Starting !")
    print("\(tag)🔐 LOCKING #2!")
    lockTwo.lock()
    sleep(2)
    print("\(tag)Slept for 2 seconds.")
    print("\(tag)🔐 LOCKING #1!")
    lockOne.lock()
    sleep(1)
    print("\(tag)🔓 UNLOCKING #2 and #1")
    lockTwo.unlock()
    lockOne.unlock()
}

threadOne.async {
    lockingOneTwo(on: threadOne)
}

threadTwo.async {
    lockingTwoOne(on: threadTwo)
}

//threadTwo.async {
//    lockingOneTwo(on: threadTwo)
//}

/**
 threadOne holds lockOne, waits two seconds.
 threadTwo holds lockTwo, waits two seconds.

 Since they are async, they both hold locks at the same time, once sleep(2) passes, threadOne attempts to acquire lockTwo (held by threadTwo), and threadTwo attempts to acquire lockOne (held by threadOne).

 Both threads must wait for the lock they are trying to acquire to be released, so 1 waits for 2, 2 for 1, 1 for 2, ... indefinetly.

 The FIX is to make sure that both threads acquire locks in the same order -> 1 then 2
 (commented out code on lines 59 - 61).
  - threadOne starts, holds lockOne, sleeps 2
  - threadTwo starts, attempts to acquire lockOne -> BLOCKED by threadOne -> WAITS FOR LOCK TO RELEASE !!!
  - threadOne sleeps for 2 seconds, grabs lockTwo, sleeps for 1 second
  - threadOne unlocks both, threadTwo now grabs lockOne, sleeps 2, ...

 Deadlocks need circular dependencies, so if the same locking order is enforced, they shouldn't occur.
 */

print("✅ DONE WITH WORK.")
