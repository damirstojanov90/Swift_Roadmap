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

enum RequestError: Error {
    case responsesUnavailable
    case serverError
    case unauthorized
    case forbidden
    case notFound
    case unknown(Int)

    var code: Int {
        switch self {
        case .responsesUnavailable: 999
        case .serverError: 500
        case .unauthorized: 401
        case .forbidden: 403
        case .notFound: 404
        case .unknown(let code): code
        }
    }

    static func from(code: Int) -> RequestError {
        switch code {
        case 999: .responsesUnavailable
        case 500: .serverError
        case 401: .unauthorized
        case 403: .forbidden
        case 404: .notFound
        default: .unknown(code)
        }
    }
}

enum BodyError: Error {
    case missing
    case invalidFormat
    case conversionToData
}

enum UnknownError: Error {
    case unknown
}

struct Response {
    let code: Int
    let body: String?
}

/**
 Using #"..."# (EXTENDED DELIMITERS) for raw string litterals allows " without escape characters to mimic JSON strings in response bodies?
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
        throw RequestError.from(code: response.code)
    }
    guard response.body != nil else {
        throw BodyError.missing
    }
    guard let data = response.body?.data(using: .utf8) else {
        throw BodyError.conversionToData
    }
    /// Here, JSONSerializayion.jsonObject(with: data) is used purely to check whether data (bytes) are a valid JSON.
    /// try? evaluates to `nil` on throw, `Any` on success.
    let responseBody = try? JSONSerialization.jsonObject(with: data)
    guard responseBody != nil else {
        throw BodyError.invalidFormat
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
            print("⚠️  \(error.code) -> Unable to select a random response!")
        case .unauthorized:
            print("🔐  \(error.code) -> Unauthorized.")
        case .serverError:
            print("💥  \(error.code) -> An internal server error has occured.")
        case .forbidden:
            print("⛔️  \(error.code) -> Access forbidden.")
        case .notFound:
            print("👀  \(error.code) -> Not found.")
        default:
            print("🤷🏼‍♂️ \(error.code) -> An unknown RequestError has occured with code:  \(error.code).")
        }
    } catch let error as BodyError {
        print("📝 An anomaly was detected with the response body:  \(error)")
    } catch let error {
        print("☠️  An unknown error has occured:  \(error)")
    }
}

requestHandler()
print("isLoading: \(isLoading)")
