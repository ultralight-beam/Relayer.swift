import Foundation
import UB

/// Basic service for receiving plain text messages from other nodes.
public class PlainTextMessagingService: Service {

    /// :nodoc:
    public func handle(message: UB.Message) {
        guard let data = String(data: message.message, encoding: .utf8) else { return }

        // @todo probably more info like from etc.
        print(data)

    }

}
