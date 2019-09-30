import Foundation
import UB
import RelayerFramework

let handler = Handler()

let node = UB.Node()
let t = CoreBluetoothTransport()
node.delegate = handler
node.add(transport: t)

while let line = readLine() {
    guard let message = line.data(using: .utf8) else { continue }
    node.send(
        Message( // bunch of dummy fields for now as we don't do identity
            proto: UBID(repeating: 1, count: 1),
            recipient: UBID(repeating: 1, count: 1),
            from: UBID(repeating: 1, count: 1),
            origin: UBID(repeating: 1, count: 1),
            message: message
        )
    )
}
