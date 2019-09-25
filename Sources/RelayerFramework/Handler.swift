import Foundation
import UB

/// The Handler is responsible for message handling.
/// This means routing it to the correct service and executing the service for a specific message.
public class Handler: UB.NodeDelegate {
    fileprivate var services = [UB.UBID: Service]()

    /// Initializes a new Handler.
    public init() { }

    // @todo there probably should be more stuff here at one point.

    /// :nodoc:
    public func node(_ node: Node, didReceiveMessage message: Message) {
        // @todo check if the message was just sent to us
        if message.proto.count == 0 {
            return
        }

        guard let service = services[message.proto] else { return }
        service.handle(message: message, node: node)
    }
}
