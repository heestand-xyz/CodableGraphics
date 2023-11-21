import CoreGraphics

public struct GraphicMetadata<T: GraphicValue>: Codable {
    
    public enum Value: Codable {
        
        case zero
        case one
        
        case fixed(T)
        
        case minimum(fraction: CGFloat)
        case maximum(fraction: CGFloat)
        
        case width(fraction: CGFloat)
        case height(fraction: CGFloat)
        
        func value(resolution: CGSize) -> T {
            switch self {
            case .zero:
                return .zero
            case .one:
                return .one
            case .fixed(let value):
                return value
            case .minimum(let fraction):
                let minimum: CGFloat = min(resolution.width, resolution.height)
                return .lerp(at: fraction, from: .zero, to: .one.scaled(by: minimum))
            case .maximum(let fraction):
                let maximum: CGFloat = max(resolution.width, resolution.height)
                return .lerp(at: fraction, from: .zero, to: .one.scaled(by: maximum))
            case .width(let fraction):
                let width: CGFloat = resolution.width
                return .lerp(at: fraction, from: .zero, to: .one.scaled(by: width))
            case .height(let fraction):
                let height: CGFloat = resolution.height
                return .lerp(at: fraction, from: .zero, to: .one.scaled(by: height))
            }
        }
    }
    
    public var value: T
    public var defaultValue: T
    
    public let minimumValue: Value?
    public let maximumValue: Value?
    
    public init(value: T, minimum: Value? = nil, maximum: Value? = nil) {
        self.value = value
        defaultValue = value
        minimumValue = minimum
        maximumValue = maximum
    }
}
