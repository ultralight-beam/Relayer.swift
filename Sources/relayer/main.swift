import Foundation
import RelayerFramework
import UB

let node = Node()

let handler = Handler()
node.delegate = handler

handler.add(service: PlainTextMessagingService())

node.add(transport: CoreBluetoothTransport())

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
