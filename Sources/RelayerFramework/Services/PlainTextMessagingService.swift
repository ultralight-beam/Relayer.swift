import Foundation
import UB

/// Basic service for receiving plain text messages from other nodes.
public class PlainTextMessagingService: Service {

    /// :nodoc:
    public var identifier = UBID(repeating: 1, count: 1)

    /// Initializes a new PlainTextMessagingService
    public init() { }

    /// :nodoc:
    public func node(_ node: Node, didReceiveMessage message: Message) {
        guard let data = String(data: message.message, encoding: .utf8) else { return }
        print(data)
    }

}
