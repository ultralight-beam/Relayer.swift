import Foundation
import UB
// import web3

class EthereumService: Service {
    let url: URL
    
    /// Initializes an Ethereum Service with a RPC HTTP url
    init(url: URL) {
        self.url = url
    }
    
    // handle gets called when an Ethereum service is called.
    func handle(message: Message, node: Node) {
        // The first btye of the message is the JSONRPC method
        let methodID = message.message[0]
        
        let url = URL(string: "https://rinkeby.infura.io/f7a08ae0242843f1b1cf480454a6bba5")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        var payload: [String: Any] = ["jsonrpc": "2.0", "id": 1]
        
        var jsonPayload: Data

        
        switch methodID {
        case 0:
            let address = String(data: message.message[1..<22], encoding: .utf8)!
            payload["method"] = "eth_getBalance"
            payload["params"] = [address, "latest"]

            jsonPayload = try! JSONSerialization.data(withJSONObject: payload)
            request.httpBody = jsonPayload
            
        case 1:
            print("eth_getTxCount not impled")
            return
        case 2:
            //eth.sendRawTx
            print("eth_sendRawTx not impled")
            return
        default:
            print("default")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let messageResponse = Message(
                proto: UBID(repeating: 1, count: 1),
                recipient: message.origin,
                from: message.recipient,
                origin: message.recipient,
                message: data
            )
            node.send(messageResponse)
        }
        task.resume()
    }
}




