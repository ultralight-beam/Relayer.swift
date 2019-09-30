import Foundation
import UB
import RelayerFramework

let handler = Handler()

let node = UB.Node()
let t = CoreBluetoothTransport()
node.delegate = handler
node.add(transport: t)

func input() -> String {
    
    let keyboard = FileHandle.standardInput
    
    let inputData = keyboard.availableData
    
    let strData = String(data: inputData, encoding: .utf8)
    
    return strData!
    
}

func read() -> String {
    let c = CharacterSet.whitespacesAndNewlines
    return input().trimmingCharacters(in: c)
}

while true {
    let message = read()
    if message == "" {
        continue
    }

    guard let data = message.data(using: .utf8) else { continue }
    node.send(
        Message( // bunch of dummy fields for now as we don't do identity
            proto: UBID(repeating: 1, count: 1),
            recipient: UBID(repeating: 1, count: 1),
            from: UBID(repeating: 1, count: 1),
            origin: UBID(repeating: 1, count: 1),
            message: data
        )
    )

}

//RunLoop.current.run()
