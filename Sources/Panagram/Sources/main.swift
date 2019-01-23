import Foundation

let panagram = Panagram()
if CommandLine.argc < 2 {
    panagram.interactiveMode()
} else {
    panagram.staticMode()
}


//print("Hello, world!")
//let jazzyTool = JazzyTool()
//jazzyTool.generatesAllDoc()
