import CodableGraphicsMacros

@attached(member, names: arbitrary)
@attached(memberAttribute)
public macro CodableGraphicMacro() = #externalMacro(module: "CodableGraphicsMacros", type: "CodableGraphicMacro")

