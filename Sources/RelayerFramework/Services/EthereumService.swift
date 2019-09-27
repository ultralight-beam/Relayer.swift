import Foundation
import UB

public class EthereumService: Service {
    let url: URL

    /// Initializes an Ethereum Service with a RPC HTTP url
    ///
    /// - Parameters:
    ///     - url: Ethereum JSONRPC endpoint
    public init(url: URL) {
        self.url = url
    }

    public func handle(message: Message, node: Node) {
        // The first btye of the message is the JSONRPC method
        let methodID = message.message[0]

        switch methodID {
        case 0:
            let address = "0x" + message.message[1 ..< message.message.count].hexEncodedString()
            getBalance(address: address) { result in
                switch result {
                case let .success(balance):
                    let messageResponse = Message(
                        proto: UBID(repeating: 1, count: 1),
                        recipient: message.origin,
                        from: message.recipient,
                        origin: message.recipient,
                        message: balance
                    )
                    node.send(messageResponse)
                case let .failure(error):
                    print(error)
                }
            }
        case 1:
            let address = "0x" + message.message[1 ..< message.message.count].hexEncodedString()
            getTransactionCount(address: address) { result in
                switch result {
                case let .success(nonce):
                    let messageResponse = Message(
                        proto: UBID(repeating: 1, count: 1),
                        recipient: message.origin,
                        from: message.recipient,
                        origin: message.recipient,
                        message: nonce
                    )
                    node.send(messageResponse)
                case let .failure(error):
                    print(error)
                }
            }
        case 2:
            let signedTransaction = "0x" + message.message[1 ..< message.message.count].hexEncodedString()
            sendRawTransaction(signedTransaction: signedTransaction) { result in
                switch result {
                case let .success(balance):
                    let messageResponse = Message(
                        proto: UBID(repeating: 1, count: 1),
                        recipient: message.origin,
                        from: message.recipient,
                        origin: message.recipient,
                        message: balance
                    )
                    node.send(messageResponse)
                case let .failure(error):
                    print(error)
                }
            }
            return
        default:
            print("default")
            return
        }
    }

    internal func httpRequest(method: String, params: [String], completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let payload: [String: Any] = [
            "jsonrpc": "2.0",
            "method": method,
            "params": params,
            "id": 1
        ]
        let jsonPayload = try! JSONSerialization.data(withJSONObject: payload)
        request.httpBody = jsonPayload
        
        _ = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }.resume()
    }

    internal func getBalance(address: String, completion: @escaping (Result<Data, Error>) -> Void) {
        httpRequest(method: "eth_getBalance", params: [address, "latest"]) { result in
            switch result {
            case let .success(balance):
                completion(.success(balance))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    internal func getTransactionCount(address: String, completion: @escaping (Result<Data, Error>) -> Void) {
        httpRequest(method: "eth_getTransactionCount", params: [address, "latest"]) { result in
            switch result {
            case let .success(nonce):
                completion(.success(nonce))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    internal func sendRawTransaction(signedTransaction: String, completion: @escaping (Result<Data, Error>) -> Void) {
        httpRequest(method: "eth_sendRawTransaction", params: [signedTransaction]) { result in
            switch result {
            case let .success(txHash):
                completion(.success(txHash))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
