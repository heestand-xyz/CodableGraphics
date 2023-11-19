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
    public var defaultValue: T?
    public var minimumValue: T?
    public var maximumValue: T?
    
    public init(
        wrappedValue: T,
        key: String,
        name: String,
        minimum: T? = nil,
        maximum: T? = nil
    ) {
        self.key = key
        self.name = name
        self.wrappedValue = wrappedValue
        defaultValue = wrappedValue
        minimumValue = minimum
        maximumValue = maximum
    }
}

extension GraphicValueProperty {

    public func erase() -> AnyGraphicProperty {
        AnyGraphicProperty(
            type: type, 
            key: key,
            name: name,
            value: wrappedValue,
            defaultValue: defaultValue,
            minimumValue: minimumValue,
            maximumValue: maximumValue
        ) { [weak self] value in
            self?.wrappedValue = value!
        }
    }
}
