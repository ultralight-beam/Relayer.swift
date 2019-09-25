import Foundation
import UB
import Library

let handler = Library.Handler()

let node = UB.Node()
node.delegate = handler
node.add(transport: CoreBluetoothTransport())

// @todo handle CLI input, repl

RunLoop.current.run()
