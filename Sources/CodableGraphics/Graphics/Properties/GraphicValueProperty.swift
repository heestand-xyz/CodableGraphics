import Foundation
import simd
import PixelColor

@propertyWrapper
public class GraphicValueProperty<T: Codable>: GraphicProperty {
    
    public var valueType: Codable.Type {
        Swift.type(of: wrappedValue)
    }
    
    public let key: String
    public let name: String
    public var wrappedValue: T
    
    public init(wrappedValue: T, key: String, name: String) {
        self.key = key
        self.name = name
        self.wrappedValue = wrappedValue
    }
}

extension GraphicValueProperty {

    public func erase() -> AnyGraphicProperty {
        AnyGraphicProperty(type: type, key: key, name: name, value: wrappedValue) { [weak self] value in
            self?.wrappedValue = value!
        }
    }
}
