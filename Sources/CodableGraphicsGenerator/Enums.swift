import AsyncGraphics

enum X: String, CaseIterable {
    case x
}

//@CodableEnumsMacro
struct Enums {
    
    static let enumables: [ErasedEnumable] = [
        Enumable(Graphic.LineCap.self).erase(),
        Enumable(X.self).erase()
    ]
}
