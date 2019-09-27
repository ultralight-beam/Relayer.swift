@testable import RelayerFramework
import XCTest

final class RelayerFrameworkTests: XCTestCase {
    func testGetBalance() {
        let didFinish = self.expectation(description: #function)
        let url: URL = URL(string: "https://rinkeby.infura.io/f7a08ae0242843f1b1cf480454a6bba5")!
        let ethService = EthereumService(url: url)
        var bal = ""
        ethService.getBalance(address: "0x0F64928EcA02147075c7614A7d67B0C3Cb37D5DA") { result in
            switch result {
            case let .success(balance):
                bal = String(data: balance, encoding: .utf8)!
                didFinish.fulfill()
            case let .failure(error):
                print(error)
            }
        }

        wait(for: [didFinish], timeout: 5)
        XCTAssertEqual(bal, "{\"jsonrpc\":\"2.0\",\"id\":1,\"result\":\"0x1a55734bf06dc800\"}")
    }

    static var allTests = [
        ("testGetBalance", testGetBalance),
    ]
}
