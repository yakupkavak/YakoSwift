import YakoSwift

let a = 17
let b = 25

let (result, code) = #stringify(a + b)

print("The value \(result) was produced by the code \"\(code)\"")

class YakoTest {
    private let debug = #debugMacroNodeContext()
    
    func debugMacroInFunction() {
        print("Within Function: \n", #debugMacroNodeContext(), "------------------")
    }
    
    func containerFunction() {
        print(#containerName)
    }
}

let yako = YakoTest()
//yako.debugMacroInFunction()
yako.containerFunction()
