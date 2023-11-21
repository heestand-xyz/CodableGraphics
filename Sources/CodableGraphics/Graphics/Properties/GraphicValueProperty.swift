import Foundation
import simd
import PixelColor

@propertyWrapper
public class GraphicValueProperty<T: GraphicValue>: GraphicProperty {
    
    public var valueType: GraphicValue.Type { T.self }
    
    public let key: String
    public let name: String
    
    public var wrappedValue: GraphicMetadata<T>
    
    public init(
        wrappedValue: GraphicMetadata<T>,
        key: String,
        name: String
    ) {
        self.key = key
        self.name = name
        self.wrappedValue = wrappedValue
    }
}

extension GraphicValueProperty {

    public func erase() -> AnyGraphicProperty {
        AnyGraphicProperty(
            type: type,
            key: key,
            name: name,
            value: wrappedValue.value,
            defaultValue: wrappedValue.defaultValue,
            minimumValue: wrappedValue.minimumValue,
            maximumValue: wrappedValue.maximumValue
        ) { [weak self] value in
            self?.wrappedValue.value = value!
        }
    }
}
