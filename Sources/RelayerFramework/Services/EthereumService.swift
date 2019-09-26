import Foundation
import UB

public class EthereumService: Service {
    let url: URL
    
    /// Initializes an Ethereum Service with a RPC HTTP url
    public init(url: URL) {
        self.url = url
    }
    
    // handle gets called when an Ethereum service is called.
    public func handle(message: Message, node: Node) {
        // The first btye of the message is the JSONRPC method
        let methodID = String(data: message.message[0..<1], encoding: .utf8)!
        print(methodID)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        var payload: [String: Any] = ["jsonrpc": "2.0", "id": 1]
        
        var jsonPayload: Data
        
        
        switch methodID {
        case "0":
            let address = String(data: message.message[1..<message.message.count], encoding: .utf8)!
            getBalance(address: address){ result in
                switch result{
                case .success (let balance):
                    let messageResponse = Message(
                        proto: UBID(repeating: 1, count: 1),
                        recipient: message.origin,
                        from: message.recipient,
                        origin: message.recipient,
                        message: balance
                    )
                    node.send(messageResponse)
                case .failure (let error):
                    print(error)
                }
            }
        case "1":
            let address = String(data: message.message[1..<message.message.count], encoding: .utf8)!
            getTransactionCount(address: address){ result in
                switch result{
                case .success (let balance):
                    let messageResponse = Message(
                        proto: UBID(repeating: 1, count: 1),
                        recipient: message.origin,
                        from: message.recipient,
                        origin: message.recipient,
                        message: balance
                    )
                    node.send(messageResponse)
                case .failure (let error):
                    print(error)
                }
            }
        case "2":
            let signedTransaction = String(data: message.message[1..<message.message.count], encoding: .utf8)!
            sendRawTransaction(signedTransaction: signedTransaction){ result in
                switch result{
                case .success (let balance):
                    let messageResponse = Message(
                        proto: UBID(repeating: 1, count: 1),
                        recipient: message.origin,
                        from: message.recipient,
                        origin: message.recipient,
                        message: balance
                    )
                    node.send(messageResponse)
                case .failure (let error):
                    print(error)
                }
            }
            return
        default:
            print("default")
            return
        }
    }
    
    internal func httpRequest (request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        _ = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error!))
                return
            }
            completion(.success(data))
            }.resume()
    }
    
    internal func getBalance(address: String, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let payload: [String: Any] = ["jsonrpc": "2.0",
                                      "method": "eth_getBalance",
                                      "params":[address, "latest"],
                                      "id": 1]
        let jsonPayload = try! JSONSerialization.data(withJSONObject: payload)
        request.httpBody = jsonPayload
        
        httpRequest(request: request){ result in
            switch result {
            case .success (let balance):
                completion(.success(balance))
            case .failure (let error):
                completion(.failure(error))
            }
        }
    }
    
    internal func getTransactionCount(address: String, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let payload: [String: Any] = ["jsonrpc": "2.0",
                                      "method": "eth_getTransactionCount",
                                      "params":[address, "latest"],
                                      "id": 1]
        let jsonPayload = try! JSONSerialization.data(withJSONObject: payload)
        request.httpBody = jsonPayload
        
        httpRequest(request: request){ result in
            switch result {
            case .success (let nonce):
                completion(.success(nonce))
            case .failure (let error):
                completion(.failure(error))
            }
        }
    }
    
    internal func sendRawTransaction(signedTransaction: String, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let payload: [String: Any] = ["jsonrpc": "2.0",
                                      "method": "eth_sendRawTransaction",
                                      "params":[signedTransaction],
                                      "id": 1]
        let jsonPayload = try! JSONSerialization.data(withJSONObject: payload)
        request.httpBody = jsonPayload
        
        httpRequest(request: request){ result in
            switch result {
            case .success (let txHash):
                completion(.success(txHash))
            case .failure (let error):
                completion(.failure(error))
            }
        }
    }
}





