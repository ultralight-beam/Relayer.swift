import Foundation
import UB

/// An interface used to handle messages for a specific service.
public protocol Service: NodeDelegate {
    /// The identifier of the service.
    var identifier: UBID { get }
}
