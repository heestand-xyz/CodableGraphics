import Foundation
import simd
import PixelColor

public protocol GraphicProperty {
    var valueType: GraphicValue.Type { get }
    var key: String { get }
    var name: String { get }
    func erase() -> AnyGraphicProperty
}

extension GraphicProperty {
    
    public var type: GraphicValueType {
        switch valueType {
        case is Bool.Type:
            return .bool
        case is Int.Type:
            return .int
        case is Double.Type:
            return .double
        case is PixelColor.Type:
            return .color
        case is CGSize.Type:
            return .size
        case is CGPoint.Type:
            return .point
        case is CGRect.Type:
            return .rect
        case is SIMD3<Int>.Type:
            return .intVector
        case is SIMD3<Double>.Type:
            return .doubleVector
        default:
            fatalError("Unsupported Graphic Property Type")
        }
    }
}
