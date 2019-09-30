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
    public func node(_: Node, didReceiveMessage message: Message) {
        // @todo check if the message was just sent to us
        if message.service.count == 0 {
            return
        }

        guard let data = String(data: message.message, encoding: .utf8) else { return }

        // @todo probably more info like from etc.
        print(data)

        guard let service = services[message.service] else { return }
        service.handle(message: message)
    }
}
