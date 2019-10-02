import Foundation
import UB

public protocol Service {
    var identifier: UBID { get }
    func node(_ node: Node, didReceiveMessage message: Message)
}
