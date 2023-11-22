import CodableGraphicsMacros

@attached(member, names: arbitrary)
public macro CodableEnumsMacro() = #externalMacro(module: "CodableGraphicsMacros", type: "CodableEnumsMacro")

