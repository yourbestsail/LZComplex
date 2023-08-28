import XCTest
@testable import LZComplex

final class LZComplexTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
        
        let c: LZComplex = LZComplex(re: 2, im: 4)
        print(c)
    }
}
