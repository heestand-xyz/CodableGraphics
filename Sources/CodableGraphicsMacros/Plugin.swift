import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct CodableGraphicsMacros: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CodableGraphicMacro.self,
    ]
}
