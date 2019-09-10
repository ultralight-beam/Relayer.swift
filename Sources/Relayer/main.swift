import Foundation
import UB

let handler = Handler()

let node = UB.Node()
node.delegate = handler
node.add(transport: CoreBluetoothTransport())

RunLoop.current.run()
