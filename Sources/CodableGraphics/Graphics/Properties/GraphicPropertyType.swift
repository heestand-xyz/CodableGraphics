import Foundation
import simd
import PixelColor
import SwiftUI

public enum GraphicPropertyType {
    case bool
    case int
    case double
    case angle
    case color
    case size
    case point
    case rect
    case intVector
    case doubleVector
//    case gradient
}

extension GraphicPropertyType {
    var rawType: Codable.Type {
        switch self {
        case .bool:
            return Bool.self
        case .int:
            return Int.self
        case .double:
            return Double.self
        case .color:
            return PixelColor.self
        case .size:
            return CGSize.self
        case .point:
            return CGPoint.self
        case .rect:
            return CGRect.self
        case .intVector:
            return SIMD3<Int>.self
        case .doubleVector:
            return SIMD3<Double>.self
        case .angle:
            return Angle.self
//        case .gradient:
//            return ...
        }
    }
}
