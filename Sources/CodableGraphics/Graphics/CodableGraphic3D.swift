
public protocol CodableGraphic3D {
    var type: CodableGraphic3DType { get }
    var properties: [any AnyGraphicProperty] { get }
}
