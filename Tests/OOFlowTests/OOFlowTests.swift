import XCTest
@testable import OOFlow

final class OOFlowTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OOFlow().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
