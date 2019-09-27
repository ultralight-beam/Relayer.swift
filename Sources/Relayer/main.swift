import Foundation
import RelayerFramework
import UB

let handler = Handler()

let node = UB.Node()
node.delegate = handler
node.add(transport: CoreBluetoothTransport())

// @todo handle CLI input, repl
let service = EthereumService(url: URL(string: "https://rinkeby.infura.io/f7a08ae0242843f1b1cf480454a6bba5")!)

// Get Balance
let msg = Message(
    proto: UBID(repeating: 1, count: 1),
    recipient: Addr(repeating: 1, count: 1),
    from: Addr(repeating: 1, count: 1),
    origin: UBID(repeating: 1, count: 1),
    message: "000F64928EcA02147075c7614A7d67B0C3Cb37D5DA".hexDecodedData()
)

service.handle(message: msg, node: node)

RunLoop.current.run()
