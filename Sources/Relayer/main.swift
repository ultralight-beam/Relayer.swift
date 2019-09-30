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
    print(t.peers)
    print(read())
}

//RunLoop.current.run()
