/**
 Phase 3 - Error handling in Swift.

 1. Create a function which mocks a request, handling possible errors in a do-catch block.

 3. Update the function from first deliverable, create custom errors for handling HTTP codes, custom error
 handling body (if not in proper format or missing).
 Update do-catch block handling each type of error individually.

 4. Update the function from first deliverable, add a parameter `isLoading: Bool` outside the function.
 Handle loading state using `defer` keyword.


 */

import Foundation

enum RequestError: Int, Error {
    case responsesUnavailable = 999
    case serverError = 500
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
}

enum UnknownError: Error {
    case unknown
}

struct Response {
    let code: Int
    let body: String?
}

/**
 Using #"..."# for raw string litterals allows " without escape characters to mimic JSON in response bodies.
 */
let responses = [
    Response(code: 200, body: #"{"id": 1, "name": "Damir"}"#),
    Response(code: 200, body: #"{"id": 2, "name": "Ana"}"#),
    Response(code: 401, body: #"{"error": "Unauthorized", "message": "Token expired"}"#),
    Response(code: 403, body: nil),
    Response(code: 404, body: #"{"error": "Not Found", "message": "Resource missing"}"#),
    Response(code: 500, body: #"{"error": "Internal Server Error"}"#),
    Response(code: 200, body: "not even json")  // malformed body, useful for deliverable 3
]

func sendRequest() throws -> Response {
    guard let response = responses.randomElement() else {
        throw RequestError.responsesUnavailable
    }
    guard response.code == 200 else {
        throw RequestError(rawValue: response.code) ?? UnknownError.unknown
    }
    return response
}

/// Indicates whether requestHandler is running.
var isLoading: Bool = false

/// Mocks sending a request and handles errors using a do-catch block.
/// NOTE: Since isLoading is a global variable, it is isolated to MainActor by default, so
/// Swift will only allow reading/mutating it from the main thread.
/// requestHandler() is treated as nonisolated, so we need to explicitly mark it with @MainActor,
/// or wrap everything inside of a class.
@MainActor func requestHandler() {
    isLoading = true
    defer {
        print("✅  func requestHandler() - EXECUTION COMPLETED ( defer ).")
        isLoading = false
    }
    do {
        if isLoading {
            print("⏳ EXECUTING REQUESTS, PLEASE WAIT.")
            sleep(2)
        }
        let response = try sendRequest()
        print("🍀  \(response.code) - OK:  \(response.body ?? "N/A")")
    } catch let error as RequestError {
        switch error {
        case .responsesUnavailable:
            print("⚠️  Unable to select a random response!")
        case .unauthorized:
            print("🔐  Unauthorized.")
        case .serverError:
            print("💥  An internal server error has occured.")
        case .forbidden:
            print("⛔️  Access forbidden.")
        case .notFound:
            print("👀  Not found.")
        }
    } catch let error {
        print("☠️  An unknown error has occured:  \(error)")
    }
}

requestHandler()
print("isLoading: \(isLoading)")
