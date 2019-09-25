import Foundation
import UB

let handler = Handler()

let node = UB.Node()
node.delegate = handler
node.add(transport: CoreBluetoothTransport())

// @todo handle CLI input, repl


let url = URL(string: "https://rinkeby.infura.io/f7a08ae0242843f1b1cf480454a6bba5")!
var request = URLRequest(url: url)

request.httpMethod = "POST"

var payload: [String: Any]
var jsonPayload: Data

//let address = String(data: message.message[1..<22], encoding: .utf8)!
payload = ["jsonrpc": "2.0",
           "method": "eth_getBalance",
           "params":["0x0F64928EcA02147075c7614A7d67B0C3Cb37D5DA", "latest"],
           "id": 1]
jsonPayload = try! JSONSerialization.data(withJSONObject: payload)
request.httpBody = jsonPayload



let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
    }
    print("reponse \(String(data: data, encoding: .utf8)!))")
}

print("heres")
task.resume()
print("WHATS THIS")
RunLoop.current.run()
