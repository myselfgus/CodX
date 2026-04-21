import XCTest
@testable import Core

final class CoreTests: XCTestCase {
    func testKernelBootstraps() {
        XCTAssertNotNil(AppKernel())
    }
}
