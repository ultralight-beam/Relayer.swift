import Foundation
import UB
import RelayerFramework

let node = Node()

let handler = Handler()
node.delegate = handler

node.add(transport: CoreBluetoothTransport())

node.add(service: PlainTextMessagingService())

while let line = readLine() {
    guard let message = line.data(using: .utf8) else { continue }
    // bunch of dummy fields for now as we don't do identity
    node.send(
        Message(
            service: UBID(repeating: 1, count: 1),
            recipient: UBID(repeating: 0, count: 0),
            from: UBID(repeating: 1, count: 1),
            origin: UBID(repeating: 1, count: 1),
            message: message
        )
    )
}
