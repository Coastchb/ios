import XCTest
@testable import Toutiao_server

final class Toutiao_serverTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Toutiao_server().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
