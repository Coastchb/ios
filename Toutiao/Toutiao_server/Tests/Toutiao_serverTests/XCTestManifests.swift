import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Toutiao_serverTests.allTests),
    ]
}
#endif
