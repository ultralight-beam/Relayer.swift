import Foundation
import UB
import RelayerFramework

let handler = Handler()

let node = UB.Node()
node.delegate = handler
node.add(transport: CoreBluetoothTransport())

// @todo handle CLI input, repl

RunLoop.current.run()
