import CoreGraphics
import simd

public enum GraphicMetadataValue<T: GraphicValue>: Codable {
    
    case fixed(T)
    
    case resolution
    case resolutionCenter
    case resolutionMinimum(fraction: CGFloat)
    case resolutionMaximum(fraction: CGFloat)
    
    func at(resolution: CGSize) -> T {
        switch self {
        case .fixed(let value):
            return value
        case .resolution:
            if T.self == CGPoint.self {
                return CGPoint(x: resolution.width,
                               y: resolution.height) as! T
            } else if T.self == CGRect.self {
                return CGRect(origin: .zero,
                              size: resolution) as! T
            }
            fatalError("Resolution Not Supported")
        case .resolutionCenter:
            if T.self == CGPoint.self {
                return CGPoint(x: resolution.width / 2,
                               y: resolution.height / 2) as! T
            }
            fatalError("Resolution Center Not Supported")
        case .resolutionMinimum(let fraction):
            let minimum: CGFloat = min(resolution.width, resolution.height)
            return .lerp(at: fraction, from: .zero, to: .one.scaled(by: minimum))
        case .resolutionMaximum(let fraction):
            let maximum: CGFloat = max(resolution.width, resolution.height)
            return .lerp(at: fraction, from: .zero, to: .one.scaled(by: maximum))
        }
    }
    
    func at(resolution: SIMD3<Int>) -> T {
        switch self {
        case .fixed(let value):
            return value
        case .resolution:
            if T.self == SIMD3<Int>.self {
                return resolution as! T
            } else if T.self == SIMD3<Double>.self {
                return SIMD3<Double>(resolution) as! T
            }
            fatalError("Resolution Not Supported")
        case .resolutionCenter:
            if T.self == SIMD3<Double>.self {
                return SIMD3<Double>(Double(resolution.x) / 2,
                                     Double(resolution.y) / 2,
                                     Double(resolution.z) / 2) as! T
            }
            fatalError("Resolution Center Not Supported")
        case .resolutionMinimum(let fraction):
            let minimum = Double(min(min(resolution.x, resolution.y), resolution.z))
            return .lerp(at: fraction, from: .zero, to: .one.scaled(by: minimum))
        case .resolutionMaximum(let fraction):
            let maximum = Double(max(max(resolution.x, resolution.y), resolution.z))
            return .lerp(at: fraction, from: .zero, to: .one.scaled(by: maximum))
        }
    }
}
