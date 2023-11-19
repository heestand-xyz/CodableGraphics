
public protocol CodableGraphic {
    var type: CodableGraphicType { get }
    var properties: [AnyGraphicProperty] { get }
}
