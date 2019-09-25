import Foundation
import UB

/// Services are responsible for handling messages received from an Ultralight Beam node.
protocol Service: AnyObject {
    func handle(message: UB.Message, node: UB.Node)
}
