import Foundation
import UB

/// The Handler is responsible for message handling.
/// This means routing it to the correct service and executing the service for a specific message.
public class Handler: UB.NodeDelegate {
    /// Initializes a new Handler.
    public init() { }

    // @todo there probably should be more stuff here at one point.

    /// :nodoc:
    public func node(_: Node, didReceiveMessage message: Message) {
        // @todo
    }
}
