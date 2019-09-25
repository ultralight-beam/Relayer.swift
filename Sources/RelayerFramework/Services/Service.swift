import Foundation
import UB

/// Services are responsible for handling messages received from an Ultralight Beam node.
public protocol Service: AnyObject {
    /// Handles a specific ultralight beam message.
    ///
    /// - Parameters:
    ///     - message: The received message to handle.
    func handle(message: UB.Message)
}
