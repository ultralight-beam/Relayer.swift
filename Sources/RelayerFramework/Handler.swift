import Foundation
import UB

/// The Handler is responsible for message handling.
/// This means routing it to the correct service and executing the service for a specific message.
public class Handler: UB.NodeDelegate {
    /// A list of services the handler knows
    public private(set) var services = [UBID: Service]()

    /// Initializes a new Handler.
    public init() { }

    // @todo there probably should be more stuff here at one point.

    /// :nodoc:
    public func node(_: Node, didReceiveMessage message: Message) {
        guard let service = services[message.service] else { return }
        service.node(node, didReceiveMessage: message)
    }
}
