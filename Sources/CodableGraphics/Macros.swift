import CodableGraphicsMacros

@attached(memberAttribute)
public macro CodableGraphicMacro() = #externalMacro(module: "CodableGraphicsMacros", type: "CodableGraphicMacro")

