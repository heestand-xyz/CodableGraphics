
public protocol CodableGraphic {
    var type: CodableGraphicType { get }
    var properties: [any AnyGraphicProperty] { get }
}
